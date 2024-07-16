// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../services/provider/all_provider.dart';
// import '../shared/constant_shared.dart';
// import '../shared/list_shared.dart';

// class DeviceSavePageDropDownWidget extends StatelessWidget {
//   final double height, width;
//   final WidgetRef ref;
//   final String selectedValue = 'emptyfloor';
//   const DeviceSavePageDropDownWidget({
//     required this.height,
//     required this.width,
//     required this.ref,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.primaryContainer,
//         borderRadius:
//             BorderRadius.circular(height * SharedConstants.mediumSize * 0.8),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(height * SharedConstants.generalPadding * 2),
//         child: DropdownButton(
//           dropdownColor: Theme.of(context).colorScheme.tertiaryContainer,
//           itemHeight: width > height
//               ? width * SharedConstants.bigSize
//               : height * SharedConstants.bigSize,
//           isDense: true,
//           hint: selectedValue == 'emptyfloor'
//               ? const Text('Kat Seçin')
//               : Text('Kat: ${pageController.getFloorInt(selectedValue)}'),
//           icon: selectedValue == 'emptyfloor'
//               ? SvgPicture.asset(
//                   "assets/icons/emptyfloor.svg",
//                   height: height * SharedConstants.bigSize,
//                 )
//               : SvgPicture.asset(
//                   "assets/icons/$selectedValue.svg",
//                   height: height * SharedConstants.bigSize,
//                 ),
//           iconSize: height * SharedConstants.bigSize,
//           borderRadius: BorderRadius.circular(
//             height * SharedConstants.generalSize,
//           ),
//           underline: const Text(''),
//           items: [
//             for (int i = 0;
//                 i < SharedList.deviceSavePageDropDownButtonItemList.length;
//                 i++)
//               DropdownMenuItem(
//                 value: SharedList.deviceSavePageDropDownButtonItemList[i].value,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       SharedList.deviceSavePageDropDownButtonItemList[i].text,
//                     ),
//                     SvgPicture.asset(
//                       SharedList
//                           .deviceSavePageDropDownButtonItemList[i].imagePath,
//                       height: 80,
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//           onChanged: (value) {
//             selectedValue = pageController.getSelectedValue(value ?? 'empty');
//             ref.read(providerSelectedFloor.notifier).update((state) => selectedValue);
//           },
//         ),
//       ),
//     );
//   }
// }
