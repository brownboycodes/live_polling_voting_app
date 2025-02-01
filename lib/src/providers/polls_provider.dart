import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';

///[PollNotifier] StateNotifier to manage the list of Polls
class PollNotifier extends StateNotifier<List<Poll>> {
  PollNotifier() : super([]) {
    _loadPolls(); // Loads existing polls when the app starts
  }

  final Box<Poll> _box = Hive.box<Poll>('polls');

  ///[_loadPolls] loads all polls from Hive
  void _loadPolls() {
    state = _box.values.toList();
  }

  ///[addPoll] adds a new Poll
  Future<void> addPoll(Poll poll) async {
    await _box.put(poll.id, poll);
    _loadPolls();
  }

  ///[updatePoll] updates an existing Poll
  Future<void> updatePoll(Poll updatedPoll) async {
    await _box.put(updatedPoll.id, updatedPoll);
    _loadPolls();
    print("updated : ${ updatedPoll.options}");
  }

  ///[deletePoll] Delete a Poll
  Future<void> deletePoll(String pollId) async {
    await _box.delete(pollId);
    _loadPolls();
  }
}

/// Riverpod Provider for PollNotifier
final pollProvider = StateNotifierProvider<PollNotifier, List<Poll>>((ref) {
  return PollNotifier();
});
