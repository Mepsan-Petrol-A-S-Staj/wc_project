import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:wc_project/shared/theme_shared.dart';
import '../services/controllers/appbar_controller.dart';
import '../shared/constant_shared.dart';

class AppBarWidget extends StatelessWidget {
  final double height, width;
  final int pageIndex;
  final WidgetRef ref;
  const AppBarWidget({
    required this.height,
    required this.width,
    required this.pageIndex,
    required this.ref,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppBarController controller = AppBarController(ref: ref);
    return Consumer(builder: (context, ref, child) {
      IconData iconData = controller.appbarLoginorLogutButton();
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: SvgPicture.asset(
              SharedConstants.logoImageRoute,
              height: height > width
                  ? width * SharedConstants.bigSize * 1.1
                  : height * SharedConstants.bigSize * 1.1,
            ),
            onTap: () {
              controller.logoorLoginClick(pageIndex, 0);
            },
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  iconData,
                  size: Theme.of(context).textTheme.headlineMedium!.fontSize! *
                      1.4,
                ),
                onPressed: () {
                  controller.logoorLoginClick(pageIndex, 1);
                },
              ),
              DigitalClock(
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
            ],
          ),
        ],
      );
    });
  }
}
