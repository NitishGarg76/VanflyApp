import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vanfly/modals/product_modal.dart';
import 'package:vanfly/modals/task_modal.dart';

class ProductServices {
  List<ProductModal> searchingProducts = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModal>> getOffers(String collection) async =>
      await _firestore.collection(collection).get().then((result) {
        List<ProductModal> offers = [];
        for (DocumentSnapshot product in result.docs) {
          offers.add(ProductModal.fromSnapshot(product));
        }
        return offers;
      });


  Future<List<ProductModal>> getItems(
          {String docId, String subCollection}) async =>
      await _firestore
          .collection('products')
          .doc(docId)
          .collection(subCollection)
          .get()
          .then((result) {
        List<ProductModal> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModal.fromSnapshot(product));
        }
        return products;
      });

  Future<List<TaskModal>> getTasks(String collection) async =>
      _firestore.collection(collection).get().then((result) {
        List<TaskModal> tasks = [];
        for (DocumentSnapshot product in result.docs) {
          tasks.add(TaskModal.fromSnapshot(product));
        }
        return tasks;
      });

  Future<List<ProductModal>> searchProducts(
      {String docName, String productName, String collection}) {
    // code to convert the first character to uppercase
    // String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection('products')
        .doc(docName)
        .collection(collection)
        .where('name', isGreaterThanOrEqualTo: productName)
        .where('name', isLessThan: productName + 'z')
        .get()
        .then((result) {
      for (DocumentSnapshot product in result.docs) {
        searchingProducts.add(ProductModal.fromSnapshot(product));
      }
      return searchingProducts;
    });
  }


  // Future<Map<String,dynamic>> searchPosts({String postName}) {
  //   // code to convert the first character to uppercase
  //   Map<String,dynamic> posts ;
  //   String searchKey = postName[0].toUpperCase() + postName.substring(1);
  //   return _firestore
  //       .collectionGroup('contest')
  //       .startAt([searchKey])
  //       .endAt([searchKey + '\uf8ff'])
  //       .get()
  //       .then((result) {
  //
  //
  //    return posts=result.docs[0].data();
  //   });
  // }
}

