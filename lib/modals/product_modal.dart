import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModal {
  static const ID = "id";
  static const NAME = "name";
  static const PICTURE = "productimage";
  static const NEWPRICE = "newprice";
  static const OLDPRICE = "oldprice";
  static const DESCRIPTION = "description";
  static const IMAGESLIDER = "imageslider";

  String _name;
  String _picture;
  dynamic _newprice;
  dynamic _oldprice;
  String _description;
  List _imageslider;
  String _id;

  String get name => _name;
  String get picture => _picture;
  dynamic get newprice => _newprice;
  dynamic get oldprice => _oldprice;
  String get description => _description;
  List get imageslider => _imageslider;
  String get id => _id;

  ProductModal.fromSnapshot(DocumentSnapshot snapshot) {
    _description = snapshot.get(DESCRIPTION);
    _id = snapshot.get(ID);
    _newprice = snapshot.get(NEWPRICE);
    _name = snapshot.get(NAME);
    _picture = snapshot.get(PICTURE);
    _oldprice = snapshot.get(OLDPRICE);
    _imageslider = snapshot.get(IMAGESLIDER);
  }
}


