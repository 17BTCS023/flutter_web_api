import 'package:flutter/material.dart';

class OrderModify extends StatelessWidget {

  final String orderId;
  OrderModify({this.orderId});
  bool get isEditing => orderId !=null;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text(isEditing ?'Edit Order' : 'Create Order'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
              hintText: 'Product Name'),
            ),
            SizedBox(height: 8.0,),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Price'),
            ),
            SizedBox(height: 8.0,),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Product id'),
            ),
            SizedBox(height: 16.0,),
            RaisedButton(
              onPressed: (){
                if(isEditing){
                  // update note in API
                }else{
                  // create note in API
                }
                Navigator.of(context).pop();
              },
              child: Text('Submit', style: TextStyle(color: Colors.white)),
              color : Theme.of(context).primaryColor
            ),
          ],
        ),
      ),
    );
  }
}
