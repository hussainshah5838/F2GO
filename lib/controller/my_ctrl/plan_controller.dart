import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2g/constants/end_point.dart';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/controller/my_ctrl/chat_controller.dart';
import 'package:f2g/core/enums/categories_status.dart';
import 'package:f2g/core/enums/plan_status.dart';
import 'package:f2g/model/my_model/plan_model.dart';
import 'package:f2g/services/firebase_storage/firebase_storage_service.dart';
import 'package:f2g/services/user/user_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PlanController extends GetxController {
  // Page Builder
  RxInt currentPage = 0.obs;
  RxInt itemsPerPage = 6.obs;

  RxInt currentExpirePage = 0.obs;
  RxInt itemsExpirePerPage = 6.obs;

  int minAgeChecker = 18;
  int maxAgeChecker = 19;
  // Create plan variables
  Rxn<DateTime> startDate = Rxn<DateTime>(null);
  Rxn<DateTime> endDate = Rxn<DateTime>(null);
  Rxn<DateTime> startTime = Rxn<DateTime>(null);
  Rxn<DateTime> endTime = Rxn<DateTime>(null);
  TextEditingController titleController = TextEditingController();
  // TextEditingController ageController = TextEditingController();
  // Rxn<String> ageValue = Rxn<String>();
  // TextEditingController maxMemberController = TextEditingController();
  Rxn<String> maxMemberValue = Rxn();
  TextEditingController locationController = TextEditingController();
  TextEditingController ageToController = TextEditingController();
  TextEditingController ageFromController = TextEditingController();
  // TextEditingController categoryController = TextEditingController();
  // CategoriesStatus? selectedCategory;
  Rxn<CategoriesStatus> selectedCategory = Rxn<CategoriesStatus>();

  TextEditingController descriptionController = TextEditingController();
  String? eventSelectedImage;
  Uuid uuid = Uuid();
  final ImagePicker _picker = ImagePicker();
  final Rxn<File> selectedImage = Rxn<File>();
  // Fetch plan varibles
  RxList<PlanModel> plans = <PlanModel>[].obs;
  RxList<PlanModel> expirePlans = <PlanModel>[].obs;
  late RxList<PlanModel> filterPlans = <PlanModel>[].obs;
  RxList<PlanModel> myPlans = <PlanModel>[].obs;
  RxList<PlanModel> favourites = <PlanModel>[].obs;
  RxBool isLoading = false.obs;

  RxInt buttonStatusIndex = 100.obs;
  RxBool isOpened = false.obs;
  RxList<dynamic> predictions = [].obs;
  RxString locationName = ''.obs;
  double lat = 0.0;
  double lng = 0.0;
  LatLng? selectedLocation;

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
        creatorName: UserService.instance.userModel.value.fullName,

        planPhoto: downloadUrl,
        title: titleController.text.trim(),
        // age: ageController.text.trim(),
        age: "${ageFromController.text}-${ageToController.text}",

        startDate: startDate.value,
        endDate: endDate.value,
        startTime: startTime.value,
        endTime: endTime.value,

        // maxMembers: maxMemberController.text.trim(),
        maxMembers: maxMemberValue.value,
        location: locationController.text.trim(),
        // category: selectedCategory?.name.toString(),
        category: selectedCategory.value?.name.toString(),
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

    startTime.value = null;
    endTime.value = null;

    titleController.clear();
    descriptionController.clear();
    ageFromController.clear();
    ageToController.clear();
    // ageController.clear();
    // ageValue.value = null;
    // maxMemberController.clear();
    maxMemberValue.value = null;
    locationController.clear();
    selectedCategory.value = null;
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

  Future<void> fetchMyPlan() async {
    try {
      isLoading.value = true;

      await Future.delayed(Duration(milliseconds: 50));

      myPlans.value = [];
      update();

      final QuerySnapshot<Map<String, dynamic>> snapShot;

      snapShot =
          await plansCollection
              .where("planCreatorID", isEqualTo: auth.currentUser?.uid)
              .get();

      if (snapShot.docs.isNotEmpty) {
        myPlans.clear();

        for (final doc in snapShot.docs) {
          final data = doc.data();
          myPlans.add(PlanModel.fromMap(data));
        }
      }

      update();

      isLoading.value = false;
      log("✅ My-Plans Fetched: ${myPlans.length}");
    } catch (e) {
      isLoading.value = false;
      displayToast(msg: "Error while fetching My-Plans: $e");
      log("❌ Error while fetching My-Plans: $e");
    }
  }

  // Future<void> fetchPlans({String? status, String? planCategories}) async {
  //   try {
  //     isLoading.value = true;

  //     await Future.delayed(const Duration(milliseconds: 50));

  //     plans.value = [];
  //     update();

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
  //       plans.clear();

  //       for (final doc in snapShot.docs) {
  //         final data = doc.data();
  //         // ✅ Simply add all fetched plans (no status update)
  //         plans.add(PlanModel.fromMap(data));
  //       }
  //     }

  //     update();
  //     isLoading.value = false;
  //     log("✅ Plans Fetched: ${plans.length}");
  //   } catch (e) {
  //     isLoading.value = false;
  //     displayToast(msg: "Error while fetching plans: $e");
  //     log("❌ Error while fetching plans: $e");
  //   }
  // }

  // --------- Expired Planed ------------

  Future<void> expiredFetchPlans() async {
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(milliseconds: 50));

      expirePlans.value = [];
      update();

      final QuerySnapshot<Map<String, dynamic>> snapShot;

      snapShot =
          await plansCollection
              .where("status", isEqualTo: PlanStatus.completed.name)
              .get();

      if (snapShot.docs.isNotEmpty) {
        expirePlans.clear();

        for (final doc in snapShot.docs) {
          final data = doc.data();
          // ✅ Simply add all fetched plans (no status update)
          expirePlans.add(PlanModel.fromMap(data));
        }
      }

      update();
      isLoading.value = false;
      log("✅ Expire-Plans Fetched: ${expirePlans.length}");
    } catch (e) {
      isLoading.value = false;
      displayToast(msg: "Error while fetching expire-plans: $e");
      log("❌ Error while fetching expire-plans: $e");
    }
  }

  // ---------- Here is the updated fetch plan ----------

  Future<void> fetchPlans({String? status, String? planCategories}) async {
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(milliseconds: 50));

      plans.value = [];
      update();

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

      if (snapShot.docs.isNotEmpty) {
        plans.clear();

        for (final doc in snapShot.docs) {
          final data = doc.data();
          final plan = PlanModel.fromMap(data);

          // ✅ Check if end date & time are in the past or equal to current time
          if (plan.endDate != null && plan.endTime != null) {
            final DateTime endDateTime = DateTime(
              plan.endDate!.year,
              plan.endDate!.month,
              plan.endDate!.day,
              plan.endTime!.hour,
              plan.endTime!.minute,
            );

            final DateTime now = DateTime.now();

            if (now.isAfter(endDateTime) || now.isAtSameMomentAs(endDateTime)) {
              // ✅ Update Firestore status to completed
              await plansCollection.doc(plan.id).update({
                "status": PlanStatus.completed.name,
              });

              // ✅ Update local model as well

              // final String v;
              //  plan.status = PlanStatus.completed.name;
            }
          }

          plans.add(plan);
        }
      }

      update();
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

  // Join Event
  Future<void> planStatusToggel({
    required String docID,
    required String status,
  }) async {
    try {
      showLoadingDialog();

      await plansCollection.doc(docID).update({"status": status});

      await fetchMyPlan();
      buttonStatusIndex.value = 100;
      Get.close(2);

      hideLoadingDialog();
      displayToast(msg: "You have successfully updated plan status.");
    } catch (e) {
      hideLoadingDialog();
      displayToast(msg: "Failed to update plan status: $e");
      log("Error during plan status plan: $e");
    }
  }

  // ---------- Search Places ----------

  void searchPlaces(String input) async {
    if (input.isEmpty) {
      isOpened.value = false;
    }

    final String request = "$getPlaceApi?input=$input&key=$apiKey";

    try {
      isOpened.value = true;
      final response = await http.get(Uri.parse(request));
      // log("1.Response -----> ${response}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        //  setState(() {
        predictions.value = data["predictions"];
        //  });
        // log("2.Response Data -----> $data");
      }

      isOpened.value = false;
    } catch (e) {
      isOpened.value = false;
      log("Error: $e");
    }
  }

  // ------------ Get Cordinates of adress -------------

  Future<void> getPlaceCoordinates(String placeId) async {
    try {
      final String baseUrl =
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // log("data :----> ${data}");
        final location = data['result']['geometry']['location'];
        final formattedAddress = data['result']['formatted_address'];

        // log("Adress :----> ${formattedAddress}");
        lat = location['lat'];
        lng = location['lng'];
        locationName.value = formattedAddress;
        locationController.text = formattedAddress;
        isOpened.value = false;

        selectedLocation = LatLng(lat, lng);
        // log("lat & long //\\:----> ${[lat]} -- ${[lng]}");

        // moveCamera();
      }

      // log("--------> Lat-Lng fetched <---------");
      isOpened.value = false;
    } catch (e) {
      isOpened.value = false;
      log("Error Occurs while getting lat long:------> $e");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPlans(status: PlanStatus.active.name);
    expiredFetchPlans();
  }
}
