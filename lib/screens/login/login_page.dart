import 'package:animations/animations.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../page_navigator.dart';
import '../../widgets/custom_alertdialog.dart';
import '../../widgets/custom_container_textfield.dart';
import '../../widgets/custom_filled_button.dart';
import '../../widgets/custom_page_route_builder.dart';
import '../resetPassword/reset_password_page.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _State();
}

class _State extends State<LoginPage> {
  final _firebaseauth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isButtonActive = true;

  Future logIn() async {
    if (!mounted) return;
    try {
      await _firebaseauth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
          context,
          CustomPageRouteBuilder(
              child: const PageNavigator(),
              transitionType: SharedAxisTransitionType.scaled),
          (route) => false);
    } on FirebaseException catch (e) {
      switch (e.code) {
        case "invalid-email":
          showDialog(
            context: context,
            builder: (context) {
              return const CustomAlertDialog(
                title: Text(
                  'Incorrect email or password',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                content: Text(
                  'Please enter a valid email address or password and try again.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
              );
            },
          );
          break;

        case "wrong-password":
          showDialog(
            context: context,
            builder: (context) {
              return const CustomAlertDialog(
                title: Text(
                  'Incorrect email or password',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
                content: Text(
                  'Please enter a valid email address or password and try again.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
              );
            },
          );
          break;

        case "user-not-found":
          showDialog(
            context: context,
            builder: (context) {
              return const CustomAlertDialog(
                title: Text(
                  'Incorrect email or password',
                  textAlign: TextAlign.start,
                ),
                content: Text(
                  'Please enter a valid email address or password and try again.',
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
    final isButtonActive =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

    setState(
      () {
        this.isButtonActive = isButtonActive;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    updateButtonActive();
    _passwordController.addListener(updateButtonActive);
    _emailController.addListener(updateButtonActive);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Theme(
          data: ThemeData(
            fontFamily: 'Inter',
            brightness: MediaQuery.of(context).platformBrightness,
            colorSchemeSeed: Colors.lightBlue,
            useMaterial3: true,
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Log In Text
                      const Text(
                        'Log In',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30.0,
                        ),
                      ),

                      //Email TextField
                      CustomContainerTextField(
                        controller: _emailController,
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
                      //Password TextField
                      CustomContainerTextField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                            RegExp('[ ]'),
                          )
                        ],
                        textInputAction: TextInputAction.done,
                        labelText: 'Password',
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 20.0, right: 20.0),
                      ),

                      //Continue Button
                      CustomFilledButton(
                        colorSchemeSeed: Colors.lightBlueAccent,
                        onPressed: isButtonActive
                            ? () {
                                setState(() {
                                  isButtonActive;
                                });

                                logIn();
                              }
                            : null,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0),
                        ),
                      ),

                      //Forgot Password Button
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CustomPageRouteBuilder(
                                  child: const ForgotPasswordPage(),
                                  transitionType:
                                      SharedAxisTransitionType.horizontal),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
