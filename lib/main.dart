import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twitterclone/data/post_data.dart';
import 'package:twitterclone/firebase_options.dart';
import 'package:twitterclone/page_navigator.dart';
import 'package:twitterclone/routes.dart';
import 'package:twitterclone/screens/welcome/welcome_page.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final pages = appPages; //(routes.dart)
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => PostDataProvider())],
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'Inter',
            brightness: Brightness.light,
            colorSchemeSeed: Colors.blue,
            useMaterial3: true),
        darkTheme: ThemeData(
            fontFamily: 'Inter',
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.blue,
            useMaterial3: true),
        routes: appRoutes,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const PageNavigator();
            } else {
              return const WelcomePage();
            }
          },
        ),
      ),
    );
  }
}