import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vanfly/modals/cart_modal.dart';
import 'package:vanfly/modals/user_modal.dart';

class UserServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "users";

 createUser(Map<String,dynamic> data) async {
     _firestore.collection(collection).doc(data["uid"]).set(data);
  }

  Future<UserModel> getUserById(String id) async =>
      await _firestore.collection(collection).doc(id).get().then((doc) {
        if (doc.exists) { // 👈 check if the document exists
          return UserModel.fromDocument(doc);
        }
        else {
          return null; // 👈 return something that your calling code can handle
        }
      });

  void addToCart({String userId, CartItemModel cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart({String userId, CartItemModel cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }

  }
