import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../widgets/input_fields/text_input_field.dart';
import '../../../../../helpers/input_field_validators.dart';
import '../../../../../colors/my_colors.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({Key? key, required this.characteristic})
      : super(key: key);

  final dynamic characteristic;

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String? Function(String?)? validatorMethod;

  void _onFormSubmit() async {
    String? selector;
    switch (widget.characteristic) {
      case 'Name':
        selector = 'username';
        break;
      case 'Email':
        selector = 'email';
        break;
      case 'Phone':
        selector = 'phone';
        break;
    }
    if (_key.currentState!.validate()) {
      Map response = await Provider.of<UserProvider>(
        context,
        listen: false,
      ).editUser(
        selector!,
        _controller.value.text,
      );

      // print('statusCode: ${response['statusCode']}');
      // print('body: ${response['body']}');

      if (response['statusCode'] == 400) {
        // 400 - validation error
        String errorBody = '';
        response['body']['error'][selector].forEach((message) {
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
      }

      if (true) {}
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onActionTapCallback: _onFormSubmit,
        title: widget.characteristic,
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
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          switch (widget.characteristic) {
            case 'Name':
              _controller.text = userProvider.user.username;
              validatorMethod = InputFieldValidators.usernameValidator;
              break;
            case 'Email':
              _controller.text = userProvider.user.email;
              validatorMethod = InputFieldValidators.emailValidator;
              break;
            case 'Phone':
              _controller.text = userProvider.user.phone;
              validatorMethod = InputFieldValidators.phoneNumberValidator;
              break;
          }
          return Padding(
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
                    label: widget.characteristic,
                    validatorCallback: validatorMethod,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Write another ${widget.characteristic} and save it by pressing the "Done" button.',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
