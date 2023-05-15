import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Data/JSON/post_json.dart';
import '../../Domain/post_repository.dart';

class TrackDonarProvider with ChangeNotifier {

  final db = FirebaseFirestore.instance;
  List<PostJson> posts = [];

  void getPosts() async {

    notifyListeners();
  }
  void fetchPosts(String uid) async{

    await db.collection("posts").where('accepted', isEqualTo: 1).where('uid', isEqualTo: uid).get().then((e) {
      posts = e.docs.map((e) => PostJson.fromJson(e.data() as Map<String, dynamic> , e.id))
          .toList();
    });

    notifyListeners();
  }
}