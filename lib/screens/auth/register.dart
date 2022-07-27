import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../colors/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  bool _passwordVisibility = true;
  bool _confirmPasswordVisibility = true;

  void _onFormSubmit() {
    _formKey.currentState!.validate();
  }

  void _changePasswordVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
    });
  }

  void _changeConfirmPasswordVisibility() {
    setState(() {
      _confirmPasswordVisibility = !_confirmPasswordVisibility;
    });
  }

  void _redirectToLoginPage() {
    print('hello');
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
                    horizontal: MediaQuery.of(context).size.width * 4 / 100,
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
                              child: TextFormField(
                                cursorColor: MyColors.greenColor,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyColors.greenColor,
                                    ),
                                  ),
                                  label: Text('Username'),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  if (value.length < 3) {
                                    return 'Username must have 3 or more characters';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: MyColors.greenColor,
                                decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyColors.greenColor,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  label: Text('Email'),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return 'Please enter a valid Email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                cursorColor: MyColors.greenColor,
                                decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyColors.greenColor,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  label: Text('Phone'),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
                              ),
                              child: TextFormField(
                                controller: _pass,
                                obscureText: _passwordVisibility,
                                cursorColor: MyColors.greenColor,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: _changePasswordVisibility,
                                    icon: _passwordVisibility
                                        ? const Icon(
                                            FontAwesomeIcons.eye,
                                            size: 16,
                                            color: Colors.grey,
                                          )
                                        : const Icon(
                                            FontAwesomeIcons.eyeSlash,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyColors.greenColor,
                                    ),
                                  ),
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  label: const Text('Password'),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  if (value.length < 5) {
                                    return 'Password must have 4 or more characters';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
                              ),
                              child: TextFormField(
                                controller: _confirmPass,
                                obscureText: _confirmPasswordVisibility,
                                cursorColor: MyColors.greenColor,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: _changeConfirmPasswordVisibility,
                                    icon: _confirmPasswordVisibility
                                        ? const Icon(
                                            FontAwesomeIcons.eye,
                                            size: 16,
                                            color: Colors.grey,
                                          )
                                        : const Icon(
                                            FontAwesomeIcons.eyeSlash,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyColors.greenColor,
                                    ),
                                  ),
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  label: const Text('Confirm password'),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please re-enter your password';
                                  }
                                  if (_pass.value.text !=
                                      _confirmPass.value.text) {
                                    return 'Passwords don\'t match';
                                  }
                                  return null;
                                },
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
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                      MyColors.greenColor,
                                    ),
                                  ),
                                  onPressed: _onFormSubmit,
                                  child: const Text('Sign Up'),
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
                                    fontSize: 13,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _redirectToLoginPage,
                                  child: const Text(
                                    ' Signup',
                                    style: TextStyle(
                                      color: MyColors.greenColor,
                                      fontSize: 13,
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
