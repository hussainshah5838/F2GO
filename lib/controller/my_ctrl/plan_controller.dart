import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/controller/my_ctrl/chat_controller.dart';
import 'package:f2g/core/enums/categories_status.dart';
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
  // TextEditingController categoryController = TextEditingController();
  CategoriesStatus? selectedCategory;
  TextEditingController descriptionController = TextEditingController();
  String? eventSelectedImage;
  Uuid uuid = Uuid();
  final ImagePicker _picker = ImagePicker();
  final Rxn<File> selectedImage = Rxn<File>();
  // Fetch plan varibles
  RxList<PlanModel> plans = <PlanModel>[].obs;
  RxList<PlanModel> favourites = <PlanModel>[].obs;
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
        category: selectedCategory?.name.toString(),
        description: descriptionController.text.trim(),
        createdAt: DateTime.now(),
        planCreatorID: auth.currentUser?.uid.toString(),
        status: PlanStatus.active.name,
        participantsIds: [],
      );

      plansCollection.doc(id).set(model.toMap());

      // createChatThread

      final ctrl = Get.find<ChatController>();

      await ctrl.creatingChatThread(myID: auth.currentUser!.uid, chatID: id);

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
    selectedCategory = null;
    eventSelectedImage = null;
  }

  // ---- Fetch Plans ----
  // Future<void> fetchPlans({String? status, String? planCategories}) async {
  //   try {
  //     isLoading.value = true;

  //     final QuerySnapshot<Map<String, dynamic>> snapShot;

  //     if (planCategories != null) {
  //       snapShot =
  //           await plansCollection
  //               .where("category", isEqualTo: planCategories)
  //               .where("status", isEqualTo: status)
  //               .get();
  //     } else {
  //       snapShot =
  //           await plansCollection.where("status", isEqualTo: status).get();
  //     }

  //     if (snapShot.docs.isNotEmpty) {
  //       plans
  //         ..clear()
  //         ..addAll(snapShot.docs.map((doc) => PlanModel.fromMap(doc.data())));
  //     }

  //     isLoading.value = false;
  //     log("✅ Plans Fetched: ${plans.length}");
  //   } catch (e) {
  //     isLoading.value = false;
  //     displayToast(msg: "Error while fetching plans: $e");
  //     log("❌ Error while fetching plans: $e");
  //   }
  // }

  Future<void> fetchPlans({String? status, String? planCategories}) async {
    try {
      isLoading.value = true;

      final QuerySnapshot<Map<String, dynamic>> snapShot;

      if (planCategories != null) {
        snapShot =
            await plansCollection
                .where("category", isEqualTo: planCategories)
                .where("status", isEqualTo: status)
                .get();
      } else {
        snapShot =
            await plansCollection.where("status", isEqualTo: status).get();
      }

      bool anyStatusUpdated = false;

      if (snapShot.docs.isNotEmpty) {
        plans.clear();

        for (final doc in snapShot.docs) {
          final data = doc.data();

          final startDate = DateTime.tryParse(data["startDate"].toString());
          final currentDate = DateTime.now();

          // Compare only date (ignore time)
          final isSameDate =
              startDate != null &&
              startDate.year == currentDate.year &&
              startDate.month == currentDate.month &&
              startDate.day == currentDate.day;

          if (isSameDate && data["status"] != PlanStatus.completed.name) {
            // 🔹 Update Firestore document to mark as completed
            await plansCollection.doc(doc.id).update({
              "status": PlanStatus.completed.name,
            });

            anyStatusUpdated = true; // 🔸 Flag that we made updates
          } else {
            plans.add(PlanModel.fromMap(data));
          }
        }
      }

      // 🔁 If any plan was updated, fetch fresh data again
      if (anyStatusUpdated) {
        log("🔄 Status updated, fetching fresh data...");
        await fetchPlans(status: status, planCategories: planCategories);
        return;
      }

      isLoading.value = false;
      log("✅ Plans Fetched: ${plans.length}");
    } catch (e) {
      isLoading.value = false;
      displayToast(msg: "Error while fetching plans: $e");
      log("❌ Error while fetching plans: $e");
    }
  }

  // Join Event
  Future<void> joinPlan({required String planId}) async {
    try {
      showLoadingDialog();

      await plansCollection.doc(planId).update({
        "participantsIds": FieldValue.arrayUnion([auth.currentUser!.uid]),
      });
      await chatCollection.doc(planId).update({
        "participants": FieldValue.arrayUnion([auth.currentUser!.uid]),
      });

      hideLoadingDialog();
      displayToast(msg: "You have successfully joined the plan.");
    } catch (e) {
      hideLoadingDialog();
      displayToast(msg: "Failed to join plan: $e");
      log("Error during joining plan: $e");
    }
  }

  // Leave from Plan
  Future<void> leavePlan({required String planId}) async {
    try {
      showLoadingDialog();

      await plansCollection.doc(planId).update({
        "participantsIds": FieldValue.arrayRemove([auth.currentUser!.uid]),
      });

      await chatCollection.doc(planId).update({
        "participants": FieldValue.arrayRemove([auth.currentUser!.uid]),
      });

      hideLoadingDialog();
      displayToast(msg: "You have successfully left the plan.");
    } catch (e) {
      hideLoadingDialog();
      displayToast(msg: "Failed to leave plan: $e");
      log("Error during Leave plan: $e");
    }
  }

  // Favorite Plan
  Future<void> favouritePlan({required String planId}) async {
    try {
      showLoadingDialog();

      await plansCollection.doc(planId).update({
        "favIds": FieldValue.arrayUnion([auth.currentUser!.uid]),
      });

      hideLoadingDialog();
      displayToast(msg: "Marked as favourite plan.");
    } catch (e) {
      hideLoadingDialog();
      displayToast(msg: "Failed favourite plan: $e");
      log("Error during favouriting plan: $e");
    }
  }

  // Remove Favorite Plan
  Future<void> removeFavouritePlan({required String planId}) async {
    try {
      showLoadingDialog();

      await plansCollection.doc(planId).update({
        "favIds": FieldValue.arrayRemove([auth.currentUser!.uid]),
      });

      hideLoadingDialog();
      displayToast(msg: "You have successfully remove favorite plan.");
    } catch (e) {
      hideLoadingDialog();
      displayToast(msg: "Failed to remove favorite: $e");
      log("Error during remove favorite: $e");
    }
  }

  // ---- Fetch Fav ----
  Future<void> fetchFav() async {
    try {
      isLoading.value = true;

      final QuerySnapshot<Map<String, dynamic>> snapShot;

      snapShot =
          await plansCollection
              .where("favIds", arrayContains: auth.currentUser?.uid)
              .get();

      if (snapShot.docs.isNotEmpty) {
        favourites
          ..clear()
          ..addAll(snapShot.docs.map((doc) => PlanModel.fromMap(doc.data())));
      }

      isLoading.value = false;
      log("✅ Fetched favourite plan: ${favourites.length}");
    } catch (e) {
      isLoading.value = false;
      displayToast(msg: "Error while fetching favourite plans: $e");
      log("❌ Error while fetching favourite plans: $e");
    }
  }
}
