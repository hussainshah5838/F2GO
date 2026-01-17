import 'dart:developer';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/core/bindings/bindings.dart';
import 'package:f2g/main.dart';
import 'package:f2g/model/my_model/user_model.dart';
import 'package:f2g/services/user/user_services.dart';
import 'package:f2g/services/user_profile_setup/user_profile_setup_service.dart';
import 'package:f2g/view/screens/Home/home_screen.dart';
import 'package:f2g/view/screens/auth/login/login.dart';
import 'package:f2g/view/screens/launch/complete_profile_onboarding/complete_profile_onboarding.dart';
import 'package:f2g/view/screens/launch/my_loading_screen.dart';
import 'package:f2g/view/screens/my_plans/my_plans.dart';
import 'package:f2g/view/screens/textcontrollers/textcontrollers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthInputController extends GetxController {
  @override
  void onClose() {
    fullNameController.dispose();
    userLocationController.dispose();
    userBioController.dispose();
    emergencyNameController.dispose();
    emergencyContactNoController.dispose();
    super.dispose();
  }

  // ---- USER PROFILE SETUP ------
  TextEditingController fullNameController = TextEditingController();
  RxnString gender = RxnString();

  RxnString dob = RxnString();
  RxnString profileImage = RxnString();
  TextEditingController userLocationController = TextEditingController();
  TextEditingController userBioController = TextEditingController();
  TextEditingController emergencyNameController = TextEditingController();
  TextEditingController emergencyContactNoController = TextEditingController();
  RxnString emergencyPesonRelation = RxnString();

  //-------------------------------
  FirebaseMessaging fcmToken = FirebaseMessaging.instance;
  var isrememberme = false.obs;
  var ispolicyagree = false.obs;
  var isloginpasswordvisible = false.obs;
  var issinguppasswordvisible = false.obs;
  var iscreatenewpasswordvisible = false.obs;
  var isconfirmnewpasswordvisible = false.obs;

  var isEmailValid = false.obs;
  var isSignupEmailValid = false.obs;
  var areFieldsFilled = false.obs;
  // var isfullnameFilled = false.obs;
  var isPasswordError = false.obs;
  var isSignupPasswordValidRx = false.obs;

  var areSignupFeildstrue = false.obs;

  final TextControllers textControllers = Get.find<TextControllers>();

  // void isFullNameValid() {
  //   isfullnameFilled.value =
  //       textControllers.signupFullNameController.value.text.trim().isNotEmpty;
  //   checkSignupFields();
  // }

  void clearValues() {
    fullNameController.clear();
    userLocationController.clear();
    userBioController.clear();
    emergencyNameController.clear();
    emergencyContactNoController.clear();
    gender.value = null;
    dob.value = null;
    emergencyPesonRelation.value = null;
    profileImage.value = null;
  }

  bool isSignupPasswordValid() {
    final password = textControllers.signuppasswordController.value.text;
    final hasCapital = password.contains(RegExp(r'[A-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    return hasCapital && hasNumber;
  }

  void onSignUpPasswordChanged(String value) {
    isSignupPasswordValidRx.value = isSignupPasswordValid();
    checkSignupFields();
    update();
  }

  void onEmailChanged(String value) {
    isEmailValid.value = value.contains("@");
    checkFieldsFilled();
  }

  void onSignupEmailChanged(String value) {
    isSignupEmailValid.value = value.contains("@");
    checkSignupFields();
  }

  void onPasswordChanged(String value) {
    // isPasswordError.value = false;
    checkFieldsFilled();
  }

  void checkFieldsFilled() {
    areFieldsFilled.value =
        textControllers.signinEmailController.value.text.isNotEmpty &&
        textControllers.signinpasswordController.value.text.isNotEmpty;
  }

  void checkSignupFields() {
    areSignupFeildstrue.value =
        isSignupPasswordValidRx.value && isSignupEmailValid.value;
    // isfullnameFilled.value;
  }

  void validatePassword() {
    isPasswordError.value = true;
    // const String storedPassword = "123456";

    // if (textControllers.signinpasswordController.value.text != storedPassword) {
    //   isPasswordError.value = true;
    // } else {
    //   Get.to(HomeScreen());
    // }
  }

  void toggleRememberMe() {
    isrememberme.toggle();
  }

  void togglePolicyAgree() {
    ispolicyagree.toggle();
  }

  void toggleLoginPasswordVisibility() {
    isloginpasswordvisible.toggle();
  }

  void toggleSignupPasswordVisibility() {
    issinguppasswordvisible.toggle();
  }

  void toggleCreateNewPasswordVisibility() {
    iscreatenewpasswordvisible.toggle();
  }

  void toggleConfirmNewPasswordVisibility() {
    isconfirmnewpasswordvisible.toggle();
  }

  //  -------------- Login Method ------------------

  Future<UserCredential?> signInMethod(email, password) async {
    UserCredential? userCredential;

    try {
      String fcm = await fcmToken.getToken() ?? "";
      log("Try Called Login");
      showLoadingDialog();

      userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserService.instance.getCurrentUserInformation();

      String? id = UserService.instance.userModel.value.id;

      final uPS = userProfilleSetupSrvices.instance;

      if (id != null) {
        uPS.checkIsUserRegistered(userId: id);
      }

      if (uPS.isUserExist.value) {
        log("User Exist Navigate to Home Screen");
        hideLoadingDialog();
      } else {
        log("User Not Exist Navigate to Complete Profile Onboarding Screen");
        hideLoadingDialog();
      }
      uPS.isUserExist.value
          ? Get.offAll(() => CompleteProfileOnboarding())
          : Get.offAll(() => MyLoadingScreen(), binding: PlanBindings());

      // await userService.getCurrentUserInformation();

      hideLoadingDialog();
      // await UserService.instance.getCurrentUserInformation();
      // final userId = UserService.instance.userModel.value.id!;
      // await userProfilleSetupSrvices.instance.checkIsUserRegistered(
      //   userId: userId,
      // );

      // Get.offAll(() => HomeScreen(), binding: PlanBindings());
    } on FirebaseAuthException catch (e) {
      hideLoadingDialog();
      displayToast(msg: e.toString());
    } catch (e) {
      hideLoadingDialog();
      displayToast(msg: e.toString());
      log('Error in Sign in: $e');
    }

    return userCredential;
  }

  //  -------------- Reset Password ------------------

  Future<void> restPasswordMethod({
    required String email,
    required Widget widget,
  }) async {
    showLoadingDialog();
    try {
      await auth.sendPasswordResetEmail(email: email);
      hideLoadingDialog();

      Get.dialog(widget);
    } on FirebaseAuthException catch (e) {
      hideLoadingDialog();
      displayToast(msg: e.toString());
      log('Error: $e');
    }
  }

  Future<UserCredential?> signUpMethod({
    required String email,
    required String password,
    required String fullName,
  }) async {
    UserCredential? userCredential;

    try {
      String fcm = await fcmToken.getToken() ?? "";
      showLoadingDialog();

      userCredential = await auth.createUserWithEmailAndPassword(
        email: email.trim().toString(),
        password: password.trim().toString(),
      );

      // Add User Data Into Firestore Database

      // await saveUserToFirestore(
      //   model: UserModel(
      //     id: userCredential.user?.uid ?? "",
      //     bio: "",
      //     fullName: fullName.trim().toString(),
      //     email: email.trim().toString(),
      //     fcmToken: fcm,
      //     authType: 'email',
      //     profileImage: profileDefaultImage,
      //     createdAt: DateTime.now(),
      //   ),
      // );

      // await userService.getCurrentUserInformation();

      hideLoadingDialog();
      Get.offAll(() => CompleteProfileOnboarding());

      // Get.off(() => HomeScreen(), binding: PlanBindings());

      displayToast(msg: "Account created successfully");
    } on FirebaseAuthException catch (e) {
      hideLoadingDialog();
      displayToast(msg: "Exception: $e");
      log("Firebase Auth Exception -----------------$e");

      //  errorSnackBar(e);
    } catch (e) {
      hideLoadingDialog();
      log("This Error occurs during creating user account: $e");
    }

    return userCredential;
  }

  //  -------------- Google Authentication ------------------

  Future<void> googleAuth() async {
    try {
      String fcm = await fcmToken.getToken() ?? "";
      showLoadingDialog();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        hideLoadingDialog();
        log('User canceled the Google sign-in process');
        return;
      }

      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      if (googleAuth?.accessToken == null) {
        // isGoogleAuthLoading.value = false;
        hideLoadingDialog();
        log('Google authentication access token is null');
        return;
      }

      // var auth = googleUser.id;

      final credential = await GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // auth =
      // await FirebaseAuth.instance.signInWithCredential(credential);
      await auth.signInWithCredential(credential);
      // as FirebaseAuth;

      log(
        'User signed in: ${auth.currentUser?.displayName}, ${auth.currentUser?.email}',
      );
      log('Google Auth Id: ${auth.currentUser?.uid}');

      // Check if the user data is stored in Firestore or not.

      final doc = await userCollection.doc(auth.currentUser?.uid).get();

      // document is exists
      if (doc.exists) {
        hideLoadingDialog();

        Get.offAll(() => MyLoadingScreen(), binding: PlanBindings());
        log('Document exists, user info not updated');
      }
      // document doesn't exists
      else {
        await saveUserToFirestore(
          model: UserModel(
            id: auth.currentUser?.uid ?? "",
            bio: "",
            fullName: auth.currentUser?.displayName.toString(),
            email: auth.currentUser?.email.toString(),
            fcmToken: fcm,
            authType: 'socail_auth',
            profileImage: profileDefaultImage,
            createdAt: DateTime.now(),
          ),
        );

        hideLoadingDialog();

        Get.offAll(() => HomeScreen(), binding: PlanBindings());

        log("Document doesn't exist");
      }
    } catch (e) {
      hideLoadingDialog();
      log('An error occurred during Google sign-in: $e');
    }
  }

  // -------------- Save User Data to Firestore ------------------

  Future<bool> saveUserToFirestore({required model}) async {
    if (auth.currentUser == null) return false;
    try {
      await userCollection.doc(auth.currentUser!.uid).set(model.toMap());
      return true;
    } catch (e) {
      log("Error while saving user data into firestore ------- $e ");
      return false;
    }
  }

  // -------------- Logout Method ------------------

  Future<void> logOutCurrentUser() async {
    try {
      showLoadingDialog();
      await auth.signOut();
      hideLoadingDialog();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      hideLoadingDialog();
    }
  }
}
