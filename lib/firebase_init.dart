import 'package:ayiolo_safari_advisor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    // Initialize Firebase
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
  ]);
}
