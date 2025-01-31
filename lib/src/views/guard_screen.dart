import 'package:flutter/material.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuardScreen extends StatelessWidget {
  const GuardScreen({super.key});

  Future<bool> _checkStoredValue() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedValue = prefs.getString('saved_text');
    return storedValue != null && storedValue.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _checkStoredValue(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          } else {
            bool hasStoredValue = snapshot.data ?? false;

            Future.microtask(() {
              if(context.mounted){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    hasStoredValue ? PollsScreen() : LoginScreen(),
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
