import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:meteo/settings/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        overlayWidget: Center(
          child: SpinKitDualRing(
            color: Colors.purple,
            size: 50.0,
          ),
        ),
        overlayOpacity: 0.5,
        overlayColor: Colors.black,
        useDefaultLoading: false,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              hintColor: Colors.red,
              primarySwatch: Colors.blue,
              primaryColor: Colors.blue,
              fontFamily: 'Nunito',
              appBarTheme: AppBarTheme(color: Colors.blue)),
          darkTheme: ThemeData(
              hintColor: Colors.blue,
              brightness: Brightness.light,
              primarySwatch: Colors.red,
              primaryColor: Colors.red,
              fontFamily: 'Nunito',
              appBarTheme: AppBarTheme(color: Colors.red)),
          routes: routes,
          initialRoute: '/',
        ));
  }
}
