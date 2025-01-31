import 'package:live_polling_voting_app/live_polling_voting_app.dart';
import 'package:hive/hive.dart';

part 'poll.g.dart';

@HiveType(typeId: 0)
class Poll {
  Poll({required this.id,required this.question, required this.options, this.totalVotes = 0});

  ///[id] is the unique identifier of the poll
  @HiveField(0)
  int id;

  ///[question] is the question of the poll
  @HiveField(1)
  String question;

  ///[options] is the list of options for the poll
  @HiveField(2)
  List<PollOption> options;

  ///[totalVotes] is the total number of votes cast on the poll
  @HiveField(3)
  int totalVotes;

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
        id: json['id'],
        question: json['question'],
        options: json['options'].cast<String>(),
        totalVotes: json['votes'].cast<int>());
  }

  Map<String, dynamic> toJson() {
    return {'id':id, 'question': question, 'options': options, 'totalVotes': totalVotes};
  }
}
