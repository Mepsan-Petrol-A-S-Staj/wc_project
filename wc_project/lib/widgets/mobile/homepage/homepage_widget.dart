import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../services/provider/all_provider.dart';
import '../../../shared/constant_shared.dart';

class HomePageMobileWidget extends StatelessWidget {
  final double width, height;
  final WidgetRef ref;
  const HomePageMobileWidget({
    required this.width,
    required this.height,
    required this.ref,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
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
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: height * SharedConstants.generalPadding),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      title: Column(
                        children: [
                          Icon(
                            Icons.task_alt_outlined,
                            size: height > width
                                ? width * SharedConstants.bigSize
                                : height * SharedConstants.bigSize,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: height * SharedConstants.generalPadding),
                            child: Text(
                              SharedConstants.surveySendedPopText,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
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
                  ref.read(rateProvider.notifier).update((state) => 1);
                  Navigator.of(context).pop();
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical:
                    Theme.of(context).textTheme.displayMedium!.fontSize! * 1.5,
              ),
              child: Text(
                SharedConstants.submitText,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).textTheme.displayLarge!.color),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
