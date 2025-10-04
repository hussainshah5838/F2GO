import 'package:get/get.dart';

class HomeMenuController extends GetxController {
  var isMenuOpen = false.obs;

  void toggleMenu() {
    isMenuOpen.value = !isMenuOpen.value;
  }
}
