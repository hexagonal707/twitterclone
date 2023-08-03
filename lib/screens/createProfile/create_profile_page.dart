import 'dart:io';

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitterclone/models/user_model.dart' as u;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../page_navigator.dart';
import '../../validator.dart';
import '../../widgets/custom_container_textfield.dart';
import '../../widgets/custom_filled_button.dart';
import '../../widgets/custom_page_route_builder.dart';


class CreateProfilePage extends StatefulWidget {
  static const String id = 'setup_profile_page';
  final String savedEmail;
  final String savedPassword;

  const CreateProfilePage({
    Key? key,
    required this.savedEmail,
    required this.savedPassword,
  }) : super(key: key);

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _firestore = FirebaseFirestore.instance;
  final _firebaseauth = FirebaseAuth.instance;
  late String _firstName;
  late String _lastName;
  late String _username;
  late String _phoneNumber;
  late final String _email = widget.savedEmail;
  late final String _password = widget.savedPassword;
  File? image;

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemp = File(image.path);
    this.image = imageTemp;
    setState(
      () {
        this.image = imageTemp;
      },
    );
  }

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  bool isButtonActive = true;

  @override
  void initState() {
    super.initState();

    updateButtonActive();
    _firstNameController.addListener(updateButtonActive);
    _lastNameController.addListener(updateButtonActive);
    _usernameController.addListener(updateButtonActive);
    _phoneNumberController.addListener(updateButtonActive);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void updateButtonActive() {
    final isButtonActive = _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty;

    setState(
      () {
        this.isButtonActive = isButtonActive;
      },
    );
  }

  Future userDetails() async {
    await _firebaseauth.createUserWithEmailAndPassword(
        email: _email, password: _password);

    final docUser =
        _firestore.collection('user-data').doc(_firebaseauth.currentUser!.uid);

    final user = u.User(
        id: docUser.id,
        firstName: _firstName,
        lastName: _lastName,
        username: _username,
        phoneNumber: _phoneNumber,
        email: _email);

    final json = user.toJson();
    await docUser.set(json);
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
        context,
        CustomPageRouteBuilder(
            child: const PageNavigator(),
            transitionType: SharedAxisTransitionType.scaled),
        (context) => false);
  }

  Color? cursorColor() {
    return MediaQuery.of(context).platformBrightness == Brightness.light
        ? Colors.lime[900]
        : Colors.yellow[500];
  }

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData(
          fontFamily: 'Inter',
          brightness: MediaQuery.of(context).platformBrightness,
          colorSchemeSeed: Colors.yellow,
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
                    children: <Widget>[
                      //Create Profile Text
                      const Text(
                        'Create Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30.0,
                        ),
                      ),

                      //First Name
                      CustomContainerTextField(
                        cursorColor: cursorColor(),
                        validator: Validator.firstName,
                        controller: _firstNameController,
                        onChanged: (value) {
                          _firstName = value;
                        },
                        padding: const EdgeInsets.only(
                            top: 40.0, left: 20.0, right: 20.0),
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[ a-zA-Z]'),
                          ),
                        ],
                        textInputAction: TextInputAction.next,
                        labelText: 'First Name',
                      ),

                      //Last Name
                      CustomContainerTextField(
                        cursorColor: cursorColor(),
                        validator: Validator.lastName,
                        controller: _lastNameController,
                        onChanged: (value) {
                          _lastName = value;
                        },
                        textCapitalization: TextCapitalization.words,
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 20.0, right: 20.0),
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[ a-zA-Z]'),
                          ),
                        ],
                        textInputAction: TextInputAction.next,
                        labelText: 'Last Name',
                      ),

                      //Username
                      CustomContainerTextField(
                        cursorColor: cursorColor(),
                        controller: _usernameController,
                        onChanged: (value) {
                          _username = value;
                        },
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 20.0, right: 20.0),
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-z0-9_.]')),
                        ],
                        textInputAction: TextInputAction.next,
                        labelText: 'Username',
                      ),

                      //Phone Number
                      CustomContainerTextField(
                        cursorColor: cursorColor(),
                        controller: _phoneNumberController,
                        onChanged: (value) {
                          _phoneNumber = value;
                        },
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 20.0, right: 20.0),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[0-9]'),
                          ),
                        ],
                        textInputAction: TextInputAction.done,
                        labelText: 'Phone',
                      ),

                      //Continue Button
                      CustomFilledButton(
                        colorSchemeSeed: Colors.yellow,
                        onPressed: isButtonActive
                            ? () {
                                userDetails();

                                setState(
                                  () {
                                    isButtonActive;
                                  },
                                );
                              }
                            : null,
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.0),
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
