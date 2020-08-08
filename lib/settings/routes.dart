import 'package:flutter/material.dart';
import 'package:meteo/views/home.dart';
import 'package:meteo/views/login.dart';
import 'package:meteo/views/register.dart';
import 'package:meteo/views/splashcreen.dart';

final routes = {
  '/': (BuildContext context) => SplashScreenPage(),
  '/home': (BuildContext context) => HomePage(),
  '/login': (BuildContext context) => LoginPage(),
  '/register': (BuildContext context) => RegisterPage(),
};
