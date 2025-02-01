import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';

class ActivePollNotifier extends StateNotifier<Poll> {
  ActivePollNotifier(Poll poll) : super(poll);

  /// Updates the poll when a user votes for an option
  void vote(int index, String userId, WidgetRef ref) {
    List<PollOption> options = List.from(state.options);
    options[index] = PollOption(
    id: options[index].id,
    option: options[index].option,
    votedBy: List.from(options[index].votedBy)..add(userId),
  );

    state = Poll(
      id: state.id,
      question: state.question,
      options: options,
      totalVotes: state.totalVotes + 1, // Increase vote count
      createdBy: state.createdBy,
    );
    ref.read(pollProvider.notifier).updatePoll(state);
  }

}

final activePollProvider = StateNotifierProvider.autoDispose.family<ActivePollNotifier, Poll, Poll>((ref, initialPoll) {
  return ActivePollNotifier(initialPoll);
});

void onVote(Poll poll, int index, String userId, WidgetRef ref) {
  ref.read(activePollProvider(poll).notifier).vote(index, userId,ref);
}
