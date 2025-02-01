import 'package:flutter/material.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';

class GuardScreen extends StatelessWidget {
  const GuardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: GuardScreenViewModel().getStoredUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          } else {
            final storedValue=snapshot.data;
            bool hasStoredValue = GuardScreenViewModel().checkUsernameValidity(storedValue);

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
