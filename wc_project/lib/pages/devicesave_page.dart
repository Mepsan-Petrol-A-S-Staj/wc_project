import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/provider/all_provider.dart';

class DeviceSavePage extends ConsumerWidget {
  final double height, width;

  const DeviceSavePage({
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController();
    late SharedPreferences prefs;
    String? selectedValue = '';

    void loadPreferences() async {
      prefs = await SharedPreferences.getInstance();
      // SharedPreference'dan devicenum değerini al ve eğer varsa TextField'a set et
      String? deviceNum = prefs.getString('devicenum');
      if (deviceNum != null) {
        controller.text = deviceNum;
      }
    }

    loadPreferences();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Cihazı Kaydet',
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontWeight: FontWeight.w200),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(15),
              /* border:
                      Border.all(color: Theme.of(context).colorScheme.primary) */
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: DropdownButton(
                dropdownColor: Theme.of(context).colorScheme.tertiaryContainer,
                itemHeight: 100,
                // isExpanded: true,
                isDense: true,
                hint: selectedValue == null
                    ? const Text('Kat Seçin')
                    : Text('Kat: $selectedValue'),

                icon: selectedValue == ''
                    ? SvgPicture.asset(
                        "assets/icons/emptyfloor.svg",
                        height: 80,
                      )
                    : SvgPicture.asset(
                        "assets/icons/${selectedValue}floor.svg",
                        height: 80,
                      ),
                iconSize: 80,

                borderRadius: BorderRadius.circular(15),
                underline: const Text(''),
                //value: selectedValue,
                items: [
                  DropdownMenuItem(
                    value: "Teras",
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Teras'),
                          SvgPicture.asset(
                            "assets/icons/Terasfloor.svg",
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "3",
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('3. Kat'),
                          SvgPicture.asset(
                            "assets/icons/3floor.svg",
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "2",
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('2. Kat'),
                          SvgPicture.asset(
                            "assets/icons/2floor.svg",
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "1",
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('1. Kat'),
                          SvgPicture.asset(
                            "assets/icons/1floor.svg",
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {
                  selectedValue = value as String?;
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await prefs.setString('devicenum', selectedValue!);
              await prefs.setBool('isDeviceSaved', true);

              int index = 0;
              ref.read(pageIndexProvider.notifier).update((state) => index);
            },
            child: const Text('Cihaz Kaydet'),
          ),
        ],
      ),
    );
  }
}
