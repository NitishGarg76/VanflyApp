import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:vanfly/common.dart';
import 'package:vanfly/widgets/search_post.dart';
import 'package:vanfly/widgets/loading.dart';
import 'package:vanfly/widgets/user_post.dart';

Map<String, dynamic> postMap;

class Contest extends StatefulWidget {
  @override
  State<Contest> createState() => _ContestState();
}

class _ContestState extends State<Contest> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink[100]),
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.pinkAccent,
                  ),
                  title: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (pattern) async {
                      await FirebaseFirestore.instance
                          .collection('contest')
                          .where('collegeemail', isEqualTo: pattern)
                          .get()
                          .then((value) {
                        setState(() {
                          postMap = value.docs[0].data();
                        });
                        print(postMap);
                      });
                      changeScreen(context, SearchPostScreen());
                    },
                    decoration: InputDecoration(
                      hintText: "search...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: width / 1.8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.pink[100]),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.pink[100],
                      offset: Offset(-2, -1),
                      blurRadius: 5),
                ],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: Align(
                              alignment: Alignment.center,
                              child: Loading(),
                            )),
                            Center(
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxu6wGLJqMOAMT8j8fh2fjxSt3022MXvQ7Ow&usqp=CAU',
                                fit: BoxFit.cover,
                                height: width / 2.7,
                                width: width,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 3),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.pinkAccent,
                              child: MaterialButton(
                                onPressed: () {
                                  changeScreen(context, ContestRulesPage());
                                },
                                child: Text(
                                  'Enter',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          Center(
              child: Text(
            'Posts',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          Container(
            height: width,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('contest')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Loading();
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot contestData =
                              snapshot.data.docs[index];
                          return UserPosted(
                            post: contestData['post'],
                            profilePic: contestData['profilepic'],
                            aboutPost: contestData['aboutpost'],
                            collegeEmail: contestData['collegeemail'],
                            likes: contestData['likes'],
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class ContestRulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'About',
                style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.pink[100]),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.pink[100],
                      offset: Offset(-2, -1),
                      blurRadius: 5),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: Loading(),
                          )),
                          Center(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image:
                                  'https://i.pinimg.com/236x/9a/ff/3f/9aff3f4f8d916caa1d66a91431102ffa.jpg',
                              fit: BoxFit.cover,
                              height: width * 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.pinkAccent,
                        child: MaterialButton(
                          onPressed: () {
                            changeScreen(context, MakePostScreen());
                          },
                          child: Text(
                            'Join',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum VerifyInputs { usedEmail, unusedEmail }

class MakePostScreen extends StatefulWidget {
  @override
  State<MakePostScreen> createState() => _MakePostScreenState();
}

class _MakePostScreenState extends State<MakePostScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  TextEditingController _email = TextEditingController();
  TextEditingController _aboutPost = TextEditingController();
  File profile;
  File postFile;
  String profURL = '';
  String postURL = '';
  VerifyInputs emailUsed = VerifyInputs.unusedEmail;
  String emailVerification = 'Make Sure you verify the email before login';

  getPostImage() async {
    var postImg = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      postFile = File(postImg.path);
    });
  }

  getProfileImage() async {
    var profImg = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      profile = File(profImg.path);
    });
  }

  verifyEmail() async {
    try {
// if the size of value is greater then 0 then that doc exist.
      await FirebaseFirestore.instance
          .collection('contest')
          .where('collegeemail', isEqualTo: _email.text)
          .get()
          .then((value) {
        if (value.size > 0) {
          setState(() {
            emailUsed = VerifyInputs.usedEmail;
            emailVerification = 'Already in use,true';
          });
        } else {
          setState(() {
            emailUsed = VerifyInputs.unusedEmail;
            emailVerification = 'Good to go,false';
          });
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  uploadFile() async {

      var profileImageFile = FirebaseStorage.instance
          .ref()
          .child('profile')
          .child('${basename(profile.path)}/.jpg');
      var postImageFile = FirebaseStorage.instance
          .ref()
          .child('post')
          .child('${basename(postFile.path)}/.jpg');

      UploadTask profTask = profileImageFile.putFile(profile);

      UploadTask postTask = postImageFile.putFile(postFile);
      TaskSnapshot profSnapshot = await profTask;

      TaskSnapshot postSnapshot = await postTask;
      profURL = await profSnapshot.ref.getDownloadURL();

      postURL = await postSnapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('contest').doc().set({
        'aboutpost': _aboutPost.text,
        'collegeemail': _email.text,
        'likes': '0',
        'post': postURL,
        'profilepic': profURL
      });

      print(profURL);
      print(postURL);
    }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Text('Contest'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink[100]),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.pink[100],
                        offset: Offset(-2, -1),
                        blurRadius: 5),
                  ],
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Center(
                          child: Center(
                              child: InkWell(
                        onTap: getProfileImage,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ))),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink[100]),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: profile == null
                                  ? AssetImage(
                                      'images/vanfly Logo/vanfly_logo.png')
                                  : FileImage(File(profile.path))
                                      as ImageProvider,
                              fit: BoxFit.cover)),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Profile pic',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.withOpacity(0.2),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: ListTile(
                          title: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _email,
                            decoration: InputDecoration(
                                suffix: InkWell(
                                  onTap: () {
                                    verifyEmail();
                                    print(emailUsed);
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'verify',
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                    ),
                                  ),
                                ),
                                hintText: "Email",
                                icon: Icon(Icons.alternate_email),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    emailVerification,
                    style: TextStyle(color: Colors.red),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        controller: _aboutPost,
                        decoration: InputDecoration(
                            hintText: "What's on your mind?",
                            border: InputBorder.none)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.pink[100]),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.pink[100],
                                  offset: Offset(-2, -1),
                                  blurRadius: 5),
                            ],
                            image: DecorationImage(
                                image: postFile == null
                                    ? AssetImage(
                                        'images/vanfly Logo/vanfly_logo.png')
                                    : FileImage(File(postFile.path))
                                        as ImageProvider,
                                fit: BoxFit.cover)),
                        child: Center(
                            child: InkWell(
                          onTap: getPostImage,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ))),
                  )
                ]),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 150, bottom: 3, top: 10, left: 150),
                  child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.pinkAccent,
                      child: MaterialButton(
                        onPressed: () {
                        if(  postURL != null && profURL != null){
                               uploadFile();
                               changeScreen(context,Contest());
                             }else{print('something went wrong');}
                        },
                        child: Text(
                          'Post',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      )),
                ),
              ],
            ),
          ],
        ));
  }
}
