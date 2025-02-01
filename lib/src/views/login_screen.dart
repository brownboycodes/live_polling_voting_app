import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final storedText = ref.watch(sharedPrefsProvider);
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: "Enter username"),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(sharedPrefsProvider.notifier)
                          .saveText(textController.text)
                          .then(
                        (value) {
                          if (context.mounted) {
                            if (value.isNotEmpty) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PollsScreen(
                                      loggedInUser: value,
                                    ),
                                  ));
                            } else {
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please enter a username',
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.red,
                            ));
                            }
                          }
                        },
                      );
                    },
                    child: Text("Login"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
