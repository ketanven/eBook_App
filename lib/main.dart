import 'package:ebook_app/Pages/SplacePage/SplacePage.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:ebook_app/pages/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E BOOK',
      // home: HomeScreen(),
      home: SplacePage(),
      // color: Theme.of(context).colorScheme.primary,
    );
  }
}
