import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/pages/home_page.dart';

import '../../../services/controllers/pages/homepage_controller.dart';
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
    TextEditingController answerController = TextEditingController();
    HomePageController homePageController = HomePageController(
      mediaQueryData: MediaQuery.of(context),
      height: height,
      width: width,
      ref: ref,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: answerController,
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
            onPressed: () async {
              bool isSending =
                  await homePageController.sendSurvey(answerController.text);
              homePageController.showDialogWidget(context, isSending);

              // Capture context safely before async gap
              final appContext = context;

              Future.delayed(
                const Duration(
                  seconds: SharedConstants.timerPopup,
                ),
                () {
                  if (appContext.mounted) {
                    // Check if widget is still mounted
                    ref.read(rateProvider.notifier).update((state) => 1);
                    Navigator.of(appContext).pop();
                  } else {
                    // Handle case where widget is no longer mounted (optional)
                    print('Widget is no longer mounted, skipping actions.');
                  }
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
                    color: Theme.of(context).colorScheme.onTertiaryContainer),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
