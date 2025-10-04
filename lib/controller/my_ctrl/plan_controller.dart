import 'dart:developer';
import 'dart:io';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/core/enums/plan_status.dart';
import 'package:f2g/model/my_model/plan_model.dart';
import 'package:f2g/services/firebase_storage/firebase_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PlanController extends GetxController {
  // Create plan variables
  Rxn<DateTime> startDate = Rxn<DateTime>(null);
  Rxn<DateTime> endDate = Rxn<DateTime>(null);
  TextEditingController titleController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController maxMemberController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? eventSelectedImage;
  Uuid uuid = Uuid();
  final ImagePicker _picker = ImagePicker();
  final Rxn<File> selectedImage = Rxn<File>();
  // Fetch plan varibles
  RxList<PlanModel> plans = <PlanModel>[].obs;
  RxBool isLoading = false.obs;

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        eventSelectedImage = pickedFile.path;
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

  // Create Plan

  Future<void> createPlan({String? eventImage}) async {
    try {
      showLoadingDialog();
      String id = uuid.v4();

      String? downloadUrl;
      if (eventImage != null) {
        downloadUrl = await FirebaseStorageService.instance.uploadImage(
          imagePath: eventImage,
          storageFolderPath: "planImages/",
        );
      }

      PlanModel model = PlanModel(
        id: id,
        planPhoto: downloadUrl,
        title: titleController.text.trim(),
        age: ageController.text.trim(),
        startDate: startDate.value,
        endDate: endDate.value,
        maxMembers: maxMemberController.text.trim(),
        location: locationController.text.trim(),
        category: categoryController.text.trim(),
        description: descriptionController.text.trim(),
        createdAt: DateTime.now(),
        planCreatorID: auth.currentUser?.uid.toString(),
        status: PlanStatus.active.name,
        participantsIds: [],
      );

      plansCollection.doc(id).set(model.toMap());

      hideLoadingDialog();
      clearFields();
      Get.close(1);
      displayToast(msg: "Plan added successfully.");
    } catch (e) {
      hideLoadingDialog();
      displayToast(msg: "Failed to add plan $e");
      log("Error during creating plan: $e");
    }
  }

  // Clear variables

  void clearFields() {
    startDate.value = null;
    endDate.value = null;
    titleController.clear();
    descriptionController.clear();
    ageController.clear();
    maxMemberController.clear();
    locationController.clear();
    categoryController.clear();
    eventSelectedImage = null;
  }

  // Fetch plans based on "active" or "completed"
  Future<void> fetchPlans({String? status}) async {
    try {
      isLoading.value = true;

      final snapShot =
          await plansCollection.where("status", isEqualTo: status).get();

      if (snapShot.docs.isNotEmpty) {
        plans
          ..clear()
          ..addAll(snapShot.docs.map((doc) => PlanModel.fromMap(doc.data())));
      }

      isLoading.value = false;
      log("✅ Plans Fetched: ${plans.length}");
    } catch (e) {
      isLoading.value = false;
      displayToast(msg: "Error while fetching plans: $e");
      log("❌ Error while fetching plans: $e");
    }
  }
}
