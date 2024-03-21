import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/shared/constant_shared.dart';
import 'package:wc_project/shared/list_shared.dart';
import '../services/controllers/homepage_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double height = mediaQuery.size.height, width = mediaQuery.size.width;

    return Consumer(
      builder: (context, ref, child) {
        HomePageController homePageController = HomePageController(
          mediaQueryData: mediaQuery,
          height: height,
          width: width,
          ref: ref,
        );

        return Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < SharedList.welcomeTextList.length; i++)
                Padding(
                  padding: EdgeInsets.only(
                    top: i == 0 ? 0 : height * SharedConstants.generalPadding,
                  ),
                  child: Text(
                    SharedList.welcomeTextList[i],
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: i == 0
                              ? null
                              : SharedConstants.secondaryTextColor,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 22.0),
                child: homePageController.buildRatingWidget(),
              ),
              // Answer Textfield Area
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.07,
                ),
                child: homePageController.buildAnswerandSubmitWidget(),
              ),
            ],
          ),
        );
      },
    );
  }
}
