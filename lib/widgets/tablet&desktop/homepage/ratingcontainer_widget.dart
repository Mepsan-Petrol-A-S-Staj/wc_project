import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../services/provider/all_provider.dart';
import '../../../shared/constant_shared.dart';

class RatingContainerTabletandDesktopWidget extends StatelessWidget {
  final double width;

  final WidgetRef ref;
  const RatingContainerTabletandDesktopWidget({
    required this.width,
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
            color: Theme.of(context).colorScheme.tertiary.withOpacity(.3),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: width * SharedConstants.generalPadding,
              horizontal: width * SharedConstants.mediumPadding * 1.5,
            ),
            child: RatingStars(
              value: value.toDouble(),
              onValueChanged: (v) {
                ref.read(rateProvider.notifier).update((state) => v.toInt());
              },
              starBuilder: (index, color) => Icon(
                AntDesign.star_fill,
                color: color,
                size: width * SharedConstants.bigIconSize * 1.1,
              ),
              starCount: SharedConstants.starCount,
              starSize: width * SharedConstants.bigIconSize * 1.2,
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
