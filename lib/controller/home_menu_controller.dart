import 'package:get/get.dart';

class HomeMenuController extends GetxController {
  var isMenuOpen = false.obs;

  void toggleMenu() {
    isMenuOpen.value = !isMenuOpen.value;
  }

  RxString getGreetingMessage() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning".obs;
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon".obs;
    } else {
      return "Good Evening".obs;
    }
  }
}
