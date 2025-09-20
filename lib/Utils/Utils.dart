import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

//focus node to shift textfield after press enter key
static moveToNextNode(BuildContext context,FocusNode currentNode,FocusNode nextNode){
  currentNode.unfocus();
  FocusScope.of(context).requestFocus(nextNode);

}

  //toast message
  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      fontSize: 20,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,



    );
  }
}