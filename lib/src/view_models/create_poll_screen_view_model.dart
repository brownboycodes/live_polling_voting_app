import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';

class CreatePollScreenViewModel {
  static final CreatePollScreenViewModel _singleton =
      CreatePollScreenViewModel._internal();

  factory CreatePollScreenViewModel(WidgetRef ref, String loggedInUser) {
    _singleton.ref = ref;
    _singleton.loggedInUser = loggedInUser;
    return _singleton;
  }

  CreatePollScreenViewModel._internal();

  late WidgetRef ref;
  late String loggedInUser;

  ///[saveForm] shall be triggered on tap of create poll button
  void saveForm(
      {required BuildContext context,
      required GlobalKey<FormState> formKey,
      required TextEditingController questionController,
      required List<TextEditingController> optionControllers}) {
    if (formKey.currentState!.validate()) {
      String question = questionController.text.trim();
      List<String> options =
          optionControllers.map((c) => c.text.trim()).toList();
      createPoll(context: context, question: question, options: options);
    }
  }

  ///[createPoll] shall update hive db
  void createPoll(
      {required BuildContext context,
      required String question,
      required List<String> options}) {
    final poll = Poll(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        question: question,
        options: options
            .map(
              (option) => PollOption(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  option: option),
            )
            .toList(),
        createdBy: loggedInUser);
    ref.read(pollProvider.notifier).addPoll(poll).then(
      (value) {
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
    );
  }

  String? questionInputValidator(String? value,String onValidInput) =>
      value == null || value.trim().isEmpty ? onValidInput : null;
}
