import 'package:flutter/material.dart';

import './register.dart';
import '../../colors/my_colors.dart';
import '../../widgets/input_fields/text_input_field.dart';
import '../../widgets/input_fields/password_text_input_field.dart';
import '../../helpers/input_field_validators.dart';
import '../../widgets/buttons/custom_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  void _onFormSubmit() {
    _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardUp =
        MediaQuery.of(context).viewInsets.bottom != 0 ? true : false;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background.png'),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Image(
                  image: AssetImage('assets/images/carrot.png'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 6 / 100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.2 / 100,
                        ),
                        child: const Text(
                          'Loging',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 1.5 / 100,
                          bottom: MediaQuery.of(context).size.height * 2 / 100,
                          left: MediaQuery.of(context).size.width * 0.2 / 100,
                        ),
                        child: const Text(
                          'Enter your email and password',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
                              ),
                              child: TextInputField(
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                label: 'Email',
                                validatorCallback: (value) =>
                                    InputFieldValidators.checkIfEmpty(value,
                                        errorMessage: 'Please enter an email'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
                              ),
                              child: PasswordTextInputField(
                                passwordType: 'password',
                                controller: _pass,
                                label: 'Password',
                                keyboardType: TextInputType.text,
                                validatorCallback: (value) =>
                                    InputFieldValidators.checkIfEmpty(value,
                                        errorMessage:
                                            'Please enter a password'),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height *
                                    11 /
                                    100,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                margin: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      1.5 /
                                      100,
                                ),
                                child: CustomElevatedButton(
                                  content: const Text('Log In'),
                                  backgroundColor: MyColors.greenColor,
                                  onSubmitCallback: _onFormSubmit,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      keyboardUp
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.5,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushReplacementNamed(
                                    RegisterScreen.routeName,
                                  ),
                                  child: const Text(
                                    ' Signup',
                                    style: TextStyle(
                                      color: MyColors.greenColor,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
