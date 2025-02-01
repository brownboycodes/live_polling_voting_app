import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';

class PollVotingScreen extends ConsumerWidget {
  const PollVotingScreen({super.key, required this.poll, required this.loggedInUser});

  ///[poll] is the [Poll] for which the user shall cast their vote
  final Poll poll;

  ///[loggedInUser] will be used for voting polls
  final String loggedInUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cast your Vote"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(child: Text(poll.question)),
              ],
            ),
            for(int index=0; index<poll.options.length; index++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(poll.options[index].option),
                  ElevatedButton(onPressed: () {
                    poll.options[index].votedBy.add(loggedInUser);
                    ref.read(pollProvider.notifier).updatePoll(poll);
                  }, child: Text("VOTE",style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),

                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
