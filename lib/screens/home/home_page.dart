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

  /*String currentDate(dynamic data) {
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
  }*/

  String currentDate(dynamic data) {
    var currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var docDate = DateTime(data.time.year, data.time.month, data.time.day);
    if (currentDate == docDate) {
      return DateFormat('hh:mm a').format(data.time);
    } else {
      return DateFormat('MMM d').format(docDate);
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<PostDataProvider>(context, listen: false).getPostListFuture();
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

        return RefreshIndicator(
          onRefresh: () async {
            await postDataProvider.getPostListFuture();
          },
          child: Scaffold(
            appBar: AppBar(
              bottom: const PreferredSize(
                preferredSize: Size(double.infinity, 1.0),
                child: Divider(
                  height: 1.0,
                  thickness: 3.0,
                ),
              ),
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              title: const Text(
                'Twitter Clone',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              shape: const StadiumBorder(),
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
            body: ListView.separated(
              padding: const EdgeInsets.only(
                  bottom: kFloatingActionButtonMargin + 50.0),
              itemCount: postDataList?.length ?? 15,
              separatorBuilder: (context, int index) {
                return const Divider(height: 1);
              },
              itemBuilder: (BuildContext context, int index) {
                if (postDataList != null && userData != null) {
                  return CustomPostContainer(
                    passedPostData: postDataList[index],
                    onTap: () {},
                    modalBottomSheetOnTap: () {},
                    name: '${userData.firstName} ${userData.lastName}',
                    content: postDataList[index].content,
                    time: currentDate(postDataList[index]),
                    username: userData.username,
                    selectedPostIndex: index,
                  );
                } else {
                  return const CustomPostContainerShimmer();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
