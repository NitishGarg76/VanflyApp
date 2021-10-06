import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vanfly/providers/user_provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final user = Provider.of<UserProvider>(context);
    return ListView(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink[100]),
                  color: Colors.white ,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.pink[100],
                        offset: Offset(-2, -1),
                        blurRadius: 5),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    image: AssetImage('images/profile_page_pic/cover_pic.jpg'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150, left: 150, right: 150),
              child: CircleAvatar(
                backgroundColor: Colors.pink[300],
                radius: 60,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 55,
                  child: Image(
                      image: AssetImage(
                          'images/profile_page_pic/profile_pic.png')),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(
              user.userModel?.name ?? "username lading...",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              user.userModel?.email ?? "email loading...",
            ),
          ]),
        ),
        Divider(
          endIndent: 20,
          indent: 20,
          color: Colors.pink[100],
          thickness: 0.7,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'V-Coins',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink[100]),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.pink[100],
                        offset: Offset(-2, -1),
                        blurRadius: 2),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '0',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('Earned'),
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink[100]),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.pink[100],
                        offset: Offset(-2, -1),
                        blurRadius: 2),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '0',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('Spent'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          endIndent: 20,
          indent: 20,
          color: Colors.pink[100],
          thickness: 0.7,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Invited by you',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 10.0, right: 10, top: 5, bottom: 5),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.pink[100]),
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.pink[100],
                      offset: Offset(-2, -1),
                      blurRadius: 5),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Rajat (500)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '01 july,2017',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 10.0, right: 10, top: 5, bottom: 5),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.pink[100]),
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.pink[100],
                      offset: Offset(-2, -1),
                      blurRadius: 5),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Himanshu (800)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '02 july,2017',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
