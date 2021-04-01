import 'package:flutter/material.dart';
import 'package:issues_tracker_app/views/home_page/home_page.dart';
import 'package:issues_tracker_app/views/login/login_page.dart';
import 'package:issues_tracker_app/views/register/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '',
      routes: {
        '' : (context) => LoginPage(),
        'homePage' : (context) => HomePage(),
        'registerPage' : (context) => RegisterPage(),
      },
    );
  }
}
