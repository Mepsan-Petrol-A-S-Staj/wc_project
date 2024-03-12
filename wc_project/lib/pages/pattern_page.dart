import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:wc_project/pages/devicesave_page.dart';
import 'package:wc_project/pages/task_page.dart';
import 'package:wc_project/shared/constants_shared.dart';

import '../services/all_provider.dart';
import 'home_page.dart';
import 'login_page.dart';

class PatternPage extends ConsumerWidget {
  final double height, width;

  const PatternPage({
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        int index = ref.watch(pageIndexProvider);
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (index == 0) {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Uygulamadan çıkmak istiyor musunuz?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Hayır'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Evet'),
                    ),
                  ],
                ),
              );
            } else {
              didPop ? null : null;
            }
          },
          child: Scaffold(
            extendBody: true,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * SharedConstants.generalPadding,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * SharedConstants.generalPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            child: SvgPicture.asset(
                              SharedConstants.logoImageRoute,
                              height: height * SharedConstants.bigSize * 1.20,
                            ),
                            onTap: () {
                              index == 3
                                  ? null
                                  : ref
                                      .read(pageIndexProvider.notifier)
                                      .update((state) => 0);
                            },
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.person_outline,
                                  size: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .fontSize! *
                                      1.4,
                                ),
                                onPressed: () {
                                  index == 3
                                      ? null
                                      : ref
                                          .read(pageIndexProvider.notifier)
                                          .update((state) => 1);
                                },
                              ),
                              DigitalClock(
                                hourMinuteDigitTextStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                                secondDigitTextStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                colon: Text(
                                  ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      // flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * SharedConstants.generalPadding,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: _buildPage(index),
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

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomePage(height: height, width: width);
      // return LoginPage(height: height, width: width);
      case 1:
        return LoginPage(height: height, width: width);
      case 2:
        return TaskPage(height: height, width: width);
      case 3:
        return DeviceSavePage(height: height, width: width);
      default:
        return Container();
    }
  }
}
