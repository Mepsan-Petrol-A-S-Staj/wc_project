import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_project/shared/constant_shared.dart';
import 'package:wc_project/shared/list_shared.dart';

import '../services/controllers/devicesavepage_controller.dart';
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
    String selectedValue = ref.watch(providerSelectedFloor);
    DeviceSavePageController pageController =
        DeviceSavePageController(ref: ref);

    void loadPreferences() async {
      prefs = await SharedPreferences.getInstance();
      String? deviceNum = prefs.getString('devicenum');
      if (deviceNum != null) {
        controller.text = deviceNum;
      }
    }

    loadPreferences();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * SharedConstants.generalPadding,
        vertical: height * SharedConstants.generalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Cihazı Kaydet',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * SharedConstants.generalPadding,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(
                    height * SharedConstants.mediumSize * 0.8),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                    height * SharedConstants.generalPadding * 1.5),
                child: DropdownButton(
                  dropdownColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  itemHeight: width > height
                      ? width * SharedConstants.bigSize
                      : height * SharedConstants.bigSize,
                  isDense: true,
                  hint: selectedValue == 'emptyfloor'
                      ? const Text('Kat Seçin')
                      : Text(
                          'Kat: ${pageController.getFloorInt(selectedValue)}'),
                  icon: selectedValue == 'emptyfloor'
                      ? SvgPicture.asset(
                          "assets/icons/emptyfloor.svg",
                          height: height * SharedConstants.bigSize * 2.5,
                        )
                      : SvgPicture.asset(
                          "assets/icons/${selectedValue}.svg",
                          height: height * SharedConstants.bigSize * 2.5,
                        ),
                  iconSize: height * SharedConstants.bigSize * 2.5,
                  borderRadius: BorderRadius.circular(
                    height * SharedConstants.bigPadding,
                  ),
                  underline: const Text(''),
                  items: [
                    for (int i = 0;
                        i <
                            SharedList
                                .deviceSavePageDropDownButtonItemList.length;
                        i++)
                      DropdownMenuItem(
                        value: SharedList
                            .deviceSavePageDropDownButtonItemList[i].value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              SharedList
                                  .deviceSavePageDropDownButtonItemList[i].text,
                            ),
                            SvgPicture.asset(
                              SharedList.deviceSavePageDropDownButtonItemList[i]
                                  .imagePath,
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                  ],
                  onChanged: (value) {
                    selectedValue =
                        pageController.getSelectedValue(value ?? 'empty');
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * SharedConstants.generalPadding,
            ),
            child: ElevatedButton(
              onPressed: () async {
                await prefs.setString('devicenum', selectedValue);
                await prefs.setBool('isDeviceSaved', true);

                int index = 0;
                ref.read(pageIndexProvider.notifier).update((state) => index);
              },
              child: Text(
                'Cihaz Kaydet',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
