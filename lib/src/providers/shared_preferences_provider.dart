import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Async Provider to access SharedPreferences instance
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // Will be overridden in ProviderScope
});

/// StateNotifier to manage shared preferences value
class SharedPreferencesNotifier extends StateNotifier<String> {
  final SharedPreferences _prefs;

  SharedPreferencesNotifier(this._prefs) : super(_prefs.getString('saved_text') ?? "No data found");

  /// Save string in SharedPreferences
  Future<void> saveText(String text) async {
    await _prefs.setString('saved_text', text);
    state = text; // Update Riverpod state
  }

  /// Delete string from SharedPreferences
  Future<void> deleteText() async {
    await _prefs.remove('saved_text');
    state = "No data found"; // Reset state
  }
}

/// Provider for managing SharedPreferences string
final sharedPrefsProvider = StateNotifierProvider<SharedPreferencesNotifier, String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SharedPreferencesNotifier(prefs);
});
