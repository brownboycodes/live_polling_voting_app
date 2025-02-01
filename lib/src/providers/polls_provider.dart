import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';

/// StateNotifier to manage the list of Polls
class PollNotifier extends StateNotifier<List<Poll>> {
  PollNotifier() : super([]) {
    _loadPolls(); // Load existing polls when the app starts
  }

  final Box<Poll> _box = Hive.box<Poll>('polls');

  /// Load all polls from Hive
  void _loadPolls() {
    state = _box.values.toList();
  }

  /// Add a new Poll
  Future<void> addPoll(Poll poll) async {
    await _box.put(poll.id, poll);
    _loadPolls();

  }

  /// Update an existing Poll
  Future<void> updatePoll(Poll updatedPoll) async {
    await _box.put(updatedPoll.id, updatedPoll);
    _loadPolls();
  }

  /// Delete a Poll
  Future<void> deletePoll(int pollId) async {
    await _box.delete(pollId);
    _loadPolls();
  }

  void recordVote(Poll poll, PollOption option){

  }
}

/// Riverpod Provider for PollNotifier
final pollProvider = StateNotifierProvider<PollNotifier, List<Poll>>((ref) {
  return PollNotifier();
});
