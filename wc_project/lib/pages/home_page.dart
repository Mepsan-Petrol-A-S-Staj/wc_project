import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wc_project/shared/constants_shared.dart';
import '../services/providers/rate_provider.dart';

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
    return Consumer<RateProvider>(
      builder: (context, rateProvider, _) {
        double value = rateProvider.getIndex.toDouble();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            children: [
              const Text(
                'LAVABOLARIN GENEL TEMİZLİĞİNİ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  'DEĞERLENDİRİN',
                  style: TextStyle(
                    color: Color(0xff3DA2DB),
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: RatingStars(
                  value: value,
                  onValueChanged: (v) {
                    rateProvider.setIndex(v.round());
                  },
                  starBuilder: (index, color) => Icon(
                    AntDesign.star_fill,
                    color: color,
                    size: width * 0.1,
                  ),
                  starCount: SharedConstants.starCount,
                  starSize: width * 0.12,
                  valueLabelColor: const Color(0xff9b9b9b),
                  valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                  valueLabelRadius: 10,
                  maxValue: SharedConstants.starCount.toDouble(),
                  starSpacing: 1,
                  maxValueVisibility: true,
                  valueLabelVisibility: false,
                  animationDuration: const Duration(milliseconds: 800),
                  starColor: Color(0xff3da2db),
                ),
              ),
              // Answer Textfield Area
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          maxLines: 2,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: 'Lütfen yorumunuzu buraya yazınız.',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return WillPopScope(
                                onWillPop: () async =>
                                    false, // Geri butona basıldığında hiçbir şey yapma
                                child: AlertDialog(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer,
                                  title: Column(
                                    children: [
                                      Icon(
                                        Icons.task_alt_outlined,
                                        size: 40,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Cevap Gönderildi',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Text(
                          SharedConstants.submitText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
