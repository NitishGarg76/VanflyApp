import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vanfly/modals/product_modal.dart';
import 'package:vanfly/screens/products_screen/details_page.dart';
import 'package:vanfly/widgets/loading.dart';

class ProductsPage extends StatefulWidget {
  final List productList;
  ProductsPage({this.productList});
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.productList.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(
            index: index,
            product: widget.productList[index],
          );
        });
  }
}

class SingleProduct extends StatelessWidget {
  final ProductModal product;
  final index;
  SingleProduct({this.product, this.index});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return IntrinsicHeight(
      child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProductDetails(
                index: index,
                products: product,
              );
            }));
          },
          child: Container(
            margin: EdgeInsets.all(
                8.0), // just to make the contianer stand out, you can remove it

            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.pink[100],
                      offset: Offset(-2, -1),
                      blurRadius: 5),
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Loading(),
                        ),
                      ),
                      Image.network(
                        product.picture,
                        fit: BoxFit.cover,
                        height: width * 0.25, // 25% of screen width
                        width: width * 0.25,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        product.name,
                        style: TextStyle(fontSize: 17),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Wrap(direction: Axis.vertical,
                              children: [
                            Text(
                              'Rs${product.newprice}',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Rs${product.oldprice}',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 17,
                                  color: Colors.blueGrey),
                            ),
                          ]))
                    ])),
              ],
            ),
          )),
    );
  }
}
