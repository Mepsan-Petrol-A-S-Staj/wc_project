import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_project/shared/constant_shared.dart';
import 'package:wc_project/shared/list_shared.dart';
import '../services/controllers/pages/devicesavepage_controller.dart';
import '../services/provider/all_provider.dart';

class DeviceSavePage extends ConsumerStatefulWidget {
  const DeviceSavePage({
    super.key,
  });

  @override
  ConsumerState<DeviceSavePage> createState() => _DeviceSavePageState();
}

class _DeviceSavePageState extends ConsumerState<DeviceSavePage> {
  late TextEditingController controller;
  late SharedPreferences prefs;
  late String selectedValue;
  late DeviceSavePageController pageController;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    selectedValue = ref.read(providerSelectedFloor);
    pageController = DeviceSavePageController(ref: ref);
    loadPreferences();
  }

  void loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    String? deviceNum = prefs.getString('devicenum');
    if (deviceNum != null) {
      controller.text = deviceNum;
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height, width = mediaQuery.size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * SharedConstants.bigPadding,
        vertical: height * SharedConstants.generalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Uygulamaya başlamadan önce cihazı kaydediniz',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontWeight: FontWeight.w300),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * SharedConstants.generalPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(
                        height * SharedConstants.mediumSize,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                          height * SharedConstants.generalPadding * 2),
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
                                'Kat: ${pageController.getFloorString(selectedValue)}'),
                        icon: selectedValue == 'emptyfloor'
                            ? SvgPicture.asset(
                                "assets/icons/emptyfloor.svg",
                                height: height * SharedConstants.bigSize,
                              )
                            : SvgPicture.asset(
                                "assets/icons/$selectedValue.svg",
                                height: height * SharedConstants.bigSize,
                              ),
                        iconSize: height * SharedConstants.bigSize,
                        borderRadius: BorderRadius.circular(
                          height * SharedConstants.generalPadding,
                        ),
                        underline: const Text(''),
                        items: [
                          for (int i = 0;
                              i <
                                  SharedList
                                      .deviceSavePageDropDownButtonItemList
                                      .length;
                              i++)
                            DropdownMenuItem(
                              value: SharedList
                                  .deviceSavePageDropDownButtonItemList[i]
                                  .value,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    SharedList
                                        .deviceSavePageDropDownButtonItemList[i]
                                        .text,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiaryContainer),
                                  ),
                                  SvgPicture.asset(
                                    SharedList
                                        .deviceSavePageDropDownButtonItemList[i]
                                        .imagePath,
                                    height: 80,
                                  ),
                                ],
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedValue = pageController
                                .getSelectedfloorValue(value.toString());
                            debugPrint('selectedValue: $selectedValue');
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),

                // Textfield
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(
                        height * SharedConstants.generalSize,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: width * SharedConstants.generalPadding,
                      ),
                      child: TextField(
                        cursorColor: Theme.of(context).colorScheme.tertiary,
                        maxLines: 1,
                        controller: controller,
                        style: Theme.of(context).textTheme.displayMedium,
                        decoration: InputDecoration(
                          hintText: 'Eşsiz bir cihaz numarası girin.',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onTertiaryContainer),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * SharedConstants.generalPadding,
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              onPressed: () async {
                bool deviceSavedStatus = await _submit(
                    selectedValue, controller.text, height, width);
                // TODO: implement showDialogFunc!
                // ignore: use_build_context_synchronously
                showDialogFunc(deviceSavedStatus, height, width, context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Cihazı Kaydet',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _submit(
      String floorValue, String extraValue, double height, double width) async {
    bool isDeviceSaved =
        await pageController.deviceProviderService(floorValue, extraValue);
    int index = 1;
    isDeviceSaved ? index = 0 : null;
    return index == 0 ? true : false;
    // showDialogFunc(index, height, width);
    // ref.read(pageIndexProvider.notifier).update((state) => index);
  }

  void showDialogFunc(bool deviceSavedStatus, double height, double width,
      BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            title: Column(
              children: [
                Icon(
                  deviceSavedStatus
                      ? Icons.task_alt_outlined
                      : Icons.error_outline,
                  size: height > width
                      ? width * SharedConstants.bigSize
                      : height * SharedConstants.bigSize,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height * SharedConstants.generalPadding),
                  child: Text(
                    textAlign: TextAlign.center,
                    deviceSavedStatus
                        ? SharedConstants.deviceSavedSuccessText
                        : SharedConstants.deviceSavedErrorText,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    Future.delayed(
      const Duration(
        seconds: SharedConstants.timerPopup,
      ),
      () {
        deviceSavedStatus
            ? ref.read(pageIndexProvider.notifier).update((state) => 0)
            : null;
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
