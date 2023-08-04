import 'package:twitterclone/page_navigator.dart';
import 'package:twitterclone/screens/createPost/create_post_page.dart';
import 'package:twitterclone/screens/createProfile/create_profile_page.dart';
import 'package:twitterclone/screens/home/home_page.dart';
import 'package:twitterclone/screens/login/login_page.dart';
import 'package:twitterclone/screens/resetPassword/reset_password_page.dart';
import 'package:twitterclone/screens/signUp/signup_page.dart';
import 'package:twitterclone/screens/welcome/welcome_page.dart';

var appPages = [
  const HomePage(),
  const LoginPage(),
  const PageNavigator(),
  const CreatePostPage(),
  const CreateProfilePage(savedEmail: '', savedPassword: ''),
  const SignUpPage(),
  const WelcomePage(),
  const ForgotPasswordPage(),
];

var appRoutes = {
  HomePage.id: (context) => const HomePage(),
  LoginPage.id: (context) => const LoginPage(),
  CreatePostPage.id: (context) => const CreatePostPage(),
  PageNavigator.id: (context) => const PageNavigator(),
  CreateProfilePage.id: (context) =>
      const CreateProfilePage(savedEmail: '', savedPassword: ''),
  SignUpPage.id: (context) => const SignUpPage(),
  WelcomePage.id: (context) => const WelcomePage(),
  ForgotPasswordPage.id: (context) => const ForgotPasswordPage(),
};
