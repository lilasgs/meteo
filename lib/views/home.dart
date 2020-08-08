import 'dart:async';
import '../models/globals.dart' as globals;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:location/location.dart';
import 'package:meteo/settings/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime today = DateTime.now();

  // variable Pull to refresh
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(Duration(seconds: 3), (x) => refreshNum);
  ScrollController _scrollController;

  // varibales Location
  final Location location = Location();
  LocationData _location;
  String _error;
  bool loader = false;
  Map data;

  //premiere fonction a s"executer
  @override
  void initState() {
    init();
    super.initState();
    _scrollController = new ScrollController();
  }

  // obtenir la position de l'utilisateur
  Future<void> _getLocation() async {
    setState(() {
      _error = null;
    });
    try {
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _location = _locationResult;
      });
      print(_location.longitude);
      print(_location.latitude);
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }

  // Fonction d'initialisation de notre app
  init() async {
    loader = false;
    await _getLocation();
    getInfosFromAPIweather(_location);
    setLocationMembre(_location);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - 20;

    return Scaffold(
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        child: loader
            ? ListView(
                children: <Widget>[
                  Container(
                    height: height / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.mapMarkerAlt),
                            SizedBox(width: 20),
                            Text(
                              "${data['timezone']}",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          getDateFrenchFormat(today),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    height: height / 4,
                    child: Center(
                      child: Text(
                        "${data['current']['temp']} °",
                        style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w200,
                            color: Colors.black54),
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    height: height / 4,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text('Lundi'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '26 °',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      Icons.ac_unit,
                                      size: 17,
                                    ),
                                    Text(
                                      '150',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text('Lundi'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '26 °',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      Icons.ac_unit,
                                      size: 17,
                                    ),
                                    Text(
                                      '150',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text('Lundi'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '26 °',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      Icons.ac_unit,
                                      size: 17,
                                    ),
                                    Text(
                                      '150',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text('Lundi'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '26 °',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      Icons.ac_unit,
                                      size: 17,
                                    ),
                                    Text(
                                      '150',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text('Lundi'),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  '26 °',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      Icons.ac_unit,
                                      size: 17,
                                    ),
                                    Text(
                                      '150',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                      height: 80,
                      child: Center(
                          child: CircleAvatar(
                        maxRadius: 30,
                        child: IconButton(
                          onPressed: () {
                            print("rafraichir");
                          },
                          icon: Icon(
                            Icons.refresh,
                            size: 30,
                          ),
                        ),
                      )))
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        },
        child: Icon(FontAwesomeIcons.userAltSlash),
      ),
    );
  }

  // Fonction execeuter apres le pull to refresh
  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });

    return completer.future.then<void>((_) {
      init();
    });
  }

  // get Infos API
  void getInfosFromAPIweather(LocationData location) async {
    String url =
        "https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&cnt=5&appid=d9b9978ced0d9233a662c6d107c2f68b";
    print(url);
    try {
      Response response = await Dio().get(url);
      if (response.statusCode == 200) {
        setState(() {
          data = response.data;
          loader = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // Format french date
  getDateFrenchFormat(DateTime date) {
    String day;
    String month;
    String heure;
    String minute;
    String year;

    if (date.day < 10) {
      day = "0${date.day}";
    } else {
      day = date.day.toString();
    }

    if (date.hour < 10) {
      heure = "0${date.hour}";
    } else {
      heure = date.hour.toString();
    }

    if (date.minute < 10) {
      minute = "0${date.minute}";
    } else {
      minute = date.minute.toString();
    }

    if (date.month < 10) {
      month = "0${date.month}";
    } else {
      month = date.month.toString();
    }

    return "$day-$month-${date.year} $heure:$minute";
  }

  setLocationMembre(LocationData location) async {
    FormData formData = new FormData.fromMap({
      "longitude": location.longitude,
      "latitude": location.latitude,
      'id': globals.user['id']
    });
    String url = "${API.url}/membre/location";

    Response response;
    try {
      response = await Dio().post(url, data: formData);
      if (response.statusCode == 200) {}
    } catch (e) {}
  }
}
