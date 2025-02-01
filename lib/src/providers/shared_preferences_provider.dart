import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_polling_voting_app/src/constants/database_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Async Provider to access SharedPreferences instance
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // Will be overridden in ProviderScope
});

/// StateNotifier to manage shared preferences value
class SharedPreferencesNotifier extends StateNotifier<String> {
  final SharedPreferences _prefs;

  SharedPreferencesNotifier(this._prefs) : super(_prefs.getString(DataBaseConstants.pref) ?? "No data found");

  /// Save string in SharedPreferences
  Future<String> saveText(String text) async {
    await _prefs.setString(DataBaseConstants.pref, text);
    state = text;
    return state;
  }

  /// Delete string from SharedPreferences
  Future<void> deleteText() async {
    await _prefs.remove(DataBaseConstants.pref);
    state = "No data found"; // Reset state
  }
}

/// Provider for managing SharedPreferences string
final sharedPrefsProvider = StateNotifierProvider<SharedPreferencesNotifier, String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SharedPreferencesNotifier(prefs);
});
