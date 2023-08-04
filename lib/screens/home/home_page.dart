import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:twitterclone/models/post_model.dart';
import 'package:twitterclone/screens/createPost/create_post_page.dart';
import 'package:twitterclone/widgets/custom_container_textfield.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  final void Function(int)? onPageSelected;

  const HomePage({super.key, this.onPageSelected});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isButtonActive = true;
  late String _content;

  final _contentController = TextEditingController();

  void updateButtonActive() {
    final isButtonActive =
        _contentController.text.isNotEmpty;

    setState(
          () {
        this.isButtonActive = isButtonActive;
      },
    );
  }

  /*Future<Post> addPost() async{





}*/

  @override
  void initState() {
    super.initState();
    _contentController.addListener(updateButtonActive);
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              useSafeArea: true,
              isScrollControlled: true,
              enableDrag: true,
              context: context,
              builder: (context) {
                return CreatePostPage();
              },
            );
          },
        ),
        body: const SafeArea(
            child: Column(
          children: [],
        )),
      ),
    );
  }
}
