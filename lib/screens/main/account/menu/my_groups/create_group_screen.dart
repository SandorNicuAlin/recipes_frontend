import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../../colors/my_colors.dart';
import '../../../../../widgets/input_fields/text_input_field.dart';
import '../../../../../helpers/input_field_validators.dart';
import '../../../../../providers/group_provider.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void _onFormSubmit() async {
      if (_key.currentState!.validate()) {
        Map response = await Provider.of<GroupProvider>(context, listen: false)
            .createGroup(_controller.value.text);

        // print('statusCode: ${response['statusCode']}');
        // print('body: ${response['body']}');

        if (response['statusCode'] == 400) {
          // 400 - validation error
          String errorBody = '';
          response['body']['error']['name'].forEach((message) {
            errorBody = '${errorBody + message}\n';
          });
          if (true) {}
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                  errorBody,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red),
          );
          return;
        }

        if (true) {}
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        onActionTapCallback: _onFormSubmit,
        title: 'Create Group',
        border: const Border(
          bottom: BorderSide(color: Colors.black12),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Done',
                style: TextStyle(
                  color: MyColors.greenColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _key,
              child: TextInputField(
                autofocus: true,
                controller: _controller,
                keyboardType: TextInputType.text,
                label: 'Group name',
                validatorCallback: InputFieldValidators.groupNameValidator,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Write a group name and save it by pressing the "Done" button.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
