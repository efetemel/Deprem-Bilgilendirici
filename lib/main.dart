import 'package:deprembilgilendirici/controllers/MainController.dart';
import 'package:deprembilgilendirici/views/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  runApp(const MyApp());

  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MainController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Deprem Bilgilendirici',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true
      ),
      home: const HomeView(),
    );
  }
}
