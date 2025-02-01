import 'package:live_polling_voting_app/live_polling_voting_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuardScreenViewModel {
  static final GuardScreenViewModel _singleton = GuardScreenViewModel._internal();

  factory GuardScreenViewModel() {
    return _singleton;
  }

  GuardScreenViewModel._internal();


  Future<String?> getStoredUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedValue = prefs.getString(DataBaseConstants.pref);
    return storedValue;
  }

  bool checkUsernameValidity(String? storedValue){
    return storedValue != null && storedValue.isNotEmpty;
  }
}