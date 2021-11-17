import 'package:shared_preferences/shared_preferences.dart';

class LocalUserInfoPreferences {
  static void saveUserProfile(String email, String password) async {
    //Prefs instances
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  static Future<dynamic> getUserProfile() async {
    //Prefs instances
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    return {
      'email': email,
      'password': password,
    };
  }

  static void saveThemeMode(bool themeMode) async {
    //Prefs instances
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('themeMode', themeMode);
  }

  static Future<bool?> getThemeMode() async {
    //Prefs instances
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? themeMode = prefs.getBool('themeMode');

    return themeMode;
  }

  static void saveUserRequiredInfos(
    String userToken,
    int studentId,
    int userId,
    String accountState,
  ) async {
    //Prefs instances
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Then, save preference
    prefs.setString('_token', userToken);
    prefs.setInt('studentId', studentId);
    prefs.setInt('userId', userId);
    prefs.setString('accountState', accountState);
  }

  static Future<dynamic> getUserRequiredInfos() async {
    //Prefs instances
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _token = prefs.getString('_token');
    int? studentId = prefs.getInt('studentId');
    int? userId = prefs.getInt('userId');
    String? accountState = prefs.getString('accountState');

    return {
      '_token': _token,
      'studentId': studentId,
      'userId': userId,
      'accountState': accountState
    };
  }

  static Future<String?> getStartedKey() async {
    //Prefs instances
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? key = prefs.getString('startedKey');

    return key;
  }

  static void setStartedKey() async {
    //Prefs instances
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('startedKey', 'startedKey');
  }

  static void removeUserRequiredInfos() async {
    //Prefs instances
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Then, save preference
    prefs.remove('_token');
    prefs.remove('userId');
    prefs.remove('studentId');
    prefs.remove('accountState');
  }

  static void saveLanguage(String lang) async {
    //Prefs instances
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Then, save preference
    prefs.setString('lang', lang);
  }

  static Future<String?> getLanguage() async {
    //Prefs instances
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Then, save preference
    String? lang = prefs.getString('lang');

    return lang;
  }
}
