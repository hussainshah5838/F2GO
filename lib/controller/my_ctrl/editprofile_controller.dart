import 'dart:developer' show log;
import 'dart:io';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/core/common/global_instance.dart';
import 'package:f2g/services/firebase_storage/firebase_storage_service.dart';
import 'package:f2g/services/user/user_services.dart';
import 'package:f2g/view/screens/auth/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/app_colors.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController(
    text: UserService.instance.userModel.value.fullName ?? "",
  );

  final biographyController = TextEditingController(
    text: UserService.instance.userModel.value.bio ?? "",
  );

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController accountDeletionPasswordController =
      TextEditingController();

  final ImagePicker _picker = ImagePicker();

  final Rxn<File> selectedImage = Rxn<File>();
  String? profileImageUrl;

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        profileImageUrl = pickedFile.path;

        update();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick image",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateUserInfo({
    required String name,
    required String bio,
    String? profileImage,
  }) async {
    try {
      showLoadingDialog();
      String? downloadUrl;
      if (profileImage != null) {
        downloadUrl = await FirebaseStorageService.instance.uploadImage(
          imagePath: profileImage,
          storageFolderPath: "userProfileImages/${auth.currentUser?.uid}/",
        );
      }

      Map<String, String> body;

      if (profileImage != null) {
        body = {
          'bio': bio,
          'fullName': name,
          'profileImage': downloadUrl ?? '',
        };
      } else {
        body = {'bio': bio, 'fullName': name};
      }

      await userCollection.doc(auth.currentUser?.uid).update(body);

      await userService.getCurrentUserInformation();

      hideLoadingDialog();
      Get.close(1);

      Get.snackbar(
        "Success",
        "Profile updated successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kSecondaryColor,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );

      downloadUrl == null;
      profileImageUrl == null;
    } catch (e) {
      log("Error updating profile: $e");
    }
  }

  // ----------- Update Password -----------------

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      log('Step 1: Starting password change process');
      showLoadingDialog();
      AuthCredential credential = await EmailAuthProvider.credential(
        email: auth.currentUser!.email.toString(),
        password: oldPassword,
      );

      // if (newPassword == confirmPassword) {
      await auth.currentUser!.reauthenticateWithCredential(credential);

      await auth.currentUser!.updatePassword(newPassword);

      Get.snackbar(
        "Success",
        "Password updated successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kSecondaryColor,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );

      hideLoadingDialog();

      Get.back();
      // } else {
      //   displayToast(msg: 'Password not matched');

      //   hideLoadingDialog();
      // }
    } on FirebaseAuthException catch (error) {
      hideLoadingDialog();
      displayToast(msg: "Exception ${error.toString()}");
      log('Error: This Error Occure during password change $error');
    } catch (e) {
      hideLoadingDialog();
      log('Unexpected Error: $e');
    }
  }

  // Delete current user account

  Future<void> _reauthenticateUser(
    BuildContext context,
    User user,
    String password,
  ) async {
    try {
      // Prompt user for reauthentication (assuming email/password login)
      String email = user.email ?? "";
      password; // Show a dialog to get the password

      // Create email/password credentials
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      // Reauthenticate the user
      await user.reauthenticateWithCredential(credential);
      log('User reauthenticated successfully.');
    } catch (e) {
      log("Reauthentication failed: $e");
      throw e; // Rethrow the exception to stop further actions
    }
  }

  Future<void> deleteCurrentUserAccount(contex) async {
    try {
      showLoadingDialog();
      // Delete current all data stored in firestore

      await userCollection.doc(auth.currentUser?.uid).delete();
      final querySnapshot =
          await plansCollection
              .where('planCreatorID', isEqualTo: auth.currentUser?.uid)
              .get();

      for (var doc in querySnapshot.docs) {
        await plansCollection.doc(doc.id).delete();
        await chatCollection.doc(doc.id).delete();
        log("Delete Document Collection Called --------------- ${doc.id}");
      }

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          // Reauthenticate the user before deleting
          await _reauthenticateUser(
            contex,
            user,
            accountDeletionPasswordController.text,
          );
          // If reauthentication is successful, proceed to delete the account
          await user.delete();
          log("User account deleted successfully.");
          hideLoadingDialog();
          // Navigate to a login or home screen after deletion
          Get.offAll(() => LoginScreen());
        } catch (e) {
          hideLoadingDialog();
          log("Failed to delete user: $e");
        }
      } else {
        hideLoadingDialog();
        log("Error, No user is currently signed in.");
      }
      hideLoadingDialog();
      log("Current user delete");
      accountDeletionPasswordController.clear();
    } catch (e) {
      hideLoadingDialog();
      log("Error occures while current user account deletion: $e");
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    // emailController.dispose();
    biographyController.dispose();
    super.onClose();
  }
}
