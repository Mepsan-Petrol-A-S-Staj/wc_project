import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/shared/constant_shared.dart';
import '../services/controllers/size_controller.dart';
import '../services/provider/all_provider.dart';
import '../services/controllers/pages/patternpage_controller.dart';
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
  late int pageIndex;
  late String ipAddress;
  late PatternPageController patternPageController;

  @override
  void initState() {
    patternPageController = PatternPageController(
      ref: ref,
    );
    patternPageController.sharedPreferanceStart();
    pageIndex = 0;
    ipAddress = '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    SizeController sizeController = SizeController(
      height: mediaQueryData.size.height,
      width: mediaQueryData.size.width,
    );

    patternPageController.updateIpAddress();

    pageIndex = ref.watch(pageIndexProvider);

    return Consumer(
      builder: (context, ref, child) {
        int deviceType = sizeController.getScreenType(mediaQueryData);
        
        return PopScope(
          canPop: false,
          onPopInvoked: patternPageController.onPopInvoked,
          child: Scaffold(
            extendBody: true,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceType > 0
                      ? widget.width * SharedConstants.generalPadding
                      : widget.width * SharedConstants.mediumPadding,
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
                        screenType: deviceType,
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
            floatingActionButton: patternPageController.buildFabWidget(
              pageIndex,
              widget.height,
              widget.width,
            ),
          ),
        );
      },
    );
  }
}
