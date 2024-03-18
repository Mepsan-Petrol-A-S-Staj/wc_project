// library pattern_page;
// export 'admin_page.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:wc_project/shared/constant_shared.dart';

import '../services/provider/all_provider.dart';
import '../services/controllers/patternpage_controller.dart';
import '../widgets/appbar_widget.dart';

class PatternPage extends ConsumerStatefulWidget {
  final double height, width;

  const PatternPage({
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PatternPage> createState() => _PatternPageState();
}

class _PatternPageState extends ConsumerState<PatternPage> {
  // late StreamSubscription<bool> keyboardSubscription;
  late int pageIndex;
  String ipAddress = "";

  Future<void> updateIpAddress(WidgetRef ref) async {
    const Duration updateInterval = Duration(minutes: 5);
    while (true) {
      await Future.delayed(updateInterval);
      if (mounted) {
        ipAddress = await PatternPageController().getIpAddress(ref);
      }
    }
  }

  @override
  void initState() {
    pageIndex = 0;
    PatternPageController().sharedPreferanceStart(ref);
    updateIpAddress(ref);
    super.initState();
  }

  @override
  void dispose() {
    // keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pageIndex = ref.watch(pageIndexProvider);
    return Consumer(
      builder: (context, ref, child) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (pageIndex == 0 || pageIndex == 3) {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Uygulamadan çıkış yapamazsınız.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Kapat'),
                    ),
                  ],
                ),
              );
            } else {
              ref.read(pageIndexProvider.notifier).update((state) => 0);
            }
          },
          child: Scaffold(
            extendBody: true,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.height > widget.width
                      ? widget.width * SharedConstants.generalPadding
                      : widget.height * SharedConstants.generalPadding,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: widget.height > widget.width
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
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          // reverse: true,
                          physics: const BouncingScrollPhysics(),
                          child: PatternPageController().buildPage(
                            pageIndex,
                            widget.height,
                            widget.width,
                          ),
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
