import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meteo/settings/api.dart';
import 'package:meteo/settings/assets.dart';
import 'package:meteo/views/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/globals.dart' as globals;
import 'package:loader_overlay/loader_overlay.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtl = TextEditingController();
  final passwordCtl = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 100, bottom: 25),
                  child: Center(
                    child: Text(
                      'Connexion',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                    ),
                  )),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: emailCtl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.black),
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    } else
                      return null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  obscureText: passwordVisible ? true : false,
                  controller: passwordCtl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.black),
                    labelText: 'Mot de passe',
                  ),
                  validator: (value) {
                    if (value.isEmpty || value.trim().length < 5) {
                      return 'Veuillez entrer votre mot de passe';
                    } else
                      return null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34),
                  ),
                  onPressed: _saveForm,
                  padding: EdgeInsets.all(15),
                  color: Colors.blue,
                  child: Text('Se Connecter',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  padding: EdgeInsets.all(15),
                  color: Colors.blue,
                  child: Text("S'inscrire",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w300)),
                ),
              ),
            ],
          )),
    );
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    context.showLoaderOverlay();

    FormData formData = new FormData.fromMap(
        {"password": passwordCtl.text, "email": emailCtl.text});
    String url = "${API.url}/membre/login";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Response response;
    try {
      response = await Dio().post(url, data: formData);
      if (response.statusCode == 200) {
        if (response.data['statut']) {
          prefs.setInt('idMembre', response.data['user']['id']);
          globals.user = response.data['user'];
          context.hideLoaderOverlay();
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
        } else {
          context.hideLoaderOverlay();
          showAlert(context, "Alerte", response.data['message'], true,
              response.data['statut']);
        }
      } else {
        context.hideLoaderOverlay();
        showAlert(context, "Alerte", response.data['message'], true,
            response.data['statut']);
      }
    } catch (e) {
      context.hideLoaderOverlay();
      showAlert(context, "Alerte", response.data['message'], true,
          response.data['statut']);
    }
  }
}
