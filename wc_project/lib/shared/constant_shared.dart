import 'package:flutter/material.dart';

class SharedConstants {
  //!----------------------------------------------------------------------------------------
  //! App Definetions
  //!----------------------------------------------------------------------------------------
  static const String appName = 'MLB Clean'; // Project Name
  static const String appVersion = '1.0.0'; // Project Version
  static const String companyName =
      'Mepsan Petrol Cihazları A.Ş.'; // Company Name
  static const int starCount = 5; // Star Count
  static const int timerPopup = 3; // Timer Popup (Seconds)
  //----------------------------------------------------------------------------------------

  //!----------------------------------------------------------------------------------------
  //! Path and Routes (String Definetions)
  //!----------------------------------------------------------------------------------------
  //? Image Route
  //----------------------------------------------------------------------------------------
  static const String logoImageRoute = 'assets/images/logo.svg'; // Logo
  //----------------------------------------------------------------------------------------
  //? Api Routes
  //----------------------------------------------------------------------------------------
  static const String apiBaseUrl = 'http://192.168.101.17:8085/api'; // Base Url

  //----------------------------------------------------------------------------------------
  //* -> Auth
  //----------------------------------------------------------------------------------------
  static const String authLogin = '/auth/login'; // Auth Login
  //----------------------------------------------------------------------------------------
  //* -> User
  //----------------------------------------------------------------------------------------
  static const String userSave = '/user/save'; // Users Save
  static const String userGetwithId = '/user/'; // Get user with Id
  static const String userEmployee = '/user/employee'; //? Users Employee
  static const String userDeletewithId =
      '/user/delete/'; // Users Delete with Id
  static const String userGetAll = '/user/all'; // Users Get All
  //----------------------------------------------------------------------------------------
  //* -> Task
  //----------------------------------------------------------------------------------------
  static const String taskSave = '/task/save'; // Tasks Save
  static const String taskGetwithId = '/task/'; // Get Task with Id
  static const String taskDeletewithId = '/task/delete'; // Tasks Delete with Id
  static const String taskGetAll = '/task/all'; // Tasks Get All
  static const String taskGetAllRE = '/task/allRE'; //? Tasks Get AllRE
  //----------------------------------------------------------------------------------------
  //* -> Survey
  //----------------------------------------------------------------------------------------
  static const String surveySave = '/survey/save'; // Surveys Save
  static const String surveyMontly = '/survey/montly'; //? Surveys Save
  static const String surveyGetwithId = '/survey/'; // Get Survey with Id
  static const String surveyDeletewithDeviceId =
      '/survey/device/'; // Surveys Delete with Id
  static const String surveyDeletewithId =
      '/survey/delete/'; // Surveys Delete with Id
  static const String surveyGetAll = '/survey/all'; // Surveys Get All
  //----------------------------------------------------------------------------------------
  //* -> Device
  //----------------------------------------------------------------------------------------
  static const String deviceSave = '/device/save'; // Devices Save
  static const String deviceGetwithId = '/device/'; // Get Device with Id
  static const String deviceDeletewithId =
      '/device/delete'; // Devices Delete with Id
  static const String deviceGetAll = '/device/all'; // Devices Get All
  //----------------------------------------------------------------------------------------
  //* -> Task Device Connection
  //----------------------------------------------------------------------------------------
  static const String taskGetInfowithDeviceId =
      '/taskinfo/device/'; // Task Device Connection Save
  static const String taskGetInfoAll =
      '/taskinfo/all'; // Get Task Device Connection with Id

  //----------------------------------------------------------------------------------------
  //? Text Definetions
  //----------------------------------------------------------------------------------------
  //* -> Home Page
  //----------------------------------------------------------------------------------------
  static const String answerHintText = 'Lütfen yorumunuzu buraya yazınız.';
  static const String submitText = 'Gönder'; // Submit Text
  static const String surveySendedPopText =
      'Değerlendirme Gönderildi, \nTeşekkürler';
  //----------------------------------------------------------------------------------------
  //* -> Login Page
  //----------------------------------------------------------------------------------------
  static const String loginText = 'Giriş Yap'; // Login Text
  static const String registerText = 'Kayıt Ol'; // Register Text
  static const String forgotPasswordText =
      'Şifremi Unuttum'; // Forgot Password Text
  static const String userNotFounded =
      'Kullanıcı Bulunamadı veya şifre yalış'; // Login Page Title
  //----------------------------------------------------------------------------------------
  //* -> Task Page
  //----------------------------------------------------------------------------------------
  static const String taskPageTitle = 'Görevler'; // Task Page Title
  //----------------------------------------------------------------------------------------
  //? Other
  //----------------------------------------------------------------------------------------
  static const preferanceDeviceSavedControllText = "isDeviceSaved";
  //----------------------------------------------------------------------------------------

  //!----------------------------------------------------------------------------------------
  //! Size
  //!----------------------------------------------------------------------------------------
  //? General Size
  //----------------------------------------------------------------------------------------
  static const double generalSize = 0.02; // Padding
  static const double mediumSize = 0.04;
  static const double largeSize = 0.06;
  static const double bigSize = 0.08;
  //----------------------------------------------------------------------------------------
  //? Padding
  //----------------------------------------------------------------------------------------
  static const double generalPadding = 0.02; // Padding
  static const double mediumPadding = 0.04;
  static const double largePadding = 0.06;
  static const double bigPadding = 0.08;
  //----------------------------------------------------------------------------------------
  //? Font Size
  //----------------------------------------------------------------------------------------
  static const double generalFontSize = 0.02; // Font Size
  static const double mediumFontSize = 0.04;
  static const double largeFontSize = 0.06;
  static const double bigFontSize = 0.08;
  //----------------------------------------------------------------------------------------
  //? Icon Size
  //----------------------------------------------------------------------------------------
  static const double generalIconSize = 0.02; // Icon Size
  static const double mediumIconSize = 0.04;
  static const double largeIconSize = 0.06;
  static const double bigIconSize = 0.08;
  //----------------------------------------------------------------------------------------

  //!----------------------------------------------------------------------------------------
  //! Colors
  //!----------------------------------------------------------------------------------------
  //? General Colors
  //----------------------------------------------------------------------------------------
  static const Color primaryColor = Color(0xFF3DA2DB); // Primary Color
  static const Color secondaryColor = Color(0xFF0A0A0A); // Secondary Color
  static const Color tertiaryColor = Color(0xFF0A0A0A); // Tertiary Color
  static const Color quaternaryColor = Color(0xFF0A0A0A); // Quaternary Color
  //----------------------------------------------------------------------------------------
  //? Text Colors
  //----------------------------------------------------------------------------------------
  static const Color primaryTextColor = Color(0xFF0A0A0A); // Primary Text Color
  static const Color secondaryTextColor =
      Color(0xFF3DA2DB); // Secondary Text Color
  static const Color tertiaryTextColor =
      Color(0xFF0A0A0A); // Tertiary Text Color
  //---------------------------------------------------------------------------------------
  //? Icon Colors
  static const Color primaryIconColor = Color(0xFF0A0A0A); // Primary Icon Color
  static const Color secondaryIconColor =
      Color(0xFF0A0A0A); // Secondary Icon Color
  static const Color tertiaryIconColor =
      Color(0xFF0A0A0A); // Tertiary Icon Color
  //----------------------------------------------------------------------------------------
}
