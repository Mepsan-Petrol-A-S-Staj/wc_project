import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wc_project/shared/constant_shared.dart';
import 'package:wc_project/shared/list_shared.dart';

import '../services/provider/all_provider.dart';

class HomePage extends StatelessWidget {
  final double height;
  final double width;

  const HomePage({
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        int value = ref.watch(rateProvider);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < SharedList.welcomeTextList.length; i++)
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: i == 0 ? 0 : height * SharedConstants.mediumPadding,
                ),
                child: Text(
                  SharedList.welcomeTextList[i],
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color:
                            i == 0 ? null : SharedConstants.secondaryTextColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(
                  width * SharedConstants.mediumPadding,
                ),
              ),
              child: RatingStars(
                value: value.toDouble(),
                onValueChanged: (v) {
                  ref.read(rateProvider.notifier).update((state) => v.toInt());
                },
                starBuilder: (index, color) => Icon(
                  AntDesign.star_fill,
                  color: color,
                  size: width > height
                      ? height * SharedConstants.bigIconSize * 2
                      : width * SharedConstants.bigIconSize * 1.75,
                ),
                starCount: SharedConstants.starCount,
                starSize: width > height
                    ? height * SharedConstants.bigIconSize * 2.25
                    : width * SharedConstants.bigIconSize * 2,
                maxValue: SharedConstants.starCount.toDouble(),
                starSpacing: 1,
                maxValueVisibility: true,
                valueLabelVisibility: false,
                animationDuration: const Duration(milliseconds: 800),
                starColor: SharedConstants.secondaryColor,
              ),
            ),
            // Answer Textfield Area
            Padding(
              padding: EdgeInsets.only(
                top: height * SharedConstants.largePadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 5,
                    child: TextField(
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.displayMedium,
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            width * SharedConstants.mediumSize,
                          ),
                        ),
                        labelText: SharedConstants.answerHintText,
                        // hintStyle: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                  SizedBox(width: width * SharedConstants.generalPadding),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            width * SharedConstants.mediumSize,
                          ),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return PopScope(
                              canPop: false,
                              child: AlertDialog(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                title: Column(
                                  children: [
                                    Icon(
                                      Icons.task_alt_outlined,
                                      size: height > width
                                          ? width * SharedConstants.bigSize
                                          : height * SharedConstants.bigSize,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: height *
                                              SharedConstants.generalPadding),
                                      child: Text(
                                        SharedConstants.surveySendedPopText,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        Future.delayed(
                          const Duration(
                            seconds: SharedConstants.timerPopup,
                          ),
                          () {
                            ref
                                .read(rateProvider.notifier)
                                .update((state) => 1);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .fontSize! *
                              1.5,
                        ),
                        child: Text(
                          SharedConstants.submitText,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
