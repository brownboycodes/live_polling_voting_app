import 'package:hive/hive.dart';

part 'poll_option.g.dart';

@HiveType(typeId: 1)
class PollOption {
  PollOption({required this.id, required this.option, this.votedBy = const []});

  ///[id] is the unique identifier of the poll
  @HiveField(0)
  String id;

  ///[option] is the option of the poll
  @HiveField(1)
  String option;

  ///[votedBy] is the list of users who voted for the option
  @HiveField(2)
  List<String> votedBy;

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
        id: json['id'],
        option: json['option'],
        votedBy: json['votedBy'].cast<String>());
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'option': option, 'votedBy': votedBy};
  }

  @override
  String toString() {
    return 'PollOption{id: $id, option: $option, votedBy: $votedBy}';
  }

  bool hasVoted(String user){
    return votedBy.contains(user);
  }
}
