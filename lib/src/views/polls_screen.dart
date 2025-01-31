import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';

class PollsScreen extends ConsumerWidget {
  const PollsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final polls = ref.watch(pollProvider); // Watch Poll State

    return Scaffold(
      appBar: AppBar(
        title: Text("Polls"),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(sharedPrefsProvider.notifier).deleteText();
              },
              icon: Icon(
                Icons.power_settings_new_rounded,
                color: Colors.redAccent,
              ))
        ],
      ),
      body: polls.isEmpty
          ? Center(child: Text("No Polls Available"))
          : ListView.builder(
              itemCount: polls.length,
              itemBuilder: (context, index) {
                final poll = polls[index];
                return ListTile(
                  title: Text(poll.question),
                  subtitle: Text("Total Votes: ${poll.totalVotes}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          ref.read(pollProvider.notifier).deletePoll(poll.id);
                        },
                      ),
                    ],
                  ),
                  onTap: () {},
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePollScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

}
