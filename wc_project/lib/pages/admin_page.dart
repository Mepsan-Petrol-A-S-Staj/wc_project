import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/shared/constant_shared.dart';

import '../services/provider/all_provider.dart';
import '../shared/list_shared.dart';

class AdminPage extends StatelessWidget {
  final double height, width;
  final List<String> deviceList = ['device1', 'device2']; // Örnek cihaz listesi

  AdminPage({
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Cihaz : ",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: width * SharedConstants.largePadding),
              child: DropdownButton<String>(
                // items: deviceList.map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                items: [
                  DropdownMenuItem(
                    child: Text(
                      'device1',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    value: 'device1',
                  ),
                ],
                onChanged: (String? value) {
                  // ref.read(selectedDevice.notifier).state = value!;
                },
                value: 'device1',
              ),
            ),
          ],
        ),
        // Tabbar eklenecek
        Padding(
          padding: EdgeInsets.only(
            top: height * SharedConstants.generalPadding,
          ),
          child: SizedBox(
            height: height * 0.8,
            width: double.infinity,
            child: ContainedTabBarView(
              tabs: [
                for (int i = 0;
                    i < SharedList.adminPageTabbarTextList.length;
                    i++)
                  Text(
                    SharedList.adminPageTabbarTextList[i],
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
              ],
              views: [
                Column(
                  children: [
                    for (int i = 0; i < 2; i++)
                      ListTile(
                        leading: Checkbox(
                          value: false,
                          onChanged: (bool? value) {},
                        ),
                        title: Text('Görev $i'),
                        subtitle: Text('Görev Açıklaması $i'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (int i = 0;
                                i < SharedList.adminPageIconList.length;
                                i++)
                              IconButton(
                                icon: Icon(
                                  SharedList.adminPageIconList[i],
                                  color: i == 0
                                      ? Theme.of(context).iconTheme.color
                                      : Colors.red,
                                ),
                                onPressed: () {},
                              ),
                          ],
                        ),
                      )
                  ],
                ),
                Column(
                  children: [
                    for (int i = 0; i < 2; i++)
                      ListTile(
                        title: Text('Görev $i'),
                        subtitle: Text('Görev Açıklaması $i'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (int i = 0;
                                i < SharedList.adminPageIconList.length;
                                i++)
                              IconButton(
                                icon: Icon(
                                  SharedList.adminPageIconList[i],
                                  color: i == 0
                                      ? Theme.of(context).iconTheme.color
                                      : Colors.red,
                                ),
                                onPressed: () {},
                              ),
                          ],
                        ),
                      )
                  ],
                ),
                Column(
                  children: [
                    for (int i = 0; i < 2; i++)
                      ListTile(
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Değerlendirme $i',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left:
                                    width * SharedConstants.generalPadding / 2,
                              ),
                              child: Icon(Icons.star, color: Colors.yellow),
                            ),
                            Text(
                              "5.0",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: Colors.yellow),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          'Değerlendirme Açıklaması $i',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            SharedList.adminPageIconList[1],
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                      ),
                  ],
                )
              ],
              onChange: (index) => print(index),
            ),
          ),
        )
      ],
    );
  }
}
