import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModal {
  static const CARDLABEL = "cardlabel";
  static const URL = "url";
  static const VIDEONAME='videoname';

  String _cardlabel;
  String _url;
  String _videoname;


  String get cardlabel => _cardlabel;
  String get url => _url;
  String get videoname => _videoname;


  TaskModal.fromSnapshot(DocumentSnapshot snapshot) {
    _cardlabel = snapshot.get(CARDLABEL);
    _url = snapshot.get(URL);
    _videoname=snapshot.get(VIDEONAME);
      }
}


