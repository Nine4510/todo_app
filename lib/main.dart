import 'package:flutter/material.dart';
import 'package:todo_app/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //merupakan widget dasar dari aplikasi.
    //pengaturan tema dan route navigasi dapat dilakukan disini.
    return const MaterialApp(
      //berfungsi untuk menghilangkan banner debug di ujung aplikasi.
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
