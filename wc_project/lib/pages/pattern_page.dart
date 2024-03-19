// library pattern_page;
// export 'admin_page.dart';

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/shared/constant_shared.dart';
import 'package:wc_project/widgets/exitapp_widget.dart';

import '../services/controllers/size_controller.dart';
import '../services/provider/all_provider.dart';
import '../services/controllers/patternpage_controller.dart';
import '../widgets/appbar_widget.dart';

class PatternPage extends ConsumerStatefulWidget {
  final double height, width;

  const PatternPage({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  ConsumerState<PatternPage> createState() => _PatternPageState();
}

class _PatternPageState extends ConsumerState<PatternPage> {
  // late StreamSubscription<bool> keyboardSubscription;
  late int pageIndex;
  String ipAddress = "";

  @override
  void initState() {
    pageIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Future<void> updateIpAddress(WidgetRef ref) async {
      const Duration updateInterval = Duration(minutes: 5);
      while (true) {
        await Future.delayed(updateInterval);
        if (mounted) {
          ipAddress = await PatternPageController(
                  height: widget.height, width: widget.width, ref: ref)
              .getIpAddress();
        }
      }
    }

    PatternPageController patternPageController = PatternPageController(
      height: widget.height,
      width: widget.width,
      ref: ref,
    );
    patternPageController.sharedPreferanceStart();
    updateIpAddress(ref);
    SizeController sizeController = SizeController(
      height: widget.height,
      width: widget.width,
    );
    pageIndex = ref.watch(pageIndexProvider);
    return Consumer(
      builder: (context, ref, child) {
        int deviceType = sizeController.getScreenType(mediaQueryData);
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (pageIndex == 0 || pageIndex == 3) {
              await ExitAppWidget.exitAppShowDialog(context);
            } else {
              ref.read(pageIndexProvider.notifier).update((state) => 0);
            }
          },
          child: Scaffold(
            extendBody: true,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceType > 0
                      ? widget.width * SharedConstants.generalPadding
                      : widget.height * SharedConstants.generalPadding,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: deviceType > 0
                            ? widget.width * SharedConstants.generalPadding
                            : widget.height * SharedConstants.generalPadding,
                      ),
                      child: AppBarWidget(
                        height: widget.height,
                        width: widget.width,
                        pageIndex: pageIndex,
                        ref: ref,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: widget.height * SharedConstants.generalPadding,
                        ),
                        child: patternPageController.buildPage(
                          pageIndex,
                          widget.height,
                          widget.width,
                          deviceType,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
