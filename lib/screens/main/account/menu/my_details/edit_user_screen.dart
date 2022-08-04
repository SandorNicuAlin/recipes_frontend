import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../widgets/input_fields/text_input_field.dart';
import '../../../../../helpers/input_field_validators.dart';
import '../../../../../colors/my_colors.dart';
import '../../../../../widgets/modals/auth_modal.dart';
import '../../../../../helpers/auth.dart';

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
  bool _isLoading = false;

  void _navigatorPop() {
    Navigator.of(context).pop();
  }

  void _badServerRequestsHandle() {
    showDialog(
      context: context,
      builder: (context) => AuthModal.authModal(
        context,
        title: 'Server Error - 500',
        subtitle: 'Something went wrong!',
        image: const Image(
          image: AssetImage('assets/images/groceries.png'),
        ),
        buttonText: 'Try again',
        buttonCallback: _navigatorPop,
      ),
    );
  }

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
      setState(() {
        _isLoading = true;
      });
      // try {
      Map response = await Provider.of<UserProvider>(
        context,
        listen: false,
      ).editUser(
        selector!,
        _controller.value.text,
      );

      print('statusCode: ${response['statusCode']}');
      print('body: ${response['body']}');

      //   if (response['statusCode'] == 400) {
      //     // 400 - validation error
      //     // String errorBody = '';
      //     // response['body']['error'].forEach((key, value) {
      //     //   errorBody = '${errorBody + value[0]}\n';
      //     // });
      //     showDialog(
      //       context: context,
      //       builder: (context) => AuthModal.authModal(
      //         context,
      //         title: 'Update Failed!',
      //         subtitle: 'err',
      //         image: const Image(
      //           image: AssetImage('assets/images/groceries.png'),
      //         ),
      //         buttonText: 'Try again',
      //         buttonCallback: () => _navigatorPop(),
      //       ),
      //     );
      //   }
      // } on SocketException {
      //   // 500 - server error
      //   _badServerRequestsHandle();
      // } on FormatException {
      //   // request to a bad url
      //   _badServerRequestsHandle();
      // }
      // } catch (err) {
      //   print('err: ${err}');
      // }

      setState(() {
        _isLoading = false;
      });

      if (true) {}
      _navigatorPop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(
        context: context,
        title: widget.characteristic,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: _isLoading
                  ? const CupertinoActivityIndicator(radius: 8)
                  : InkWell(
                      onTap: _onFormSubmit,
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          color: MyColors.greenColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, user, child) {
          switch (widget.characteristic) {
            case 'Name':
              _controller.text = user.user.username!;
              break;
            case 'Email':
              _controller.text = user.user.email!;
              break;
            case 'Phone':
              _controller.text = user.user.phone!;
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
                    validatorCallback: InputFieldValidators.usernameValidator,
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
