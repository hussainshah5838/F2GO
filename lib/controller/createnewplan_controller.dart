// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class CreateNewPlanController extends GetxController {
//   final ImagePicker _picker = ImagePicker();

//   final Rxn<File> selectedImage = Rxn<File>();

//   Future<void> pickImage() async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1920,
//         maxHeight: 1080,
//         imageQuality: 80,
//       );

//       if (pickedFile != null) {
//         selectedImage.value = File(pickedFile.path);
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to pick image",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
// }
