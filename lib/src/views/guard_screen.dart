import 'package:flutter/material.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuardScreen extends StatelessWidget {
  const GuardScreen({super.key});

  Future<String?> _getStoredUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedValue = prefs.getString(DataBaseConstants.pref);
    return storedValue;
  }

  bool _checkUsernameValidity(String? storedValue){
    return storedValue != null && storedValue.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: _getStoredUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          } else {
            final storedValue=snapshot.data;
            bool hasStoredValue = _checkUsernameValidity(storedValue);

            Future.microtask(() {
              if(context.mounted){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    hasStoredValue ? PollsScreen(loggedInUser:storedValue! ,) : LoginScreen(),
                  ),
                );
              }
            });

            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
