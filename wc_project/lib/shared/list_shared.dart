import 'package:flutter/material.dart';

import '../models/devspagedropdownitem_model.dart';

class SharedList {
  //----------------------------------------------------------------------------------------
  //! DeviceSavePage Page
  //----------------------------------------------------------------------------------------
  static List<DeviceSavePageDropdownItemModel>
      deviceSavePageDropDownButtonItemList = [
    DeviceSavePageDropdownItemModel(
      value: 'Teras',
      text: 'Teras',
      imagePath: 'assets/icons/terrasfloor.svg',
    ),
    DeviceSavePageDropdownItemModel(
      value: '2',
      text: '2. Kat',
      imagePath: 'assets/icons/secondfloor.svg',
    ),
    DeviceSavePageDropdownItemModel(
      value: '1',
      text: '1. Kat',
      imagePath: 'assets/icons/firstfloor.svg',
    ),
    DeviceSavePageDropdownItemModel(
      value: 'Zemin',
      text: 'Zemin',
      imagePath: 'assets/icons/groundfloor.svg',
    ),
  ];
  //----------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------------
  //! Home Page
  //----------------------------------------------------------------------------------------
  static List<String> welcomeTextList = [
    "LAVOBALARIN GENEL TEMİZLİĞİNİ",
    "DEĞERLENDİRİN"
  ];
  //----------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------------
  //! Login Page
  //----------------------------------------------------------------------------------------
  static List<String> loginPageTextfieldHintTextList = [
    "Kullanıcı Adı",
    "Şifre"
  ];
  static List<Widget> loginPageTextFieldIconList = [
    const Icon(
      Icons.person,
    ),
    const Icon(
      Icons.lock,
    ),
  ];
  //----------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------------
  //! Task Page
  //----------------------------------------------------------------------------------------
  static List<String> taskPageCardTextList = [
    "Yapılacak Görevler",
    "Tamamlanmış Görevler",
  ];

  //----------------------------------------------------------------------------------------
  //! Admin Page
  //----------------------------------------------------------------------------------------
  static List<String> adminPageTabbarTextList = [
    "Bugün",
    "Görevler",
    "Değerlendirmeler",
  ];
  static List<IconData> adminPageIconList = [
    Icons.edit,
    Icons.delete,
  ];
  //----------------------------------------------------------------------------------------
}
