import 'package:flutter/material.dart';
import 'package:meteo/settings/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        hintColor: Colors.red,
        primarySwatch: Colors.purple,
        fontFamily: 'Nunito',
      ),
      darkTheme: ThemeData(
        hintColor: Colors.blue,
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        fontFamily: 'Nunito',
      ),
      routes: routes,
      initialRoute: '/',
    );
  }
}
