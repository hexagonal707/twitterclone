import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitterclone/data/post_data.dart';
import 'package:twitterclone/screens/createPost/create_post_page.dart';
import 'package:twitterclone/widgets/custom_post_container.dart';
import 'package:twitterclone/widgets/custom_post_container_shimmer.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  final void Function(int)? onPageSelected;

  const HomePage({super.key, this.onPageSelected});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isButtonActive = true;

  final _contentController = TextEditingController();

  void updateButtonActive() {
    final isButtonActive = _contentController.text.isNotEmpty;

    setState(
      () {
        this.isButtonActive = isButtonActive;
      },
    );
  }

  String currentDate(dynamic data) {
    var currentTime = DateTime.now();
    var docTime = data.time;
    var difference = currentTime.difference(docTime);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      var docDate = DateTime(docTime.year, docTime.month, docTime.day);
      return DateFormat('MMM d').format(docDate);
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<PostDataProvider>(context, listen: false).getPostList();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostDataProvider>(
      builder: (BuildContext context, PostDataProvider postDataProvider,
          Widget? child) {
        var postDataList = postDataProvider.postDataList;
        var userData = postDataProvider.userData;

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                enableDrag: true,
                context: context,
                builder: (context) {
                  return const CreatePostPage();
                },
              );
            },
          ),
          body: ListView.builder(
                  itemCount: postDataList?.length ?? 15,
                  itemBuilder: (BuildContext context, int index) {
                    if (postDataList != null && userData != null) {
                      return CustomPostContainer(
                        name: '${userData.firstName} ${userData.lastName}',
                        content: postDataList[index].content, time: currentDate(postDataList[index]), username: userData.username,
                      );
                    } else {
                      return const CustomPostContainerShimmer();
                    }
                  },
                ),
        );
      },
    );
  }
}
