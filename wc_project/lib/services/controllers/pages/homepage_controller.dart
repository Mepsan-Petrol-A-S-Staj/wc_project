import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/pages/patternpage_controller.dart';
import 'package:wc_project/services/controllers/size_controller.dart';
import 'package:wc_project/services/provider/all_provider.dart';
import 'package:wc_project/widgets/mobile/homepage/homepage_widget.dart';
import 'package:wc_project/widgets/tablet&desktop/homepage/homepage_widget.dart';
import '../../../models/survey_model.dart';
import '../../../shared/constant_shared.dart';
import '../../../widgets/mobile/homepage/ratingcontainer_widget.dart';
import '../../../widgets/tablet&desktop/homepage/ratingcontainer_widget.dart';
import '../../apis/survey_service.dart';

class HomePageController {
  final MediaQueryData mediaQueryData;
  final double height, width;
  final WidgetRef ref;
  HomePageController({
    required this.mediaQueryData,
    required this.height,
    required this.width,
    required this.ref,
  });

  Widget buildRatingWidget() {
    SizeController sizeController = SizeController(
      height: height,
      width: width,
    );
    int type = sizeController.getScreenType(mediaQueryData);
    switch (type) {
      case 0:
        return RatingContainerMobileWidget(
            width: width, height: height, ref: ref);
      case 1:
        return RatingContainerTabletandDesktopWidget(width: width, ref: ref);
      case 2:
        return RatingContainerTabletandDesktopWidget(width: width, ref: ref);
      default:
        return RatingContainerMobileWidget(
            width: width, height: height, ref: ref);
    }
  }

  Widget buildAnswerandSubmitWidget() {
    SizeController sizeController = SizeController(
      height: height,
      width: width,
    );
    int type = sizeController.getScreenType(mediaQueryData);
    switch (type) {
      case 0:
        return HomePageMobileWidget(width: width, height: height, ref: ref);
      case 1:
        return HomePageTabletandDesktopWidget(
            width: width, height: height, ref: ref);
      case 2:
        return HomePageTabletandDesktopWidget(
            width: width, height: height, ref: ref);
      default:
        return HomePageMobileWidget(width: width, height: height, ref: ref);
    }
  }

  Future<dynamic> showDialogWidget(BuildContext context, bool isSending) {
    debugPrint('Is Sending: $isSending');
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
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
                    isSending
                        ? SharedConstants.surveySendedPopComplateText
                        : SharedConstants.surveySendedPopErrorText,
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
  }

  Future<bool> sendSurvey(String? answer) async {
    int getDeviceId = await PatternPageController(ref: ref).getDeviceId();
    debugPrint('Device Id: $getDeviceId');
    Survey survey = Survey(
      comment: answer ?? '',
      rating: ref.watch(rateProvider),
      deviceId: getDeviceId,
    );
    SurveyService surveyService = SurveyService();
    SurveyType isSending =
        await surveyService.saveSurvey(survey, ref.read(tokenProvider));
    if (isSending == SurveyType.SurveySave) {
      return true;
    } else {
      return false;
    }
  }
}
