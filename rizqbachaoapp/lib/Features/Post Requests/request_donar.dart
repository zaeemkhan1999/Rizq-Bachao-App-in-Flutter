import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rizqbachaoapp/Features/Post%20Requests/request_donar_provider.dart';
import 'package:provider/provider.dart';

import '../../Data/JSON/post_json.dart';

class RequestDonar extends StatefulWidget {
  const RequestDonar({Key? key}) : super(key: key);

  @override
  State<RequestDonar> createState() => _RequestDonarState();
}

class _RequestDonarState extends State<RequestDonar> {
  final user = FirebaseAuth.instance.currentUser!;

  List<PostJson> posts = [];

  @override
  void initState() {
    super.initState();
    context.read<PostRequestsProvider>().fetchPosts();
    posts = context.read<PostRequestsProvider>().posts;
    print('Length:');
    print(context.read<PostRequestsProvider>().posts.length);
  }

  void refresh() {
    context.read<PostRequestsProvider>().fetchPosts();
    posts = context.read<PostRequestsProvider>().posts;
    print('Length:');
    print(context.read<PostRequestsProvider>().posts.length);
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
          'Your Posts',
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
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                            ]),
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
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(
                                Icons.refresh), //icon data for elevated button
                            label: Text("Processing"), //label text
                            style: ElevatedButton.styleFrom(
                              primary: Color(
                                  0xFF004803), //elevated btton background color
                            ),
                          ),
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
          refresh();
          setState(() {});
        },
        backgroundColor: Color(0xFFFF9BC60),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
