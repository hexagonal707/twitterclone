import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitterclone/data/post_data.dart';

class CreatePostPage extends StatefulWidget {
  static const String id = 'create_post_page';

  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _contentController = TextEditingController();
  bool _isButtonActive = true;

  void updateButtonActive() {
    final isButtonActive = _contentController.text.isNotEmpty;

    setState(
      () {
        _isButtonActive = isButtonActive;
      },
    );
  }


  addPostData(String content, DateTime time) async {
    var provider = Provider.of<PostDataProvider>(context, listen: false);
    await provider.addPostList(content, time);
    provider.getPostList();
  }


  @override
  void initState() {
    super.initState();
    updateButtonActive();
    _contentController.addListener(updateButtonActive);
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Consumer<PostDataProvider>(
        builder: (BuildContext context, PostDataProvider postDataProvider,
            Widget? child) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CloseButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: FilledButton(
                      onPressed: _isButtonActive
                          ? (){
                              setState(() {
                                _isButtonActive;
                              });
                              addPostData(_contentController.value.text, DateTime.now());
                              Navigator.pop(context);
                            }
                          : null,
                      child: const Text('Post'),
                    ),
                  )
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 26.0, vertical: 18.0),
                        child: TextFormField(
                          controller: _contentController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          decoration: const InputDecoration(
                            hintText: "What's on your mind?",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20.0),
                          ),
                        ),
                      ), //Reset Password Button
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}
