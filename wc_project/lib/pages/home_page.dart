import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wc_project/shared/constants_shared.dart';

class HomePage extends StatefulWidget {
  final double height;
  final double width;
  const HomePage({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double value;
  @override
  void initState() {
    super.initState();
    value = 2.5;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            SharedConstants.welcomeText,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(
                widget.height * SharedConstants.mediumPadding,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: RatingStars(
                value: value,
                onValueChanged: (v) {
                  setState(() {
                    value = v;
                  });
                },
                starBuilder: (index, color) => Icon(
                  AntDesign.star_fill,
                  color: color,
                  size: widget.width * 0.1,
                ),
                starCount: SharedConstants.starCount,
                starSize: widget.width * 0.1,
                valueLabelColor: const Color(0xff9b9b9b),
                valueLabelTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0,
                ),
                valueLabelRadius: 10,
                maxValue: SharedConstants.starCount.toDouble(),
                starSpacing: 1,
                maxValueVisibility: true,
                valueLabelVisibility: false,
                animationDuration: const Duration(milliseconds: 2000),
                starColor: Colors.blue,
              ),
            ),
          ),
          // Answer Textfield Area
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: widget.height * SharedConstants.generalPadding,
            ),
            child: Container(
              width: widget.width * 0.6,
              height: widget.height * 0.25,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(
                  widget.height * SharedConstants.generalPadding,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  widget.height * SharedConstants.generalPadding,
                ),
                child: TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: SharedConstants.answerHintText,
                    hintStyle: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                print("Gönderildi");
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: widget.height * SharedConstants.generalPadding,
                ),
                child: Text(
                  SharedConstants.submitText,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
