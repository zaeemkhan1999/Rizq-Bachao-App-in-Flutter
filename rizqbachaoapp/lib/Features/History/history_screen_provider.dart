import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rizqbachaoapp/Domain/org_respository.dart';
import '../../Data/JSON/post_json.dart';
import '../../Domain/post_entity.dart';

class HistoryScreenProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<PostJson> posts = [];

  void getPosts() async {
    notifyListeners();
  }

  void fetchPosts(String uid) async {
    await db
        .collection("posts")
        .where('accepted', isEqualTo: 2)
        .where('nid', isEqualTo: uid)
        .get()
        .then((e) {
      posts = e.docs
          .map((e) => PostJson.fromJson(e.data() as Map<String, dynamic>, e.id))
          .toList();
    });

    notifyListeners();
  }
}
