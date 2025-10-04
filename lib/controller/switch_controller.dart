import 'package:get/get.dart';

class CustomSwitchController extends GetxController {
  final isOn = false.obs;

  void toggle() {
    isOn.value = !isOn.value;
  }
}
