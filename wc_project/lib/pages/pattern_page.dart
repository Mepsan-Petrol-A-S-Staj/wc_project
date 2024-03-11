// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:slide_digital_clock/slide_digital_clock.dart';
// import 'package:wc_project/pages/devicesave_page.dart';
// import 'package:wc_project/pages/task_page.dart';
// import 'package:wc_project/shared/constants_shared.dart';

// import '../services/providers/pageindex_provider.dart';
// import 'home_page.dart';
// import 'login_page.dart';

// class PatternPage extends StatelessWidget {
//   final double height, width;

//   const PatternPage({
//     required this.height,
//     required this.width,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PageIndexProvider>(
//       builder: (context, pageIndexProvider, _) {
//         int index = pageIndexProvider.getIndex;
//         return PopScope(
//           canPop: false,
//           onPopInvoked: (didPop) async {
//             if (index == 0) {
//               await showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('Uygulamadan çıkmak istiyor musunuz?'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.of(context).pop(false),
//                       child: Text('Hayır'),
//                     ),
//                     TextButton(
//                       onPressed: () => Navigator.of(context).pop(true),
//                       child: Text('Evet'),
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               didPop ? null : null;
//             }
//           },
//           child: Scaffold(
//             extendBody: true,
//             body: SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: width * SharedConstants.generalPadding,
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                         top: height * SharedConstants.generalPadding,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             child: SvgPicture.asset(
//                               SharedConstants.logoImageRoute,
//                               height: height * 0.05,
//                             ),
//                             onTap: () {
//                               index == 3 ? null : pageIndexProvider.setIndex(0);
//                             },
//                           ),
//                           Row(
//                             children: [
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.person_outline,
//                                   size: Theme.of(context)
//                                           .textTheme
//                                           .headlineMedium!
//                                           .fontSize! *
//                                       1.4,
//                                 ),
//                                 onPressed: () {
//                                   index == 3
//                                       ? null
//                                       : pageIndexProvider.setIndex(1);
//                                 },
//                               ),
//                               DigitalClock(
//                                 hourMinuteDigitTextStyle:
//                                     Theme.of(context).textTheme.headlineMedium,
//                                 secondDigitTextStyle:
//                                     Theme.of(context).textTheme.bodyMedium,
//                                 colon: Text(
//                                   ":",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headlineMedium,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: _buildPage(index),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPage(int index) {
//     switch (index) {
//       case 0:
//         return HomePage(height: height, width: width);
//       // return LoginPage(height: height, width: width);
//       case 1:
//         return LoginPage(height: height, width: width);
//       case 2:
//         return TaskPage(height: height, width: width);
//       case 3:
//         return DeviceSavePage(height: height, width: width);
//       default:
//         return Container();
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:wc_project/pages/devicesave_page.dart';
import 'package:wc_project/pages/task_page.dart';
import 'package:wc_project/shared/constants_shared.dart';

import '../services/providers/pageindex_provider.dart';
import 'home_page.dart';
import 'login_page.dart';

class PatternPage extends StatelessWidget {
  final double height, width;

  const PatternPage({
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageIndexProvider>(
      builder: (context, pageIndexProvider, _) {
        int index = pageIndexProvider.getIndex;
        return WillPopScope(
          onWillPop: () async {
            if (index == 0) {
              bool? exit = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Uygulamadan çıkmak istiyor musunuz?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Hayır'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Evet'),
                    ),
                  ],
                ),
              );
              return exit ?? false;
            }
            return true;
          },
          child: Scaffold(
            extendBody: true,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * SharedConstants.generalPadding,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * SharedConstants.generalPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: SvgPicture.asset(
                              SharedConstants.logoImageRoute,
                              height: height * 0.05,
                            ),
                            onTap: () {
                              index == 3 ? null : pageIndexProvider.setIndex(0);
                            },
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.person_outline,
                                  size: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .fontSize! *
                                      1.4,
                                ),
                                onPressed: () {
                                  index == 3
                                      ? null
                                      : pageIndexProvider.setIndex(1);
                                },
                              ),
                              DigitalClock(
                                hourMinuteDigitTextStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                                secondDigitTextStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                colon: Text(
                                  ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: _buildPage(index),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomePage(height: height, width: width);
      case 1:
        return LoginPage(height: height, width: width);
      case 2:
        return TaskPage(height: height, width: width);
      case 3:
        return DeviceSavePage(height: height, width: width);
      default:
        return Container();
    }
  }
}
