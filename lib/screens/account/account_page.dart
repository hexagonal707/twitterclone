import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/post_data.dart';
import '../../widgets/custom_card_header.dart';
import '../../widgets/custom_listview.dart';
import '../../widgets/custom_shimmer.dart';
import '../welcome/welcome_page.dart';

class AccountPage extends StatefulWidget {
  static const String id = 'account_page';

  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostDataProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const Text(
            'Account',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 36.0,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[

              const SizedBox(height: 16.0),
              //Profile Header
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 18.0),
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  onTap: () {
                    /*provider.userData != null
                        ? Navigator.push(
                      context,
                      CustomPageRouteBuilder(
                          child: const ProfilePage(),
                          transitionType:
                          SharedAxisTransitionType.horizontal),
                    )
                        : null;*/
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 16.0),
                      child: provider.userData != null

                          //Profile Row
                          ? CustomCardHeader(
                              primaryHeading:
                                  '${provider.userData!.firstName} ${provider.userData!.lastName}',
                              primaryHeadingFontSize: 20.0,
                              primaryHeadingFontWeight: FontWeight.w600,
                              secondaryHeading: provider.userData!.phoneNumber,
                              secondaryHeadingFontSize: 14.0,
                              secondaryHeadingFontWeight: FontWeight.w500,
                              tertiaryHeading: provider.userData!.email,
                              tertiaryHeadingFontSize: 14.0,
                              tertiaryHeadingFontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                              arrow: true,
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).focusColor,
                                radius: 40.0,
                                child: const Icon(Icons.person_outlined),
                              ),
                            )

                          //Shimmer
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        showShimmer(
                                            context: context,
                                            topPadding: 6,
                                            bottomPadding: 6,
                                            height: 18.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45),
                                        showShimmer(
                                            context: context,
                                            topPadding: 3.0,
                                            bottomPadding: 3.0,
                                            height: 14.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25),
                                        showShimmer(
                                            context: context,
                                            topPadding: 3.0,
                                            bottomPadding: 3.0,
                                            height: 14.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5)
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                        radius: 40.0,
                                        backgroundColor:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Theme.of(context).focusColor
                                                : Theme.of(context).focusColor),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Icon(Icons.arrow_forward_ios_sharp,
                                          size: 20.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: <Widget>[
                    CustomListView(
                        icon: Icons.power_settings_new_rounded,
                        onTap: () async {
                          await FirebaseAuth.instance
                              .signOut()
                              .whenComplete(() {

                            Navigator.pushNamedAndRemoveUntil(
                                context, WelcomePage.id, (route) => false);
                          });
                        },
                        text: 'Log out'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
