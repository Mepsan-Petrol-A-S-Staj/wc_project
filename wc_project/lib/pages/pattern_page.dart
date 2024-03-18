import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:wc_project/pages/admin_page.dart';
import 'package:wc_project/shared/constant_shared.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_project/pages/devicesave_page.dart';
import 'package:wc_project/pages/task_page.dart';
import 'package:wc_project/shared/theme_shared.dart';

import '../services/provider/all_provider.dart';
import '../services/controllers/patternpage_controller.dart';
import 'home_page.dart';
import 'login_page.dart';

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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            child: SvgPicture.asset(
                              SharedConstants.logoImageRoute,
                              height: widget.height > widget.width
                                  ? widget.width * SharedConstants.bigSize * 1.1
                                  : widget.height *
                                      SharedConstants.bigSize *
                                      1.1,
                            ),
                            onTap: () {
                              pageIndex == 3
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
                                  Icons.logout_outlined,
                                  size: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .fontSize! *
                                      1.4,
                                ),
                                onPressed: () {
                                  pageIndex == 3
                                      ? null
                                      : ref
                                          .read(pageIndexProvider.notifier)
                                          .update((state) => 1);
                                },
                              ),
                              DigitalClock(
                                hourMinuteDigitTextStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                secondDigitTextStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                colon: Text(
                                  ":",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                              ),
                            ],
                          ),
                        ],
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
