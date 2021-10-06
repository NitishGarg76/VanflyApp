import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String email;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Colors.pinkAccent,
      ),
      key: _key,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[350],
              blurRadius: 20.0, // has the effect of softening the shadow
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 70, 10, 70),
          child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Text(
                    "Check Reset Link On your Email ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10,
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
                          title: TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                                hintText: "Email",
                                icon: Icon(Icons.alternate_email),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(140, 10, 140, 10),
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.pinkAccent,
                        elevation: 0.0,
                        child: MaterialButton(
                          onPressed: () {
                            _auth.sendPasswordResetEmail(email: email);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                                SnackBar(content: Text("Added to Cart!")));
                          },
                          child: Text(
                            "Send",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        )),
                  ),

//
                ],
              )),
        ),
      ),
    );
  }
}
