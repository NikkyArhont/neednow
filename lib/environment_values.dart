import 'dart:convert';
import 'package:flutter/services.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFDevEnvironmentValues {
  static const String currentEnvironment = 'Production';
  static const String environmentValuesPath =
      'assets/environment_values/environment.json';

  static final FFDevEnvironmentValues _instance =
      FFDevEnvironmentValues._internal();

  factory FFDevEnvironmentValues() {
    return _instance;
  }

  FFDevEnvironmentValues._internal();

  Future<void> initialize() async {
    try {
      final String response =
          await rootBundle.loadString(environmentValuesPath);
      final data = await json.decode(response);
      _QPAYBASEURL = data['QPAYBASEURL'];
      _CLIENTID = data['CLIENTID'];
      _CLIENTSECRET = data['CLIENTSECRET'];
    } catch (e) {
      print('Error loading environment values: $e');
    }
  }

  String _QPAYBASEURL = '';
  String get QPAYBASEURL => _QPAYBASEURL;

  String _CLIENTID = '';
  String get CLIENTID => _CLIENTID;

  String _CLIENTSECRET = '';
  String get CLIENTSECRET => _CLIENTSECRET;
}
