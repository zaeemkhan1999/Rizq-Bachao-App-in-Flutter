import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rizqbachaoapp/Domain/post_repository.dart';

class FirebasePostRepository implements PostRepository {
  final db = FirebaseFirestore.instance;

  addPosts(String title, String description, String quantity, String uid,
      double lat, double long, String name, String number) {
    //notifyListeners();
    db.collection("posts").add({
      "title": title,
      "description": description,
      "quantity": quantity,
      "uid": uid,
      "accepted": 0,
      "nid": "undefined",
      "lat": lat,
      "long": long,
      "name": name,
      "number": number,
      "nname": "undefined",
      "nnumber": "undefined",
    }).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}
