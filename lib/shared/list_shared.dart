import 'package:flutter/material.dart';

import '../models/adminpagecard_model.dart';
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
  static List<IconData> taskPageCardWidgetIconList = [
    Icons.error_outline,
    Icons.done,
  ];

  //----------------------------------------------------------------------------------------
  //! Admin Page
  //----------------------------------------------------------------------------------------
  static List<AdminPageCardModel> adminPageCardList = [
    AdminPageCardModel(
      key: "task",
      value: "Görevler",
      icon: Icons.assignment,
    ),
    AdminPageCardModel(
      key: "user",
      value: "Kullanıcılar",
      icon: Icons.person,
    ),
    AdminPageCardModel(
      key: "answer",
      value: "Değerlendirmeler",
      icon: Icons.feedback,
    ),
    AdminPageCardModel(
      key: "device",
      value: "Cihazlar",
      icon: Icons.devices,
    ),
  ];
  static List<IconData> adminPageIconList = [
    Icons.edit,
    Icons.delete,
  ];
  //----------------------------------------------------------------------------------------
}
