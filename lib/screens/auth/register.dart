import 'package:flutter/material.dart';

import './login.dart';
import '../../colors/my_colors.dart';
import '../../widgets/input_fields/text_input_field.dart';
import '../../widgets/input_fields/password_text_input_field.dart';
import '../../helpers/input_field_validators.dart';
import '../../widgets/buttons/custom_elevated_button.dart';
import '../../helpers/auth.dart';
import '../../widgets/loading/custom_circular_progress_indicator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  bool _isLoading = false;

  void _onFormSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      int responseStatusCode = await Auth.register(
        _username.value.text,
        _email.value.text,
        _phone.value.text,
        _pass.value.text,
      );

      setState(() {
        _isLoading = false;
      });
    }
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
                keyboardUp
                    ? Container()
                    : const Image(
                        image: AssetImage('assets/images/carrot.png'),
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 6 / 100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      keyboardUp
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width *
                                    0.2 /
                                    100,
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                      keyboardUp
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height *
                                    1.5 /
                                    100,
                                bottom: MediaQuery.of(context).size.height *
                                    2 /
                                    100,
                                left: MediaQuery.of(context).size.width *
                                    0.2 /
                                    100,
                              ),
                              child: const Text(
                                'Enter your credentials to continue',
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
                                controller: _username,
                                keyboardType: TextInputType.text,
                                label: 'Username',
                                validatorCallback:
                                    InputFieldValidators.usernameValidator,
                              ),
                            ),
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
                                validatorCallback:
                                    InputFieldValidators.emailValidator,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
                              ),
                              child: TextInputField(
                                controller: _phone,
                                keyboardType: TextInputType.phone,
                                label: 'Phone',
                                validatorCallback:
                                    InputFieldValidators.phoneNumberValidator,
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
                                validatorCallback:
                                    InputFieldValidators.passwordValidator,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
                              ),
                              child: PasswordTextInputField(
                                passwordType: 'confirmPassword',
                                controller: _confirmPass,
                                label: 'Confirm password',
                                keyboardType: TextInputType.text,
                                validatorCallback: (value) =>
                                    InputFieldValidators
                                        .confirmPasswordValidator(value,
                                            passwordController: _pass,
                                            confirmPasswordController:
                                                _confirmPass),
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
                                  content: _isLoading
                                      ? const CustomCircularProgressIndicator()
                                      : const Text('Sign Up'),
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
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.5,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushReplacementNamed(
                                    LoginScreen.routeName,
                                  ),
                                  child: const Text(
                                    ' Login',
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
