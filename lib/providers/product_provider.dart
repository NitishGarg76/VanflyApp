import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vanfly/modals/product_modal.dart';
import 'package:vanfly/modals/task_modal.dart';
import 'package:vanfly/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  ProductServices _productServices = ProductServices();
  List<ProductModal> mobiles = [];
  List<ProductModal> pcANDLaptop = [];
  List<ProductModal> bedSheets = [];
  List<ProductModal> doorMats = [];
  List<ProductModal> productsSearched = [];
  List<ProductModal> kurti = [];
  List<ProductModal> more = [];
Map<String,dynamic> postList= {};
  List<ProductModal> offers = [];
  List<TaskModal> whatsAppTasks = [];
  List<TaskModal> instagramTasks = [];


  ProductProvider.initialize() {
    loadProducts();
    loadTasks();
  }

  loadProducts() async {
    mobiles = await _productServices.getItems(
        docId: 'mobiles', subCollection: 'mobiles');
    // bedSheets = await _productServices.getItems(
    //     docId: '01New', subCollection: 'bedsheets');
    pcANDLaptop = await _productServices.getItems(
        docId: 'computers', subCollection: 'computers');
    // products = await _productServices.getProducts('products');
    // pcANDLaptop = await _productServices.getProducts('computers');
    bedSheets = await _productServices.getItems(
        docId: 'bedsheets', subCollection: 'bedsheets');
    doorMats = await _productServices.getItems(
        docId: 'doormats', subCollection: 'doormats');

    kurti = await _productServices.getItems(
        docId: 'doormats', subCollection: 'doormats');
    more = await _productServices.getItems(
        docId: 'doormats', subCollection: 'doormats');
    offers = await _productServices.getOffers('offers');
    notifyListeners();
  }

  loadTasks() async {
    whatsAppTasks = await _productServices.getTasks('whatsapptask');
    instagramTasks = await _productServices.getTasks('instagramtask');
    notifyListeners();
  }



  Future searchProducts({String productName}) async {
    productsSearched = await _productServices.searchProducts(
        collection: 'computers',
        docName: 'computers',
        productName: productName);
    productsSearched = await _productServices.searchProducts(
        docName: 'bedsheets',
        productName: productName,
        collection: 'bedsheets');
    productsSearched = await _productServices.searchProducts(
        docName: 'doormats', productName: productName, collection: 'doormats');
    productsSearched = await _productServices.searchProducts(
        docName: 'mobiles', productName: productName, collection: 'mobiles');

    notifyListeners();
  }
  // Future searchPost({String postName}) async {
  //  postList = await _productServices.searchPosts(
  //       postName: postName);
  //
  //   notifyListeners();
  // }
}
