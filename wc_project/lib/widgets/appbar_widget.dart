import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import '../services/controllers/appbar_controller.dart';
import '../shared/constant_shared.dart';

class AppBarWidget extends StatelessWidget {
  final double height, width;
  final int pageIndex,screenType;
  final WidgetRef ref;
  const AppBarWidget({
    required this.height,
    required this.width,
    required this.pageIndex,
    required this.screenType,
    required this.ref,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // MediaQueryData mediaQueryData = MediaQuery.of(context);
    AppBarController controller = AppBarController(ref: ref);

    return Consumer(builder: (context, ref, child) {
      // int screenType = sizeController.getScreenType(mediaQueryData);
      IconData iconData = controller.appbarLoginorLogutButton();
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: screenType == 0 ? 1 : 3,
            child: InkWell(
              child: SvgPicture.asset(
                alignment: Alignment.centerLeft,
                SharedConstants.logoImageRoute,
                height: screenType == 0
                    ? height * SharedConstants.bigSize
                    : width * SharedConstants.bigSize,
                // height: height > width
                //     ? width * SharedConstants.bigSize * 1.1
                //     : height * SharedConstants.bigSize * 1.1,
              ),
              onTap: () {
                controller.logoorLoginClick(pageIndex, 0);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      iconData,
                      size: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .fontSize! *
                          1.4,
                    ),
                    onPressed: () {
                      controller.logoorLoginClick(pageIndex, 1);
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: DigitalClock(
                    hourMinuteDigitTextStyle:
                        Theme.of(context).textTheme.displayLarge,
                    secondDigitTextStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: SharedConstants.primaryColor,
                            ),
                    colon: Text(
                      ":",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: SharedConstants.primaryColor,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
