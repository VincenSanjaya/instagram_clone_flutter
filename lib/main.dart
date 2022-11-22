import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      title: 'Instagram Clone',
      home: Scaffold(
        body: Center(
          child: Text("Lets build Instagram Clone"),
        )
      ),
    );
  }
}
