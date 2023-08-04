import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  static const String id = 'profile_page';
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Profile Page')],
      ),
    );
  }
}
