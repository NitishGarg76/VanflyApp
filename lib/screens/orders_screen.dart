
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vanfly/modals/order_modal.dart';
import 'package:vanfly/providers/user_provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.pinkAccent,

        title: Text("Orders",),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: userProvider.orders.length,
          itemBuilder: (_, index){
            OrderModel _order = userProvider.orders[index];
            return ListTile(
              leading: Text("Rs${_order.total}",
               style: TextStyle( fontWeight: FontWeight.bold,),
              ),
              title: Text(_order.description),
              subtitle: Text(DateTime.fromMillisecondsSinceEpoch(_order.createdAt).toString()),
              trailing: Text( _order.status, style:TextStyle(color: Colors.green)),
            );
          }),
    );
  }
}
