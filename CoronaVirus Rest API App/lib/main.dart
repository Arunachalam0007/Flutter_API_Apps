//Packages
import 'package:flutter/material.dart';

//Pages
import '../pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coronavirus Tracker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF101010),
        cardColor: const Color(0xFF222222),
      ),
      home: DashboardPage(),
    );
  }
}
