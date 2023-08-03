import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_page_route_builder.dart';
import '../../widgets/gradient_text.dart';
import '../login/login_page.dart';
import '../signUp/signup_page.dart';

class WelcomePage extends StatefulWidget {
  static const String id = 'welcome_page';

  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _State();
}

class _State extends State<WelcomePage> {
  List<Shadow> buildShadow(BuildContext context) {
    var list = <Shadow>[];
    var width = MediaQuery.of(context).size.width;
    for (var i = 0.0; i <= width; i += 0.1) {
      list.add(
        Shadow(
          offset: Offset(i, i),
          color: const Color.fromARGB(255, 24, 38, 62).withOpacity(0.01),
        ),
      );
    }

    return list;
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      body: Container(
        decoration: const BoxDecoration(),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GradientText(
                    'clone',
                    style: const TextStyle(
                        shadows: [
                          Shadow(
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                        fontWeight: FontWeight.w500,
                        fontSize: 110.0,
                        letterSpacing: 5.0,
                        fontFamily: 'Inter'),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: Theme.of(context).brightness == Brightness.light
                            ? <Color>[
                                const Color.fromARGB(255, 255, 255, 255),
                                const Color.fromARGB(255, 19, 124, 240),
                                const Color.fromARGB(255, 14, 14, 199),
                              ]
                            : <Color>[
                                const Color.fromARGB(255, 255, 255, 255),
                                const Color.fromARGB(255, 19, 124, 240),
                                const Color.fromARGB(255, 14, 14, 199),
                              ]),
                  ),

                  const SizedBox(
                    height: 70.0,
                  ),
                  //Log In Button
                  CustomElevatedButton(
                    colorSchemeSeed: Colors.lightBlueAccent,
                    onPressed: () {
                      Navigator.push(
                          context,
                          CustomPageRouteBuilder(
                              child: const LoginPage(),
                              transitionType:
                                  SharedAxisTransitionType.horizontal));
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
                    ),
                  ),
                  //Sign Up Button
                  CustomElevatedButton(
                    colorSchemeSeed: Colors.green,
                    onPressed: () {
                      Navigator.push(
                          context,
                          CustomPageRouteBuilder(
                              child: const SignUpPage(),
                              transitionType:
                                  SharedAxisTransitionType.horizontal));
                    },
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
