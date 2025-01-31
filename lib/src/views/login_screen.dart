import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';


class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storedText = ref.watch(sharedPrefsProvider);
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
            ElevatedButton(
              onPressed: () {
                ref.read(sharedPrefsProvider.notifier).saveText(textController.text);
              },
              child: Text("Login"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ref.read(sharedPrefsProvider.notifier).deleteText();
              },
              child: Text("Delete Text"),
            ),
            SizedBox(height: 20),
            Text(
              "Stored Value: $storedText",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
