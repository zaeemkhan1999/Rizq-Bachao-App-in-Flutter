import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../Data/JSON/post_json.dart';
import 'history_screen_provider.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  List<PostJson> posts = [];
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();

    print(user.uid.toString());
    context.read<HistoryScreenProvider>().fetchPosts(user.uid.toString());
    posts = context.read<HistoryScreenProvider>().posts;
    print('Length:');
    print(context.read<HistoryScreenProvider>().posts.length);
    //loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF004643),
        centerTitle: true,
        elevation: 4,
        title: Text(
          'History',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xFF004643),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10,
                    shadowColor: Color(0xFF004643),
                    child: ListTile(

                      title: Padding(
                        padding:EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(posts[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF004643),
                                    fontSize: 20.0,
                                  )),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(posts[index].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF004643),
                                  )),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(posts[index].quantity,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF004643),
                                  )),
                            ]
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(posts[index].description,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF5A7A79),
                            )),
                      ),
                      trailing: Wrap(
                        spacing: 12, // space between two icons
                        children: <Widget>[
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
          });
        },
        backgroundColor: Color(0xFFFF9BC60),
        child: Icon(Icons.refresh)
      ) ,
    );
  }
}
// Column(
//   children: [
//     Padding(
//       padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           side: BorderSide(
//             color: Color(0xFF004643),
//           ),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         elevation: 10,
//         shadowColor: Color(0xFF004643),
//         child: ListTile(
//
//
//           title: const Text("JDC",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF004643),
//               )),
//           trailing: Wrap(
//             spacing: 12, // space between two icons
//             children: <Widget>[
//               ElevatedButton.icon(
//                 onPressed: (){
//                 },
//                 icon: Icon(Icons.add),  //icon data for elevated button
//                 label: Text("Accept"), //label text
//                 style: ElevatedButton.styleFrom(
//                     primary: Colors.green//elevated btton background color
//                 ),
//               ),
//               ElevatedButton.icon(
//                 onPressed: (){
//                 },
//                 icon: Icon(Icons.subscript_sharp),  //icon data for elevated button
//                 label: Text("Reject"), //label text
//                 style: ElevatedButton.styleFrom(
//                     primary: Colors.red//elevated btton background color
//                 ),
//               ),// icon-2
//             ],
//           ),
//         ),
//       ),
//     )
//   ],
//
// ),
