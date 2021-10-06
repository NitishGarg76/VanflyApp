import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vanfly/common.dart';
import 'package:vanfly/providers/product_provider.dart';
import 'package:vanfly/screens/BottomTab_Bar/task/contest.dart';
import 'package:vanfly/widgets/loading.dart';
import 'package:vanfly/widgets/user_post.dart';

class SearchPostScreen extends StatefulWidget {
  @override
  State<SearchPostScreen> createState() => _SearchPostScreenState();
}

class _SearchPostScreenState extends State<SearchPostScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Result",
          style: TextStyle(fontSize: 20),
        ),
        elevation: 0.0,
      ),
      body: postMap.isNotEmpty
          ? IntrinsicHeight(
              child: InkWell(
                  onTap: () {
                    changeScreen(context, OnSearchPost());
                  },
                  child: Container(
                    margin: EdgeInsets.all(
                        8.0), // just to make the contianer stand out, you can remove it

                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.pink[100],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Loading(),
                                ),
                              ),
                              Image.network(
                                postMap['profilepic'],
                                fit: BoxFit.cover,
                                height: width * 0.2, // 25% of screen width
                                width: width * 0.25,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              postMap['collegeemail'],
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            )
          // Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: InkWell(
          //           onTap: () {
          //             changeScreen(context, OnSearchPost());
          //           },
          //           child: Container(
          //             decoration: BoxDecoration(
          //               border: Border.all(color: Colors.pink[100]),
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(20),
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: Colors.pink[100],
          //                     offset: Offset(-2, -1),
          //                     blurRadius: 5),
          //               ],
          //             ),
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: ListTile(
          //                 title: Text(postMap['collegeemail']),
          //                 leading: Container(
          //                   width: 50,
          //                   height: 50,
          //                   decoration: BoxDecoration(
          //                       border: Border.all(color: Colors.pink[100]),
          //                       shape: BoxShape.circle,
          //                       image: DecorationImage(
          //                           image: NetworkImage(postMap['profilepic']),
          //                           fit: BoxFit.cover)),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "No products Found",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 22),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}

class OnSearchPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Text('Result'),
        ),
        body: Container(
          height: 400,
          child: UserPosted(
            profilePic: postMap['profilepic'],
            post: postMap['post'],
            aboutPost: postMap['aboutpost'],
            collegeEmail: postMap['collegeemail'],
            likes: postMap['likes'],
          ),
        ));
  }
}
