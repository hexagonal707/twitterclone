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
    final uid = FirebaseAuth.instance.currentUser!.uid;

    userData = await UserData.getUserData(uid);
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
    await FirebaseFirestore.instance.collection('post-data').doc(postId).set(
        Post(postId: postId, userId: userId, content: content, time: dateTime)
            .toJson());
  }

  deleteSalesData(String postId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    var thing = await FirebaseFirestore.instance
        .collection('post-data')
        .where('id', isEqualTo: postId)
        .limit(1)
        .get();
    var some = await FirebaseFirestore.instance
        .collection('post-data')
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();

    if (thing.docs.isEmpty && some.docs.isEmpty) {
      print('delete failed');
    } else {
      await FirebaseFirestore.instance
          .collection('post-data')
          .doc(postId)
          .delete();
    }

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
    List<String> docIds = [];

    await FirebaseFirestore.instance
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
    var snapshot = await FirebaseFirestore.instance
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

  static Future<void> addPost(String post) async {
    final docId = FirebaseFirestore.instance.collection('post-data').doc().id;
    try {
      await FirebaseFirestore.instance.collection('post-data').add(
          Post(userId: docId, content: post, time: DateTime.now()).toJson());
    } catch (e) {
      throw Exception('Failed to add post: $e');
    }
  }
}
