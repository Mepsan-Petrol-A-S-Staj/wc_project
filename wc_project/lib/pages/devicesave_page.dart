import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_project/shared/constant_shared.dart';
import 'package:wc_project/shared/list_shared.dart';
import '../services/controllers/devicesavepage_controller.dart';
import '../services/provider/all_provider.dart';

class DeviceSavePage extends ConsumerStatefulWidget {
  final double height, width;

  const DeviceSavePage({
    required this.height,
    required this.width,
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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.width * SharedConstants.bigPadding,
        vertical: widget.height * SharedConstants.generalPadding,
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
              top: widget.height * SharedConstants.generalPadding,
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
                        widget.height * SharedConstants.mediumSize,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                          widget.height * SharedConstants.generalPadding * 2),
                      child: DropdownButton(
                        dropdownColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        itemHeight: widget.width > widget.height
                            ? widget.width * SharedConstants.bigSize
                            : widget.height * SharedConstants.bigSize,
                        isDense: true,
                        hint: selectedValue == 'emptyfloor'
                            ? const Text('Kat Seçin')
                            : Text(
                                'Kat: ${pageController.getFloorInt(selectedValue)}'),
                        icon: selectedValue == 'emptyfloor'
                            ? SvgPicture.asset(
                                "assets/icons/emptyfloor.svg",
                                height: widget.height * SharedConstants.bigSize,
                              )
                            : SvgPicture.asset(
                                "assets/icons/$selectedValue.svg",
                                height: widget.height * SharedConstants.bigSize,
                              ),
                        iconSize: widget.height * SharedConstants.bigSize,
                        borderRadius: BorderRadius.circular(
                          widget.height * SharedConstants.generalPadding,
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
                                .getSelectedValue(value ?? 'empty');
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
                        widget.height * SharedConstants.generalSize,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal:
                            widget.width * SharedConstants.generalPadding,
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
                        onSubmitted: (_) {
                          _submit();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: widget.height * SharedConstants.generalPadding,
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              onPressed: () async {
                _submit();
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

  void _submit() async {
    await prefs.setString('devicenum', selectedValue);
    await prefs.setBool('isDeviceSaved', true);

    int index = 0;
    ref.read(pageIndexProvider.notifier).update((state) => index);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
