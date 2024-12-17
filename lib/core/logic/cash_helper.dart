import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{

  static late SharedPreferences _preferences;

  static Future<void> init()  async {
    _preferences=await SharedPreferences.getInstance();
  }

  static void saveLanguage(String lng){
    _preferences.setString("lng", lng);
  }

  static String getLanguage(){
    return _preferences.getString("lng")??"en";
  }


}