import 'package:flutter/material.dart';

import '../buttons/custom_elevated_button.dart';
import '../../colors/my_colors.dart';

class AuthModal {
  static Widget authModal(
    BuildContext context, {
    String? title,
    String? subtitle,
    dynamic image,
    buttonText,
    buttonCallback,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 10 / 100,
      ),
      child: Dialog(
        alignment: Alignment.bottomCenter,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 70 / 100,
          width: MediaQuery.of(context).size.width * 90 / 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              image!,
              Column(
                children: [
                  Text(
                    title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 7 / 100,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width * 10 / 100),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 7 / 100,
                    child: CustomElevatedButton(
                      backgroundColor: MyColors.greenColor,
                      content: Text(buttonText),
                      onSubmitCallback: buttonCallback,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
