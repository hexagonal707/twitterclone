import 'package:flutter/material.dart';
import 'package:twitterclone/screens/home/home_page.dart';
import 'package:twitterclone/screens/account/account_page.dart';

class PageNavigator extends StatefulWidget {
  static const String id = 'page_navigator';

  const PageNavigator({super.key});

  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  late int _currentPageIndex = 0;

  Widget pages(int index) {
    final routes = [
      HomePage(onPageSelected: _onPageChanged),
      const AccountPage()
    ];
    return routes[index];
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide),
        child: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              label: 'Account',
              selectedIcon: Icon(Icons.person_rounded),
            ),
          ],
          selectedIndex: _currentPageIndex,
          onDestinationSelected: (int index) {
            setState(
              () {
                _currentPageIndex = index;
              },
            );
          },
        ),
      ),
      body: SafeArea(child: pages(_currentPageIndex)),
    );
  }
}
