import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meteo/settings/api.dart';
import 'package:meteo/settings/assets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/globals.dart' as globals;

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      init();
    });
    super.initState();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('idMembre'); // Recupere l'id du membre

    if (id != null) {
      //Si il existe
      getInfosMembre(id);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }
  }

  // retourne les infos du membre
  void getInfosMembre(int idMembre) async {
    String url = "${API.url}/membre/infos/$idMembre";
    Response response;
    try {
      response = await Dio().get(url);
      if (response.statusCode == 200) {
        globals.user = response.data['user'];

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      } else {
        showAlert(context, "Alerte", response.data['message'], true,
            response.data['statut']);
      }
    } catch (e) {
      showAlert(context, "Alerte", response.data['message'], true,
          response.data['statut']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: Image.asset("assets/images/splash.jpg").image,
                    fit: BoxFit.cover)),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text("Chargement",
                            style:
                                TextStyle(fontSize: 17, color: Colors.purple))
                      ],
                    ))
              ],
            ))),
      ],
    ));
  }
}
