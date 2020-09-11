import 'package:flutter/material.dart';
import 'package:flutter_web_api/models/api_response.dart';
import 'package:flutter_web_api/models/order_for_listing.dart';
import 'package:flutter_web_api/services/order_service.dart';
import 'package:flutter_web_api/views/order_modify.dart';
import 'package:get_it/get_it.dart';

import 'order_delete.dart';

class OrderList extends StatefulWidget {

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
 OrderService get service => GetIt.instance<OrderService>();

 APIResponse<List<OrderForListing>> _apiResponse;
 bool _isLoading = false;
 @override
  void initState() {
   _fetchOrders();
    super.initState();
  }

  _fetchOrders() async {
   setState((){
     _isLoading = true;
   });

   print('fetching Orders .....*************************');

   _apiResponse = await service.getOrdersList();

   setState((){
     _isLoading = false;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Orders'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => OrderModify()))
              .then((_) => _fetchOrders());
        },
        child: Icon(Icons.add),
      ),
      body: Builder(builder: (_){
        if(_isLoading){
          return Center(child: CircularProgressIndicator());
        }
        if( _apiResponse.error){
          return Center(child: Text(_apiResponse.errorMessage));
        }
        return ListView.separated(
              separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey),
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(_apiResponse.data[index].id.toString()),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction){
                  },
                  confirmDismiss: (direction) async {
                    final result  = await showDialog(
                        context: context,
                        builder: (_) => OrderDelete());
                    return result;
                  },
                  background: Container(
                    color: Colors.redAccent,
                    child: Icon(Icons.delete, color: Colors.white,),alignment: Alignment.centerLeft,
                  ),
                  child: ListTile(
                    title: Text(
                      _apiResponse.data[index].name,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    subtitle: Text('Rs. ' + _apiResponse.data[index].price.toString()),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder : (_) => OrderModify(orderId: _apiResponse.data[index].id.toString())));
                    },
                  ),
                );

              },
              itemCount: _apiResponse.data.length
          );

      })
    );
  }
}
