import 'package:flutter/material.dart';
import 'package:test_projects/page/loginpage.dart';

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
      home: LoginPage(),
      // title: 'My first app',
      // theme: ThemeData(fontFamily: 'Raleway'),
      // home: Scaffold(
      //   appBar: AppBar(
      //     backgroundColor: Colors.black,
      //     centerTitle: true,
      //     title: const Text(
      //       'Flutter Basic',
      //       style: TextStyle(color: Colors.teal, fontSize: 50),
      //     ),
      //   ),
      //   body: const Center(
      //     child: Text(
      //       'Hello, Flutter',
      //       style: TextStyle(color: Colors.lightBlue, fontSize: 20),
      //     ),
      //   ),
      //   backgroundColor: Colors.white54,
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: () => {},
      //     backgroundColor: Colors.blueGrey,
      //     child: const Icon(
      //       Icons.thumb_up_off_alt_sharp,
      //       color: Colors.cyanAccent,
      //     ),
      //   ),
      // ),
    );
  }
}
