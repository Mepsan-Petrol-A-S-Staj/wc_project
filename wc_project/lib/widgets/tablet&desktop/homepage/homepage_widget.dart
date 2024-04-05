import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/device_controller.dart';

import '../../../models/survey_model.dart';
import '../../../services/apis/survey_service.dart';
import '../../../services/provider/all_provider.dart';
import '../../../shared/constant_shared.dart';

class HomePageTabletandDesktopWidget extends StatelessWidget {
  final double width, height;
  final WidgetRef ref;
  const HomePageTabletandDesktopWidget({
    required this.width,
    required this.height,
    required this.ref,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController comment = TextEditingController();
    DeviceController deviceController = DeviceController(ref: ref);
    SurveyService surveyService = SurveyService();
    // int deviceId =await deviceController.getDeviceId();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            controller: comment,
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
        ),
        SizedBox(width: width * SharedConstants.generalPadding),
        Expanded(
          flex: 1,
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
              Survey survey = Survey(
                rating: ref.read(rateProvider),
                comment: comment.text,
                person: "",
                surveyDate: "",
                deviceId: 0,
              );
              surveyService.saveSurvey(survey, ref.read(tokenProvider));

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
                              textAlign: TextAlign.center,
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
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
