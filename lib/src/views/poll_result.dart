import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';

class PollResult extends StatelessWidget {
  const PollResult({
    super.key,
    required this.poll,
    required this.loggedInUser,
  });

  ///[poll] is the [Poll] for which the user shall cast their vote
  final Poll poll;

  ///[loggedInUser] will be used for voting polls
  final String loggedInUser;

  @override
  Widget build(BuildContext context) {
    final pollOptionStyle = StyleHelper.getTheme<PollOptionStyle>(
        context: context, defaultTheme: PollOptionStyle.defaultStyle());
    return Container(
      padding: EdgeInsets.all(8),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.purple.shade300)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              poll.question,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subtitle: Text("Total votes: ${poll.totalVotes<10000?poll.totalVotes:'10000+'}",
                style: Theme.of(context).textTheme.bodyLarge),
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 0,
          ),
          for (PollOption option in poll.options)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 9,
                          child: Text(option.option,
                              style: pollOptionStyle.textStyle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis)),
                      Flexible(
                          flex: 2,
                          child: Text(
                            "${option.votedBy.length} votes",
                            style: pollOptionStyle.voteCountStyle,
                          ))
                    ],
                  ),
                  if (poll.totalVotes != 0)
                    TweenAnimationBuilder<int>(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      tween: IntTween(
                        begin: 0,
                        end: option.votedBy.length,
                      ),
                      builder: (context, value, _) => LinearProgressIndicator(
                        value: value / poll.totalVotes,
                        backgroundColor:
                            pollOptionStyle.progressIndicatorBackgroundColor,
                        color: pollOptionStyle.progressIndicatorColor,
                        minHeight: 16.18,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    )
                ],
              ),
            )
        ],
      ),
    );
  }
}
