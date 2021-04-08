import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:idea_deck/database/shared_perf.dart';
import 'package:idea_deck/network/connectivity.dart';

import 'http.dart';

login(String phone, String password) async {
  var response = await post('${baseURL}signin/',
      body: jsonEncode({"phone": phone, "password": password}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

  return response;
}


Future<dynamic> fetchHome() async {
  print("fetchHome()");
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();

  bool isConnected = await connectionStatus.checkConnection();

  if (!isConnected) {
    print("no internet status");
    return Future.error("No internet connection");
  }

  try {
    final response = await get('${baseURL}category/', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sharedPrefs.token}',
    });
    if (response.statusCode == 200) {
      print(json.decode(response.body)['charges']);
      return null;
      // Home.fromJson(response.body);
    } else if (response.statusCode == 402) {
      return null;
      // Home.onlyStatus(402, json.decode(response.body)['has_referral']);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body);
      throw Exception(
          'Opps, something went wrong!\nMake sure you have you have the latest app version.');
    }
  } on SocketException catch (e) {
    print(e);
    return Future.error("No internet connection");
  } on Exception catch (e) {
    print(e);
    return Future.error(
        "Opps something went wrong!\nMake sure you have you have the latest app version.");
  }
}