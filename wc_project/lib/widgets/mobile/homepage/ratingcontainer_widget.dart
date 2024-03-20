import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../services/provider/all_provider.dart';
import '../../../shared/constant_shared.dart';

class RatingContainerMobileWidget extends StatelessWidget {
  final double width, height;

  final WidgetRef ref;
  const RatingContainerMobileWidget({
    required this.width,
    required this.height,
    required this.ref,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        int value = ref.watch(rateProvider);
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(
              height * SharedConstants.largePadding,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(height * SharedConstants.generalPadding),
            child: RatingStars(
              value: value.toDouble(),
              onValueChanged: (v) {
                ref.read(rateProvider.notifier).update((state) => v.toInt());
              },
              starBuilder: (index, color) => Icon(
                AntDesign.star_fill,
                color: color,
                size: height * SharedConstants.bigIconSize * 0.7,
              ),
              starCount: SharedConstants.starCount,
              starSize: height * SharedConstants.bigIconSize * 0.85,
              maxValue: SharedConstants.starCount.toDouble(),
              starSpacing: 1,
              maxValueVisibility: true,
              valueLabelVisibility: false,
              animationDuration: const Duration(milliseconds: 800),
              starColor: SharedConstants.primaryColor,
            ),
          ),
        );
      },
    );
  }
}
