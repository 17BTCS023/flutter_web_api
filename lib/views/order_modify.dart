import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter_web_api/models/single_order.dart';
import 'package:flutter_web_api/services/order_service.dart';
import 'package:get_it/get_it.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;


class OrderModify extends StatefulWidget {
  final String orderId;

  OrderModify({this.orderId});

  @override
  _OrderModifyState createState() => _OrderModifyState();
}

class _OrderModifyState extends State<OrderModify> {
  int _id;
  String _name;
  double _price;
  String _description;
  File _image;
  String _url;
  int _views;
  int _total_order;
  int _total_revenue;
  String _status;

  ProgressDialog pr;

  var _statusOptions = ['ACTIVE', 'INACTIVE'];
  var _currentStatusSelected = 'ACTIVE';
  var _selectedValue = 'ACTIVE';

  final  _formKey = GlobalKey<FormState>();

  bool get isEditing => widget.orderId != null;

  OrderService get orderService =>
      GetIt.I<
          OrderService>(); // to use http and other services from OrderService file
  SingleOrder order;
  String errorMessage;
  bool _isLoading = false;

  Uri addressUri = Uri.parse('https://l5vqpgr2pd.execute-api.us-west-2.amazonaws.com/dev/api/v1/product/');


  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _viewsController = TextEditingController();
  TextEditingController _total_orderController = TextEditingController();
  TextEditingController _total_revenueController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _imageController = TextEditingController();


  @override
  void initState() {
    setState(() {
      if (isEditing) {
        _isLoading = true;
      }
    });
    if (isEditing) {
      // Only if the user is editing an existing node
      orderService.getOrder(int.parse(widget.orderId)).then((response) {
        setState(() {
          _isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        order = response.data;
        _idController.text = order.id.toString();
        _nameController.text = order.name;
        _priceController.text = order.price.toString();
        _descriptionController.text = order.description;
        _urlController.text = order.url;
        _viewsController.text = order.views.toString();
        _total_orderController.text = order.total_order.toString();
        _total_revenueController.text = order.total_revenue.toString();
        _statusController.text = order.status;
        _imageController.text = order.image;

      });
    }
    super.initState();
  }

  Widget _buildIdField() {
    return TextFormField(
        controller: _idController,
        decoration: InputDecoration(labelText: 'Id'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ]);
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(labelText: 'Name'),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildPriceField() {
    return TextFormField(
        controller: _priceController,
        decoration: InputDecoration(labelText: 'Price'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ]);
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(labelText: 'Description'),
      keyboardType: TextInputType.text,
    );
  }

  // Widget _buildImageField() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Image'),
  //     onTap: () async {
  //       _onAlertPress();
  //     },
  //   );
  // }

  Widget _buildUrlField() {
    return TextFormField(
      controller: _urlController,
      decoration: InputDecoration(labelText: 'Url'),
      keyboardType: TextInputType.url,
    );
  }

  Widget _buildViewsField() {
    return TextFormField(
        controller: _viewsController,
        decoration: InputDecoration(labelText: 'Views'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ]);
  }

  Widget _buildOrderField() {
    return TextFormField(
        controller: _total_orderController,
        decoration: InputDecoration(labelText: 'Total order'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ]);
  }

  Widget _buildRevenueField() {
    return TextFormField(
        controller: _total_revenueController,
        decoration: InputDecoration(labelText: 'Revenue'),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ]);
  }

  Widget _buildStatus() {
    return Row(
      children: <Widget>[
        Text(
          'Status',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 50,
        ),
        DropdownButton<String>(
          items: _statusOptions.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          onChanged: (String newValueSelected) {
            dropDownItemSelected(newValueSelected);
            setState(() {
              _selectedValue = _currentStatusSelected;
            });
          },
          value: _selectedValue,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Edit Order' : 'Create Order'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: _isLoading
                  ? Center(child: CircularProgressIndicator(),)
                  : Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: _image == null
                                  ? NetworkImage(
                                  'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                  : FileImage(_image),
                              radius: 50.0,
                            ),
                            InkWell(
                              onTap: _onAlertPress,
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.0),
                                      color: Colors.black),
                                  margin: EdgeInsets.only(left: 70, top: 70),
                                  child: Icon(
                                    Icons.photo_camera,
                                    size: 25,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                        Text('Product Image',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  // _buildIdField(),
                  _buildNameField(),
                  _buildPriceField(),
                  _buildDescriptionField(),
                  // _buildImageField(),
                  _buildUrlField(),
                  _buildViewsField(),
                  _buildOrderField(),
                  _buildRevenueField(),
                  SizedBox(height: 5),
                  _buildStatus(),
                  SizedBox(height: 15),
                  RaisedButton(
                    color: Colors.indigo[900],
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: (() async {
                      if (isEditing) {
                        // update the order
                        _updateOrder();
                      }
                      else {
                        // create the order
                        if (_formKey.currentState.validate()) {
                          _startUploading(addressUri);
                        }
                      }
                    }),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void dropDownItemSelected(String newValue) {
    setState(() {
      this._currentStatusSelected = newValue;
    });
  }

  // void _uploadOrder() async {
  //   print(' VALUE OF STATUS: _currentStatusSelected ');
  //   final OrderInsert newOrder = OrderInsert(
  //     // id: int.parse(_idController.text),
  //     name: _nameController.text,
  //     price: double.parse(_priceController.text),
  //     description: _descriptionController.text,
  //     // image:,
  //     url: _urlController.text,
  //     views: int.parse(_viewsController.text),
  //     total_order: int.parse(_total_orderController.text),
  //     total_revenue: int.parse(_total_revenueController.text),
  //     status: _selectedValue,
  //   );
  //
  //   final result = await orderService.createOrder(newOrder);
  //   final title = 'Done';
  //   final text = result.error ? (result.errorMessage ??
  //       'An error occurred') : 'Your product is created';
  //   showDialog(context: context,
  //       builder: (_) =>
  //           AlertDialog(
  //               title: Text(title),
  //               content: Text(text),
  //               actions: <Widget>[
  //                 FlatButton(
  //                   child: Text('OK'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 )
  //               ]
  //           )
  //   ).then((data) {
  //     if (result.data) {
  //       Navigator.of(context).pop();
  //     }
  //   });
  // }


  Future<Map<String, dynamic>> _uploadImage(File image) async {
    print('INSIDE UPLOAD IMAGE METHOD');
    final mimeTypeData =
    lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    _image = image;
    print('IMAGE : $image');
    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', addressUri);

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath(
        'image', image.path ,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    // Explicitly pass the extension of the image with request body
    // Since image_picker has some bugs due which it mixes up
    // image extension with file name like this filenamejpge
    // Which creates some problem at the server side to manage
    // or verify the file extension

    // imageUploadRequest.fields['ext'] = mimeTypeData[1];
    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['name'] = _nameController.text;
    imageUploadRequest.fields['price'] = _priceController.text;
    imageUploadRequest.fields['description'] = _descriptionController.text;
    imageUploadRequest.fields['url'] = _urlController.text;
    imageUploadRequest.fields['views'] = _viewsController.text;
    imageUploadRequest.fields['total_order'] = _total_orderController.text;
    imageUploadRequest.fields['total_revenue'] = _total_revenueController.text;
    imageUploadRequest.fields['status'] = 'ACTIVE';

    try {
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode != 200) {
      print("Status code is : ${response.statusCode}");
      print("Body is : ${response.body}");

      return null;
    }
    print("Status code is : ${response.statusCode}");
    print("Body is : ${response.body}");

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    print("Body of response  : ${response.body}");
    return responseData;
    } catch (e) {
    print('ERROR IS : $e');
    return null;
    }
  }

  //================================= Image from camera
  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      Navigator.pop(context);
    });
  }

  //============================== Image from gallery
  Future getGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image ;
      Navigator.pop(context);
    });
  }

  //========================= Gellary / Camera AlerBox
  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/gallery.png',
                      width: 50,
                    ),
                    Text('Gallery'),
                  ],
                ),
                onPressed: getGalleryImage,
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/take_picture.png',
                      width: 50,
                    ),
                    Text('Take Photo'),
                  ],
                ),
                onPressed: getCameraImage,
              ),
            ],
          );
        });
  }

  void _startUploading(Uri uri) async {
    print('START UPLOADING WAS called');
    final Map<String, dynamic> response = await _uploadImage(_image);
    print('Value of response of : $response');
    if (response == null) {
      // pr.hide();
      messageAllert('User details updated successfully', 'Success');
    } else {
      messageAllert('Please Select a profile photo', 'Profile Photo');
    }
  }

  messageAllert(String msg, String ttl) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: Text(ttl),
            content: Text(msg),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Okay'),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _updateOrder() async {
    Uri updateAddressUri = Uri.parse(
    'https://l5vqpgr2pd.execute-api.us-west-2.amazonaws.com/dev/api/v1/product/${order.id}/');
    print('START UPLOADING WAS called');
    final Map<String, dynamic> response = await _updateImage(_image, updateAddressUri);
    print('Value of response of : $response');
    if (response == null) {
      messageAllert('User details updated successfully', 'Success');
    } else {
      messageAllert('Please Select a profile photo', 'Profile Photo');
    }
  }

    Future<Map<String, dynamic>> _updateImage(File image, Uri uri) async {
      print('INSIDE UPdate IMAGE METHOD');
      final mimeTypeData =
      lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
      _image = image;
      print('IMAGE : $image');
      // Intilize the multipart request
      final imageUploadRequest = http.MultipartRequest('PUT', uri);

      // Attach the file in the request
      final file = await http.MultipartFile.fromPath(
          'image', image.path ,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
      // Explicitly pass the extension of the image with request body
      // Since image_picker has some bugs due which it mixes up
      // image extension with file name like this filenamejpge
      // Which creates some problem at the server side to manage
      // or verify the file extension

      // imageUploadRequest.fields['ext'] = mimeTypeData[1];
      imageUploadRequest.files.add(file);
      imageUploadRequest.fields['name'] = _nameController.text;
      imageUploadRequest.fields['price'] = _priceController.text;
      imageUploadRequest.fields['description'] = _descriptionController.text;
      imageUploadRequest.fields['url'] = _urlController.text;
      imageUploadRequest.fields['views'] = _viewsController.text;
      imageUploadRequest.fields['total_order'] = _total_orderController.text;
      imageUploadRequest.fields['total_revenue'] = _total_revenueController.text;
      imageUploadRequest.fields['status'] = 'ACTIVE';

      try {
        final streamedResponse = await imageUploadRequest.send();
        final response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode != 204) {
          print("Status code is : ${response.statusCode}");
          print("Body is : ${response.body}");

          return null;
        }
        print("Status code is : ${response.statusCode}");
        print("Body is : ${response.body}");

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("Body of response  : ${response.body}");
        return responseData;
      } catch (e) {
        print('ERROR IS : $e');
        return null;
      }
    }


}
