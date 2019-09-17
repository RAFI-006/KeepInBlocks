import 'package:shared_preferences/shared_preferences.dart';
class SaveInPrefs
{
  static String SETISIDREGISTERED="SETISIDREGISTERED";
  SharedPreferences sharedPreferences;



  void setOnetimeReg(bool value )
  {
    sharedPreferences.setBool(SETISIDREGISTERED, value);
    sharedPreferences.commit();
  }

  bool isRegisterd()
  {
    return sharedPreferences.getBool(SETISIDREGISTERED);
  }




}