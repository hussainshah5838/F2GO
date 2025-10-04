import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/model/my_model/user_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UserService {
  UserService._privateConstructor();

  static UserService? _instance;

  static UserService get instance {
    _instance ??= UserService._privateConstructor();
    return _instance!;
  }

  Rx<UserModel> userModel = UserModel().obs;

  Future<void> getCurrentUserInformation() async {
    try {
      var snapShot = await userCollection.doc(auth.currentUser?.uid).get();

      if (snapShot.exists) {
        userModel.value = UserModel.fromMap(snapShot);
        log("-> User data fetched");
      } else {
        log("-> User data fetched Not Exists");
      }
    } on FirebaseException catch (e) {
      displayToast(msg: "Exception: $e");
      log("This exception occurred while getting user data: $e");
    } catch (e) {
      log("This exception occurred while getting user data: $e");
    }
  }
}
