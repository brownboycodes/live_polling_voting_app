import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';
import 'package:live_polling_voting_app/src/views/poll_voting_screen.dart';

class PollsScreen extends ConsumerWidget {
  const PollsScreen({super.key, required this.loggedInUser});

  ///[loggedInUser] will be used for creating and voting polls
  final String loggedInUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final polls = ref.watch(pollProvider); // Watch Poll State

    return Scaffold(
      appBar: AppBar(
        title: Text("Polls"),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(sharedPrefsProvider.notifier).deleteText().then(
                  (value) {
                    if (context.mounted) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ));
                    }
                  },
                );
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
                  // trailing: Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     IconButton(
                  //       icon: Icon(Icons.delete, color: Colors.red),
                  //       onPressed: () {
                  //         ref.read(pollProvider.notifier).deletePoll(poll.id);
                  //       },
                  //     ),
                  //   ],
                  // ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return _hasVoted(poll.options)
                            ? PollResult(poll: poll, loggedInUser: loggedInUser)
                            : PollVotingScreen(
                                poll: poll, loggedInUser: loggedInUser);
                      },
                    ));
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePollScreen(
                  loggedInUser: loggedInUser,
                ),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  bool _hasVoted(List<PollOption> options) {
    bool hasVoted = false;

    for (PollOption option in options) {
      hasVoted = option.hasVoted(loggedInUser);
      if (hasVoted) {
        break;
      }
    }
    return hasVoted;
  }
}
