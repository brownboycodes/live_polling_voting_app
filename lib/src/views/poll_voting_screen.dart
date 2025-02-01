import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';

class PollVotingScreen extends ConsumerStatefulWidget {
  const PollVotingScreen({super.key, required this.poll, required this.loggedInUser});
  ///[poll] is the [Poll] for which the user shall cast their vote
  final Poll poll;

  ///[loggedInUser] will be used for voting polls
  final String loggedInUser;

  @override
  ConsumerState<PollVotingScreen> createState() => _PollVotingScreenState();
}

class _PollVotingScreenState extends ConsumerState<PollVotingScreen> {

  bool _voted = false;

  @override
  Widget build(BuildContext context) {
final poll = ref.watch(activePollProvider(widget.poll));
    return Scaffold(
      appBar: AppBar(
        title: Text(_voted?"Poll Result":"Cast your Vote"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            PollResult(poll: poll, loggedInUser: widget.loggedInUser),
           if(!_voted) for(int index=0; index<widget.poll.options.length; index++)
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(widget.poll.options[index].option)),
                    const SizedBox(width: 10,),
                    ElevatedButton(onPressed: () {
                        setState(() {
                          _voted=true;
                        });
                        ref.read(activePollProvider(widget.poll).notifier).vote(index, widget.loggedInUser,ref);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      )
                    ), child: Text("VOTE",style: TextStyle(color: Colors.white)),

                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
