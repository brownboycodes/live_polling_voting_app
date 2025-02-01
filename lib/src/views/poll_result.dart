import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';

class PollResult extends ConsumerWidget {
  const PollResult(
      {super.key,
      required this.poll,
      required this.loggedInUser,});

  ///[poll] is the [Poll] for which the user shall cast their vote
  final Poll poll;

  ///[loggedInUser] will be used for voting polls
  final String loggedInUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.purple.shade300)),
      child: Column(
        children: [
          Text(poll.question),
          Text("Total votes: ${poll.totalVotes}"),
          for (PollOption option in poll.options)
            Wrap(
              direction: Axis.vertical,
              spacing: 10,
              children: [
                Row(
                  children: [
                    Flexible(flex: 9, child: Text(option.option)),
                    Flexible(
                        flex: 1, child: Text("${option.votedBy.length} votes"))
                  ],
                ),
                LinearProgressIndicator(
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.purple.shade300,
                  value: option.votedBy.length/poll.totalVotes,
                )
              ],
            )
        ],
      ),
    );
  }
}
