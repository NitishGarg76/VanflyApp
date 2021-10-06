import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vanfly/modals/cart_modal.dart';
import 'package:vanfly/providers/app_provider.dart';
import 'package:vanfly/providers/user_provider.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Cart'),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
                child: ListTile(
              title: Text(
                'Total:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Rs ${userProvider.userModel.totalCartPrice}',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            )),
            Expanded(
                child: MaterialButton(
              height: 50,
              onPressed: () {},
              color: Colors.pinkAccent,
              child: Text(
                'Check Out',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            )),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: userProvider.userModel.cart.length,
          itemBuilder: (context, index) {
            return SingleCartProduct(
              index: index,
              product: userProvider.userModel.cart[index],
            );
          }),
    );
  }
}

class SingleCartProduct extends StatelessWidget {
  final CartItemModel product;
  final index;
  SingleCartProduct({this.product, this.index});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 100,width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.pink[100],
                    offset: Offset(-2, -1),
                    blurRadius: 5),
              ]),
          child: ListTile(
            leading: Image.network(product.image),
            title: Text(
              product.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Rs:${product.price}'),
          ),
        ),
      ),
      Positioned(
        top: 60,
        left: 350,
        child: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () async {
              bool success = await userProvider.removeFromCart(
                  cartItem: userProvider.userModel.cart[index]);
              if (success) {
                userProvider.reloadUserModel();
                print("Item added to cart");

                return;
              } else {
                appProvider.changeIsLoading();
              }
            }),
      )
    ]);
  }
}
