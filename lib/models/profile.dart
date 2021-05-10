import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'entries.dart';

// import 'package:shop_app/database/shared_perf.dart';

class Authentication with ChangeNotifier {
  Auth auth;

  // void authset() async {
  //   String u, t, e, p, n;
  //   bool i;
  //   u = sharedPrefs.uid;
  //   n = sharedPrefs.name;
  //   p = sharedPrefs.phone;
  //   e = sharedPrefs.email;
  //   t = sharedPrefs.token;
  //   i = sharedPrefs.isSeller;
  //   this.auth = new Auth(u, t, e, p, n, i);
  //   notifyListeners();
  //   print(auth.token);
  // }

  Authentication() {
    // authset();
  }

  refresh() {
    notifyListeners();
  }
  // set authUser(Auth a) {
  //   print('construct auth');
  //   this.auth = a;
  //   notifyListeners();
  // }

  Auth get authUser {
    return auth;
  }
}

class Auth {
  final String id;
  final String token;
  final String email;
  final String phone;
  final String name;
  final bool isSeller;

  Auth(this.id, this.token, this.email, this.phone, this.name, this.isSeller);
}

class Profile {
  final String full_name;
  final String email;
  final String phone;
  final int trade_license;
  final String address;
  final String city;
  final String token;
  final String shop_picture;
  final bool is_seller;
  final String subscription_start;
  final String subscription_end;
  final List<Entries> entries;

  Profile({
    this.full_name,
    this.email,
    this.phone,
    this.trade_license,
    this.address,
    this.city,
    this.token,
    this.shop_picture,
    this.is_seller,
    this.subscription_start,
    this.subscription_end,
    this.entries,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'full_name': full_name,
  //     'email': email,
  //     'phone': phone,
  //     'trade_license': trade_license,
  //     'address': address,
  //     'city': city,
  //     'token': token,
  //     'shop_picture': shop_picture,
  //     'is_seller': is_seller,
  //     'subscription_start': subscription_start,
  //     'subscription_end': subscription_end,
  //     'entries': entries.toMap(),
  //   };
  // }

  // factory Profile.fromMap(Map<String, dynamic> map) {
  //   var entries = map['entries'];
  //   print('------------------------------- ${entries.runtimeType.toString()}');
  //   map = map['user'];

  //   return Profile(
  //     full_name: map['full_name'],
  //     email: map['email'],
  //     phone: map['phone'],
  //     trade_license: map['trade_license'],
  //     address: map['address'],
  //     city: map['city'],
  //     token: map['token'],
  //     shop_picture: map['shop_picture'],
  //     is_seller: map['is_seller'],
  //     subscription_start: map['subscription_start'],
  //     subscription_end: map['subscription_end'],
  //     entries: Entries.fromMap(entries),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Profile.fromJson(String source) =>
  //     Profile.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'full_name': full_name,
      'email': email,
      'phone': phone,
      'trade_license': trade_license,
      'address': address,
      'city': city,
      'token': token,
      'shop_picture': shop_picture,
      'is_seller': is_seller,
      'subscription_start': subscription_start,
      'subscription_end': subscription_end,
      'entries': entries?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    var entries = map['entries'];
    map = map['user'];

    return Profile(
      full_name: map['full_name'],
      email: map['email'],
      phone: map['phone'],
      trade_license: map['trade_license'],
      address: map['address'],
      city: map['city'],
      token: map['token'],
      shop_picture: map['shop_picture'],
      is_seller: map['is_seller'],
      subscription_start: map['subscription_start'],
      subscription_end: map['subscription_end'],
      entries: List<Entries>.from(entries?.map((x) => Entries.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));
}
