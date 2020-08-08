import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

Dio dio = new Dio(BaseOptions(connectTimeout: 30000, receiveTimeout: 30000));

class API {
  static String url = "http://192.168.43.243:8000/api";
}
