import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static getInstance() async {
    return SharedPreferences.getInstance();
  }
}