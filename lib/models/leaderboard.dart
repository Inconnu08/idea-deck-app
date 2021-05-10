import 'dart:convert';

import 'package:flutter/foundation.dart';

class LUser {
  final int id;
  final String full_name;
  final String picture;
  final String user;
  final int entries;

  LUser({
    @required this.id,
    @required this.full_name,
    @required this.picture,
    @required this.user,
    @required this.entries,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': full_name,
      'picture': picture,
      'user': user,
      'entries': entries,
    };
  }

  factory LUser.fromMap(Map<String, dynamic> map) {
    return LUser(
      id: map['id'],
      full_name: map['full_name'],
      picture: map['picture'],
      user: map['user'],
      entries: map['entries'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LUser.fromJson(String source) => LUser.fromMap(json.decode(source));
}

class Leaderboard {
  final List<LUser> leaderboard;
  Leaderboard({
    @required this.leaderboard,
  });

  Map<String, dynamic> toMap() {
    return {
      'leaderboard': leaderboard?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Leaderboard.fromMap(Map<String, dynamic> map) {
    return Leaderboard(
      leaderboard:
          List<LUser>.from(map['leaderboard']?.map((x) => LUser.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Leaderboard.fromJson(String source) =>
      Leaderboard.fromMap(json.decode(source));
}
