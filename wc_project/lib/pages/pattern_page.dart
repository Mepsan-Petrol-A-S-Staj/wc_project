import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_project/pages/devicesave_page.dart';
import 'package:wc_project/pages/task_page.dart';
import 'package:wc_project/shared/constants_shared.dart';

import '../services/providers/pageindex_provider.dart';
import 'home_page.dart';
import 'login_page.dart';

class PatternPage extends StatefulWidget {
  final double height, width;
  const PatternPage({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  _PatternPageState createState() => _PatternPageState();
}

class _PatternPageState extends State<PatternPage> {
  late int index;
  late Timer _timer;
  late bool savedDevice;

  @override
  void initState() {
    _startTimer();
    _loadSavedDevice();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  Future<void> _loadSavedDevice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedDevice = prefs.getBool('savedDevice') ?? false;
      if (savedDevice) {
        index = 0;
      } else {
        index = 3;
      }
      Provider.of<PageIndexProvider>(context, listen: false).setIndex(index);
    });
  }

  @override
  void didChangeDependencies() {
    index = Provider.of<PageIndexProvider>(context, listen: true).getIndex;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(height: widget.height, width: widget.width),
      LoginPage(height: widget.height, width: widget.width),
      TaskPage(height: widget.height, width: widget.width),
      DeviceSavePage(height: widget.height, width: widget.width),
    ];
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.width * SharedConstants.generalPadding,
          ),
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: EdgeInsets.only(
                    top: widget.height * SharedConstants.generalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: SvgPicture.asset(
                        SharedConstants.logoImageRoute,
                        height: widget.height * 0.05,
                      ),
                      onTap: () {
                        index = 0;
                        Provider.of<PageIndexProvider>(context, listen: false)
                            .setIndex(index);
                      },
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.person),
                          onPressed: () {
                            index = 1;
                            Provider.of<PageIndexProvider>(context,
                                    listen: false)
                                .setIndex(index);
                          },
                        ),
                        // Date and Time
                        Padding(
                          padding: EdgeInsets.only(
                            left: widget.width * SharedConstants.generalPadding,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < 2; i++)
                                Text(
                                  // Reformat the Day Mounth (Text) Year
                                  i == 0
                                      ? DateFormat('dd MMM yyyy')
                                          .format(DateTime.now())
                                      : DateFormat('HH:mm:ss')
                                          .format(DateTime.now()),
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Consumer<PageIndexProvider>(
                  builder: (context, notifier, _) {
                    // pages[index] içeriği, SomeNotifier'ın değişikliklerine göre otomatik olarak güncellenir
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: pages[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
