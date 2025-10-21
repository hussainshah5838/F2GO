import 'package:f2g/core/bindings/bindings.dart';
import 'package:f2g/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/routes/routes.dart';
import 'config/theme/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

//DO NOT REMOVE Unless you find their usage.

const dummyimage =
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
String profileDefaultImage =
    "https://firebasestorage.googleapis.com/v0/b/friends2go-3df47.firebasestorage.app/o/profile_default_image%2Fprofile_default_image.jpg?alt=media&token=792eff9e-805d-4f30-ab1f-c811fd812574";
String dummyImg =
    'https://images.unsplash.com/photo-1558507652-2d9626c4e67a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'F2G',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      defaultTransition: Transition.fadeIn,
      initialBinding: AuthBindings(),
      initialRoute: AppLinks.splash_screen,
      getPages: AppRoutes.pages,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: const TextScaler.linear(1.0), // Lock font scaling
          ),
          child: child!,
        );
      },
    );
  }
}
