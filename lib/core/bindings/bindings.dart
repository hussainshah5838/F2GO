import 'package:f2g/controller/my_ctrl/auth_input_controller.dart';
import 'package:f2g/controller/my_ctrl/chat_controller.dart';
import 'package:f2g/controller/my_ctrl/editprofile_controller.dart';
import 'package:f2g/controller/my_ctrl/plan_controller.dart';
import 'package:f2g/view/screens/textcontrollers/textcontrollers.dart';
import 'package:get/get.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(TextControllers());
    Get.put(AuthInputController());
  }
}

class ProfileBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}

class PlanBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(PlanController());
    Get.put(ChatController());
  }
}

class ChatBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ChatController());
  }
}
