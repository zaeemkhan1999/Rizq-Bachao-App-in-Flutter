class PostJson {
  final String pid;
  final String uid;
  final String nid;
  final String title;
  final String description;
  final String quantity;
  final int accepted;
  final double  lat;
  final double long;
  final String name;
  final String number;
  final String nname;
  final String nnumber;

  PostJson({
    required this.pid,
    required this.uid,
    required this.nid,
    required this.title,
    required this.description,
    required this.quantity,
    required this.lat,
    required this.long,
    required this.accepted,
    required this.name,
    required this.number,
    required this.nname,
    required this.nnumber,

  });

  static PostJson fromJson(Map<String, dynamic> json, String id) =>

      PostJson(
        pid: id,
        uid: json['uid'],
        nid: json['nid'],
        title: json['title'],
        description: json['description'],
        quantity: json['quantity'],
        lat: json['lat'],
        long: json['long'],
        accepted: json['accepted'],
        number: json['number'],
        name: json['name'],
        nnumber: json['nnumber'],
        nname: json['nname'],
      );
  }

//   Map<String, dynamic> toJson() {
//
//     return {
//       'id':id,
//       'title': title,
//       'description': description,
//       // 'images': images,
//       'quantity': quantity,
//       //'category': category,
//       'status':status,
//     };
//   }
//
// }