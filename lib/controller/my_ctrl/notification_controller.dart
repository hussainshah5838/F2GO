import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/constants/loading_animation.dart';
import 'package:f2g/model/my_model/notification_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchMyPlan() async {
    try {
      isLoading.value = true;

      await Future.delayed(Duration(milliseconds: 50));

      notifications.value = [];
      update();

      final QuerySnapshot<Map<String, dynamic>> snapShot;

      snapShot = await notificationCollection.get();

      if (snapShot.docs.isNotEmpty) {
        for (final doc in snapShot.docs) {
          final data = doc.data();
          notifications.add(NotificationModel.fromJson(data));
        }
      }

      update();

      isLoading.value = false;
      log("✅ Notification Plan Fetched: ${notifications.length}");
    } catch (e) {
      isLoading.value = false;
      displayToast(msg: "Error while fetching My-Plans: $e");
      log("❌ Error while fetching My-Plans: $e");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchMyPlan();
  }
}
