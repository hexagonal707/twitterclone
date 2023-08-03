import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitterclone/screens/createProfile/create_profile_page.dart';
import 'package:twitterclone/validator.dart';
import 'package:twitterclone/widgets/custom_alertdialog.dart';
import 'package:twitterclone/widgets/custom_container_textfield.dart';
import 'package:twitterclone/widgets/custom_filled_button.dart';

import '../../widgets/custom_page_route_builder.dart';

class SignUpPage extends StatefulWidget {
  static const String id = 'signup_page';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firebaseauth = FirebaseAuth.instance;
  late String savedEmail;
  late String savedPassword;

  //TextFormField Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isButtonActive = true;

  Future signUp() async {
    try {
      await _firebaseauth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      savedEmail = _emailController.text.trim();
      savedPassword = _passwordController.text.trim();

      _firebaseauth.currentUser?.delete();

      if (!mounted) return;
      Navigator.of(context).push(
        CustomPageRouteBuilder(
            child: CreateProfilePage(
                savedEmail: savedEmail, savedPassword: savedPassword),
            transitionType: SharedAxisTransitionType.horizontal),
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          showDialog(
            context: context,
            builder: (context) {
              return const CustomAlertDialog(
                title: Text('Invalid email address',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start),
                content: Text(
                  'Please enter a valid email address and try again.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
              );
            },
          );
          break;

        case "email-already-in-use":
          showDialog(
            context: context,
            builder: (context) {
              return const CustomAlertDialog(
                title: Text('Existing email address',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start),
                content: Text(
                  'An account with this email address already exists. Please try again.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
              );
            },
          );
          break;

        case "weak-password":
          showDialog(
            context: context,
            builder: (context) {
              return const CustomAlertDialog(
                title: Text('Weak password',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start),
                content: Text(
                  'Enter a password of minimum 6 characters. Please try again.',
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

  Color? cursorColor() {
    return MediaQuery.of(context).platformBrightness == Brightness.light
        ? Colors.green[800]
        : Colors.green[300];
  }

  @override
  void initState() {
    super.initState();

    updateButtonActive();

    _emailController.addListener(updateButtonActive);
    _passwordController.addListener(updateButtonActive);
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
            colorSchemeSeed: Colors.green,
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
                      //Sign Up Text
                      const Text(
                        'Sign Up',
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

                      //Password TextField
                      CustomContainerTextField(
                        cursorColor: cursorColor(),
                        controller: _passwordController,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: Validator.password,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
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
                        colorSchemeSeed: Colors.green,
                        onPressed: isButtonActive
                            ? () {
                                setState(
                                  () {
                                    isButtonActive;
                                  },
                                );

                                signUp();
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
