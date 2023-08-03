
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../validator.dart';
import '../../widgets/custom_alertdialog.dart';
import '../../widgets/custom_container_textfield.dart';
import '../../widgets/custom_filled_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String id = 'forgot_password_page';

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool isButtonActive = true;

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      showDialog(
        context: context,
        builder: (context) {
          return const CustomAlertDialog(
            title: Text('Reset link Sent',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start),
            content: Text(
              'A link to reset your password has been sent to your email.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.0,
              ),
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          showDialog(
            context: context,
            builder: (context) {
              return const CustomAlertDialog(
                title: Text('Incorrect email address',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start),
                content: Text(
                  'There is no account associated with this email address. Please try again.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
              );
            },
          );
          break;

        case "invalid-email":
          showDialog(
            context: context,
            builder: (context) {
              return const CustomAlertDialog(
                title: Text('Incorrect email address',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start),
                content: Text(
                  'There is no account associated with this email address. Please try again.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
              );
            },
          );
          break;
      }
    }
  }

  void updateButtonActive() {
    final isButtonActive = _emailController.text.isNotEmpty;

    setState(
      () {
        this.isButtonActive = isButtonActive;
      },
    );
  }

  Color? cursorColor() {
    return MediaQuery.of(context).platformBrightness == Brightness.light
        ? Colors.brown[700]
        : Colors.orange[200];
  }

  @override
  void initState() {
    super.initState();

    updateButtonActive();
    _emailController.addListener(updateButtonActive);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData(
          fontFamily: 'Inter',
          brightness: MediaQuery.of(context).platformBrightness,
          colorSchemeSeed: Colors.orange,
          useMaterial3: true,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBar(leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            )),
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Reset your password Text
                      const Text(
                        'Reset your password',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30.0,
                        ),
                      ),

                      //Email TextField
                      CustomContainerTextField(
                        cursorColor: cursorColor(),
                        controller: _emailController,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: Validator.email,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9.@]'),
                          ),
                        ],
                        textInputAction: TextInputAction.next,
                        labelText: 'Email Address',
                        padding: const EdgeInsets.only(
                            top: 40.0, left: 20.0, right: 20.0),
                      ),

                      //Reset Password Button
                      CustomFilledButton(
                        colorSchemeSeed: Colors.orange,
                        onPressed: isButtonActive
                            ? () {
                                setState(
                                  () {
                                    isButtonActive;
                                  },
                                );

                                passwordReset();
                              }
                            : null,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
