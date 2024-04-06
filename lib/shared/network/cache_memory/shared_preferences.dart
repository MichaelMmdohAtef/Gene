import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{

  static SharedPreferences? sharedPreferences;

  ///initialize shared preference variable
  static init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

  ///set local string with key
  static Future<bool> setString({
    required String key,
    required String value,
  })async{
    return await sharedPreferences!.setString(key, value);
  }


  ///set local boolean with key
  static Future<bool> setBoolean({
    required String key,
    required bool value,
})async{
    return await sharedPreferences!.setBool(key, value);
  }

  ///set local data with key
  static dynamic getData({
    required String key,
  })async{
    return sharedPreferences!.get(key);
  }

  ///remove local data with key
  static dynamic removeData({
    required String key,
  })async{
    return sharedPreferences!.remove(key);
  }

}