import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:live_polling_voting_app/live_polling_voting_app.dart';

class CreatePollScreen extends ConsumerStatefulWidget {
  const CreatePollScreen({super.key, required this.loggedInUser});

  ///[loggedInUser] will be used for creating polls
  final String loggedInUser;

  @override
  _CreatePollScreenState createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends ConsumerState<CreatePollScreen> {
  final _formKey = GlobalKey<FormState>();
  late ButtonStyling defaultButtonStyle;
  late PollOptionStyle pollOptionStyle;
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = List.generate(
    2,
    (index) => TextEditingController(),
  );
  late CreatePollScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = CreatePollScreenViewModel(ref, widget.loggedInUser);
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addOptionField() {
    setState(() {
      _optionControllers.add(TextEditingController());
    });
  }

  /// Delete an option field (Ensuring at least two fields remain)
  void _deleteOptionField(int index) {
    if (_optionControllers.length > 2) {
      setState(() {
        _optionControllers[index].dispose();
        _optionControllers.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("At least two options are required.")),
      );
    }
  }

  @override
  void didChangeDependencies() {
    defaultButtonStyle = StyleHelper.getTheme<ButtonStyling>(
        context: context, defaultTheme: ButtonStyling.defaultStyle());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Poll")),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Enter your question:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _questionController,
                  decoration: InputDecoration(
                    hintText: "Type your question here...",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => viewModel.questionInputValidator(value,"Please enter a question"), // Validation
                ),
                SizedBox(height: 20),
                Text("Enter options:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Column(
                  children: _optionControllers.asMap().entries.map((entry) {
                    int index = entry.key;
                    TextEditingController controller = entry.value;

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller,
                              decoration: InputDecoration(
                                hintText: "Option ${index + 1}",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) => viewModel.questionInputValidator(value, "Option ${index + 1} is required") , // Validation
                            ),
                          ),
                          SizedBox(width: 10),
                          if (_optionControllers.length >
                              2) // Displaying delete button only if there are more than two options
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteOptionField(index),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _optionControllers.length < 4
                            ? _addOptionField
                            : null,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: defaultButtonStyle.borderRadius ??
                                  BorderRadius.zero,
                              side: defaultButtonStyle.borderSide ??
                                  BorderSide.none),
                        ),
                        child: Text("Add Option"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          viewModel.saveForm(
                              context: context,
                              formKey: _formKey,
                              optionControllers: _optionControllers,
                              questionController: _questionController);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple.shade300,
                            shape: RoundedRectangleBorder(
                                borderRadius: defaultButtonStyle.borderRadius ??
                                    BorderRadius.zero,
                                side: defaultButtonStyle.borderSide ??
                                    BorderSide.none)),
                        child: Text(
                          "Create Poll",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
