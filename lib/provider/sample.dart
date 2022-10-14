import 'package:flutter/material.dart';

class Sample with ChangeNotifier{
  String text = 'this is counter';

  int counter = 0;

  void counterIncrement(){
    counter++;
    notifyListeners();
  }

}