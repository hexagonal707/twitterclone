import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:twitterclone/data/user_data.dart';
import 'package:twitterclone/models/user_model.dart' as u;

import '../models/post_model.dart';

class PostDataProvider extends ChangeNotifier {
  PostDataProvider() {
    getPostListFuture();
  }

  List<Post>? postDataList;
  u.User? userData;

  getPostListFuture() async {
    var postIds = await getPostIds();
    final userId = FirebaseAuth.instance.currentUser!.uid;

    userData = await UserData.getUserData(userId);
    var posts = await Future.wait(
      postIds.map(
        (postId) async => await getPostDataFuture(postId),
      ),
    );

    posts.sort((post1, post2) => post2.time.compareTo(post1.time));

    postDataList = posts;
    notifyListeners();
  }

  addPostList(String content, DateTime dateTime) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final postId = randomId();
    await FirebaseFirestore.instance
        .collection('user-data')
        .doc(userId)
        .collection('post-data')
        .doc(postId)
        .set(Post(
                postId: postId,
                userId: userId,
                content: content,
                time: dateTime)
            .toJson());
  }

  deletePostData(String postId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('user-data')
        .doc(userId)
        .collection('post-data')
        .doc(postId)
        .delete();

    // Updates list of post data ids
    List<Post> newPostData = [...?postDataList];
    newPostData.removeWhere((postData) => postData.postId == postId);

    postDataList = newPostData;
    notifyListeners();
  }

  static String randomId() {
    final docId = FirebaseFirestore.instance.collection('post-data').doc().id;
    return docId;
  }

  static Future<List<String>> getPostIds() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    List<String> docIds = [];

    await FirebaseFirestore.instance
        .collection('user-data')
        .doc(userId)
        .collection('post-data')
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        docIds.add(doc.reference.id);
      }
    });

    return docIds;
  }

  static Future<Post> getPostDataFuture(postId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    var snapshot = await FirebaseFirestore.instance
        .collection('user-data')
        .doc(userId)
        .collection('post-data')
        .doc(postId)
        .get();

    if (snapshot.exists && snapshot.data() != null) {
      var data = snapshot.data()!;
      return Post.fromJson(data);
    } else {
      throw Exception('Post data is not available');
    }
  }
}
