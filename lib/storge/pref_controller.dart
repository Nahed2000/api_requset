import 'package:api_first/model/student_api.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum PrefKey {
  id,loggedIn,fullName,gender,token,email
}
class SharedPrefController {
  static final SharedPrefController _instance = SharedPrefController._();
  late SharedPreferences _sharedPreferences;

  factory SharedPrefController() {
    return _instance;
  }
  SharedPrefController._();
   Future<void>initPrefController()async{
     _sharedPreferences = await SharedPreferences.getInstance();
   }
   Future<void>save({required Student student})async{
    _sharedPreferences.setBool(PrefKey.loggedIn.toString(), true);
    _sharedPreferences.setInt(PrefKey.id.toString(), student.id);
    _sharedPreferences.setString(PrefKey. email.toString(), student.email);
    _sharedPreferences.setString(PrefKey.fullName.toString(), student.fullName);
    _sharedPreferences.setString(PrefKey.gender.toString(), student.gender);
    _sharedPreferences.setString(PrefKey.token.toString(), 'Bearer ${student.token}');
   }
   String get token => _sharedPreferences.getString(PrefKey.token.toString())??'';
   bool get isLogin =>_sharedPreferences.getBool(PrefKey.loggedIn.toString())??false;
   Future<void>clear()async=>await _sharedPreferences.clear();
}
