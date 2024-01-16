import 'package:ayiolo_safari_advisor/navigation/bottom_navigation.dart';
import 'package:ayiolo_safari_advisor/routes.dart';
import 'package:ayiolo_safari_advisor/firebase_init.dart';
import 'package:flutter/material.dart';

void main() async {
  await initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ayiolo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home_page',
      home: const BottomNavigation(),
      routes: AppRoutes.routes,
    );
  }
}
