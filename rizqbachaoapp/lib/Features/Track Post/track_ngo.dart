import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rizqbachaoapp/Features/Track%20Post/track_ngo_provider.dart';
import 'package:provider/provider.dart';

import '../../Data/JSON/post_json.dart';


class TrackNgo extends StatefulWidget {
  const TrackNgo({Key? key}) : super(key: key);

  @override
  State<TrackNgo> createState() => _TrackNgoState();
}

class _TrackNgoState extends State<TrackNgo> {

  List<PostJson> posts = [];
  final user = FirebaseAuth.instance.currentUser!;
  bool value = false;

  @override
  void initState() {
    super.initState();
    print(user.uid.toString());
    context.read<TrackNgoProvider>().fetchPosts(user.uid.toString());
    posts = context.read<TrackNgoProvider>().posts;
    print('Length:');
    print(context.read<TrackNgoProvider>().posts.length);
    //loadData();
  }

  void refresh(){
    print(user.uid.toString());
    context.read<TrackNgoProvider>().fetchPosts(user.uid.toString());
    posts = context.read<TrackNgoProvider>().posts;
    print('Length:');
    print(context.read<TrackNgoProvider>().posts.length);
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
          'Track',
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
                        padding:EdgeInsets.fromLTRB(0, 10, 0, 20),
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
                      trailing: FittedBox(

                        fit: BoxFit.fill,
                        child: Column(
                          children: <Widget>[
                            ElevatedButton.icon(
                              onPressed: () async {
                                Clipboard.setData(ClipboardData(text: posts[index].number));
                                value = await alertBox();
                                // Code here
                              },
                              icon: Icon(Icons.phone),  //icon data for elevated button
                              label: Text("Contact", style: TextStyle(fontSize: 30)), //label text
                              style: ElevatedButton.styleFrom(

                                primary: Color(0xFF004803),//elevated btton background color
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                context.read<TrackNgoProvider>().updatePost(posts[index].pid);
                                // Code here
                              },
                              icon: Icon(Icons.check_circle),  //icon data for elevated button
                              label:  Text("Done", style: TextStyle(fontSize: 30)), //
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF004803),//elevated btton background color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          refresh();
          setState(() {});
        },
        backgroundColor: Color(0xFFFF9BC60),
        child: Icon(Icons.refresh)
      ) ,
    );
  }
  Future alertBox() async {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Phone Number has been copied to clipboard!'),
          );
        });
  }
}