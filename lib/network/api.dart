import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:idea_deck/database/shared_perf.dart';
import 'package:idea_deck/models/leaderboard.dart';
import 'package:idea_deck/models/profile.dart';
import 'package:idea_deck/models/questions.dart';
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

Future<Profile> fetchProfile() async {
  print("fetchProfile()");
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();

  bool isConnected = await connectionStatus.checkConnection();

  if (!isConnected) {
    print("no internet status");
    return Future.error("No internet connection");
  }

  try {
    final response = await get('${baseURL}profile/', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sharedPrefs.token}',
    });
    if (response.statusCode == 200) {
      return Profile.fromJson(response.body);
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

Future<Leaderboard> fetchLeaderBoard() async {
  print(" fetchLeaderBoard())");
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();

  bool isConnected = await connectionStatus.checkConnection();

  if (!isConnected) {
    print("no internet status");
    return Future.error("No internet connection");
  }

  try {
    final response = await get('${baseURL}leaderboard/', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sharedPrefs.token}',
    });
    if (response.statusCode == 200) {
      return Leaderboard.fromJson(response.body);
    } else if (response.statusCode == 402) {
      return null;
    } else {
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

Future<Questionnaire> fetchQuestionnaire(int id) async {
  print(" fetchquestionnaire())");
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();

  bool isConnected = await connectionStatus.checkConnection();

  if (!isConnected) {
    print("no internet status");
    return Future.error("No internet connection");
  }

  try {
    final response = await get('${baseURL}questions/$id', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sharedPrefs.token}',
    });
    if (response.statusCode == 200) {
      print('200');
      print(response.body);
      return Questionnaire.fromJson(response.body);
    } else if (response.statusCode == 302) {
      print("ANSWERED!");
      return null;
    } else {
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

Future<bool> postAnswers(int id, String data) async {
  print(" postAnswers())");
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();

  bool isConnected = await connectionStatus.checkConnection();

  if (!isConnected) {
    print("no internet status");
    return Future.error("No internet connection");
  }

  try {
    final response =
        await post('${baseURL}questions/$id', body: data, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sharedPrefs.token}',
    });
    if (response.statusCode == 201) {
      print('201');
      return true;
    } else if (response.statusCode == 302) {
      print("ANSWERED!");
      return true;
    } else {
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
