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
                return Dismissible(
                  key: ValueKey<String>(poll.id),
                  onDismissed: (direction) {
                    ref.read(pollProvider.notifier).deletePoll(poll.id);
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.cancel),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.yellow.shade100
                            : Colors.purple.shade100),
                    child: ListTile(
                      title: Text(poll.question,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall),
                      subtitle: Text("Total Votes: ${poll.totalVotes}",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge),

                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            if (_hasVoted(poll.options)) {
                              return Scaffold(
                                  appBar: AppBar(
                                    title: Text("Poll Result"),
                                  ),
                                  body: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: PollResult(
                                        poll: poll, loggedInUser: loggedInUser),
                                  ));
                            } else {
                              return PollVotingScreen(
                                  poll: poll, loggedInUser: loggedInUser);
                            }
                          },
                        ));
                      },
                    ),
                  ),
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
