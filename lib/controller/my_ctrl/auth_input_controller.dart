import 'dart:developer';
import 'package:f2g/constants/firebase_const.dart';
import 'package:f2g/controller/loading_animation.dart';
import 'package:f2g/main.dart';
import 'package:f2g/model/my_model/user_model.dart';
import 'package:f2g/view/screens/Home/home_screen.dart';
import 'package:f2g/view/screens/auth/login/login.dart';
import 'package:f2g/view/screens/textcontrollers/textcontrollers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthInputController extends GetxController {
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
  var isfullnameFilled = false.obs;
  var isPasswordError = false.obs;
  var isSignupPasswordValidRx = false.obs;

  var areSignupFeildstrue = false.obs;

  final TextControllers textControllers = Get.find<TextControllers>();

  void isFullNameValid() {
    isfullnameFilled.value =
        textControllers.signupFullNameController.value.text.trim().isNotEmpty;
    checkSignupFields();
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
        isSignupPasswordValidRx.value &&
        isSignupEmailValid.value &&
        isfullnameFilled.value;
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

      // await userService.getCurrentUserInformation();

      hideLoadingDialog();
      Get.offAll(() => HomeScreen());
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

      await saveUserToFirestore(
        model: UserModel(
          bio: "",
          fullName: fullName.trim().toString(),
          email: email.trim().toString(),
          fcmToken: fcm,
          authType: 'email',
          profileImage: profileDefaultImage,
          createdAt: DateTime.now(),
        ),
      );

      // await userService.getCurrentUserInformation();

      hideLoadingDialog();

      Get.off(() => HomeScreen());

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

  // Future<void> googleAuth({String? userType}) async {
  //   try {
  //     showLoadingDialog();
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ['email', 'profile']).signIn();

  //         // await GoogleSignIn(scopes: ['email', 'profile']).signIn();

  //     if (googleUser == null) {
  //       hideLoadingDialog();
  //       log('User canceled the Google sign-in process');
  //       return;
  //     }

  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser.authentication;

  //     if (googleAuth?.idToken == null) {
  //       // isGoogleAuthLoading.value = false;
  //       hideLoadingDialog();
  //       log('Google authentication id token is null');
  //       return;
  //     }

  //     // var auth = googleUser.id;

  //     final credential = await GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.idToken,
  //       idToken: googleAuth?.idToken,
  //     );

  //     // auth =
  //     // await FirebaseAuth.instance.signInWithCredential(credential);
  //     await auth.signInWithCredential(credential);

  //     log(
  //       'User signed in: ${auth.currentUser?.displayName}, ${auth.currentUser?.email}',
  //     );
  //     log('Google Auth Id: ${auth.currentUser?.uid}');

  //     //  TODO: IsEmailExist

  //     bool isEmailExist = await isUserExistWithEmail(
  //       email: auth.currentUser!.email.toString(),
  //     );

  //     if (isEmailExist) {
  //       await socialLoginMethod(email: auth.currentUser!.email.toString());
  //       hideLoadingDialog();

  //       log("if: Is email exist: $isEmailExist");
  //     } else {
  //       await socialSignUpMethod(
  //         fullName: '${auth.currentUser?.displayName}',
  //         email: '${auth.currentUser?.email}',
  //         userType: userType!,
  //         authId: auth.currentUser!.uid,
  //       );

  //       await UserTypeService.instance.initUserType();
  //       if (UserTypeService.instance.userType == UserType.client.name) {
  //         log('Go To Client Nav Bar');
  //         Get.to(() => ClientNavBar());
  //       } else {
  //         log('Go To Therapist Nav Bar');
  //         Get.to(() => TherapistNavBar());
  //       }

  //       hideLoadingDialog();

  //       log("else: Is email exist: $isEmailExist");
  //     }

  //     hideLoadingDialog();
  //   } catch (e) {
  //     hideLoadingDialog();
  //     log('An error occurred during Google sign-in: $e');
  //   }
  // }

  // -------------- Save User Data to Firestore ------------------

  Future<void> saveUserToFirestore({required model}) async {
    if (auth.currentUser == null) return;
    try {
      await userCollection.doc(auth.currentUser!.uid).set(model.toMap());
    } catch (e) {
      log("Error while saving user data into firestore ------- $e ");
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
