import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FocusController extends GetxController {
  final int numberOfFields = 8;

  late List<FocusNode> focusNodes;
  late List<RxBool> isFocusedList;

  @override
  void onInit() {
    focusNodes = List.generate(numberOfFields, (index) => FocusNode());
    isFocusedList = List.generate(numberOfFields, (index) => false.obs);

    for (int i = 0; i < numberOfFields; i++) {
      focusNodes[i].addListener(() {
        isFocusedList[i].value = focusNodes[i].hasFocus;
      });
    }
    super.onInit();
  }
}
