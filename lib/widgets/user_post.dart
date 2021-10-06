import 'package:flutter/material.dart';

class UserPosted extends StatelessWidget {
  final String profilePic;
  final String collegeEmail;
  final String aboutPost;
  final String post;
  final String likes;
  UserPosted(
      {this.post,
        this.aboutPost,
        this.collegeEmail,
        this.likes,
        this.profilePic});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.pink[100]),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.pink[100], offset: Offset(-2, -1), blurRadius: 5),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.pink[100]),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(profilePic),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        collegeEmail,
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                aboutPost,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                    height: 1.5,
                    letterSpacing: .7),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink[100]),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.pink[100],
                        offset: Offset(-2, -1),
                        blurRadius: 5),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(post), fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(children: [
                      Icon(Icons.favorite, size: 25, color: Colors.pinkAccent),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        likes,
                        style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Row(children: [
                        Icon(
                          Icons.share,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "share",
                        ),
                      ])),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
