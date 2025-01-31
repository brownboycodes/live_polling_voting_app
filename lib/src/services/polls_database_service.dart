import 'package:hive_flutter/hive_flutter.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';
import 'package:path_provider/path_provider.dart';

class PollDatabaseService {
  static final PollDatabaseService _singleton = PollDatabaseService._internal();

  factory PollDatabaseService() {
    return _singleton;
  }

  PollDatabaseService._internal();

  late Box<Poll> _box;

  /// Initializes Hive and opens the database box
  Future<void> initialize() async {
    final document = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(document.path);
    //we register adapters only once
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(PollAdapter());
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(PollOptionAdapter());
    _box = await Hive.openBox<Poll>(DataBaseConstants.box);
  }

  /// Save a poll
  Future<void> savePoll(Poll poll) async {
    if (!_box.isOpen) await initialize(); // Ensure box is open
    await _box.put(poll.id, poll);
  }

  /// Fetch all polls
  List<Poll> fetchPolls() {
    if (!_box.isOpen) return <Poll>[]; // Ensure box is open
    return _box.values.toList();
  }

  /// Delete a poll by ID
  Future<void> deletePoll(int pollId) async {
    if (!_box.isOpen) await initialize(); // Ensure box is open
    await _box.delete(pollId);
  }

  /// Update an existing poll
  Future<void> updatePoll(Poll updatedPoll) async {
    if (!_box.isOpen) await initialize(); // Ensure box is open
    await _box.put(updatedPoll.id, updatedPoll);
  }

  /// Close Hive when the app is terminated
  Future<void> closeDatabase() async {
    await _box.close();
  }
}
