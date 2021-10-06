import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vanfly/common.dart';
import 'package:vanfly/screens/login_screen/login.dart';
import 'package:vanfly/services/user_services.dart';

bool verified = false;

class VerifyScreen extends StatefulWidget {
  final String name;
  final String email;
  VerifyScreen({this.email, this.name});
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _key = GlobalKey<ScaffoldState>();
  UserServices _userServices = UserServices();

  final auth = FirebaseAuth.instance;


  User user;
  Timer timer;
  @override
  void initState() {

  user = auth.currentUser;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerification();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        key: _key,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Text(
              'An email has been sent to ${user.email} please verify',
              style: TextStyle(fontSize: 20),
            ),
          ),
        )));
  }

  Future checkEmailVerification() async {
    user = auth.currentUser;
    await user.reload();

    if (user.emailVerified) {
      _userServices.createUser({
        'name': widget.name,
        'email': widget.email,
        'uid': user.uid,
      });
      Navigator.pop(context);
    }
  }
}
