import 'package:flutter/material.dart';
import 'order.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key, required this.orders}) : super(key: key);
  final List<Order> orders;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: SafeArea(
        child: Center(
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(orders[index].toString()),
              );
            },
          ),
        ),
      ),
    );
  }

}