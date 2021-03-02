 import 'package:parenter/common/Singelton.dart';
import 'package:shared_preferences/shared_preferences.dart';

var USER_TOKEN_STRING = "user_token_string";
 var USER_ID = "user_id";
 var USER_TYPE = "user_type";

class SharedPreferenceManager{




  saveUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_TOKEN_STRING, Global.token);
  }

  getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(USER_TOKEN_STRING);
    return stringValue;
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(USER_TOKEN_STRING);
    prefs.remove(USER_ID);
    prefs.remove(USER_TYPE);

  }
  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(USER_ID);
    return stringValue;
  }

  setUserId(String Id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_ID, Id);
  }
  saveUserType(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(USER_TYPE, value);
  }

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(USER_TYPE);
    return value;
  }



 }