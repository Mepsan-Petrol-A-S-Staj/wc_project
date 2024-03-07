import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
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
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double value;
  late OverlayEntry? _overlayEntry;
  late Timer _timer;
  CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
    value = 2.5;
  }

  void _showPopup(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.35,
        left: MediaQuery.of(context).size.width * 0.3,
        child: Material(
          color: Colors.transparent,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                widget.height * SharedConstants.generalPadding,
              ),
            ),
            color: Colors.amber,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.width * SharedConstants.bigPadding * 1.5,
                vertical: widget.height * SharedConstants.bigPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cevabınız Gönderildi!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: widget.height * SharedConstants.bigPadding,
                    ),
                    child: CircularCountDownTimer(
                      controller: _controller,
                      duration: 5,
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.1,
                      ringColor: Colors.blue,
                      fillColor: Colors.white,
                      strokeWidth: 5.0,
                      textStyle: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      isReverse: true,
                      isReverseAnimation: true,
                      isTimerTextShown: true,
                      onComplete: () {
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    overlayState?.insert(_overlayEntry!);
    _controller.start();
    _timer = Timer(Duration(seconds: 5), () {
      _controller.pause();
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
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
                _showPopup(context);
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
