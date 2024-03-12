import 'package:flutter/material.dart';

class SharedList {
  // static List<String> list = [];
  // Home Page
  static List<String> welcomeTextList = [
    "LAVOBALARIN GENEL TEMİZLİĞİNİ",
    "DEĞERLENDİRİN"
  ];

  // Login Page
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
  // Task Page
  static List<String> taskPageCardTextList = [
    "Günlük Görevler",
    "Haftalık Görevler",
  ];
}
