
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var referCode;

class CreateReferralCode extends StatefulWidget {
  final Widget Function(String referralCode) _builder;

  CreateReferralCode(this._builder);
  @override
  State<CreateReferralCode> createState() => _CreateReferralCodeState();
}

class _CreateReferralCodeState extends State<CreateReferralCode> {
  User user;
  final auth = FirebaseAuth.instance;
  String _referralCode;
  void setReferralCode() {
    if (mounted) {
      setState(() {
        var id = user.uid;
        referCode = 'Ref-${id.toUpperCase().substring(0, 8)}';
        _referralCode = referCode;
      });
    }
  }

  @override
  void initState() {
    user = auth.currentUser;
    setReferralCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(_referralCode);
  }
}
