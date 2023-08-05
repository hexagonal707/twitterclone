import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserData {
  static Future<User> getUserData(String uid) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('user-data').doc(uid).get();
    if (snapshot.exists && snapshot.data() != null) {
      var data = snapshot.data()!;
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
