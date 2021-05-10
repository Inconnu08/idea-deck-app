import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class Advertisement {
  final int id;
  final String title;
  final String description;
  final String offer_ends;
  final String created;
  final String thumbnail;
  final String video;
  final String brand;
  final int participates;
  final String winner;
  final int status;
  final bool available;

  Advertisement(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.offer_ends,
      @required this.created,
      @required this.thumbnail,
      @required this.video,
      @required this.brand,
      @required this.participates,
      @required this.winner,
      @required this.status,
      @required this.available});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'offer_ends': offer_ends,
      'created': created,
      'thumbnail': thumbnail,
      'brand': brand,
      'participates': participates,
      'winner': winner,
    };
  }

  factory Advertisement.fromMap(Map<String, dynamic> map) {
    return Advertisement(
      id: map['id'] as int,
      title: map['title'],
      description: map['description'],
      offer_ends: map['offer_ends'],
      created: map['created'],
      thumbnail: map['thumbnail'],
      video: map['video'],
      brand: map['brand'],
      participates: map['participates'] as int,
      winner: map['winner'],
      status: map['status'] as int,
      available: map['available'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Advertisement.fromJson(String source) =>
      Advertisement.fromMap(json.decode(source));
}

class PaginatedProducts {
  int statusCode;
  int count;
  String next;
  String previous;
  List<Advertisement> results;
  int nItems;

  String errorMessage;

  PaginatedProducts(
      {this.statusCode, this.count, this.next, this.previous, this.results});

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory PaginatedProducts.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PaginatedProducts(
      count: map['count'] as int,
      next: map['next'],
      previous: map['previous'],
      results: List<Advertisement>.from(
          map['results']?.map((x) => Advertisement.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginatedProducts.fromJson(String source) =>
      PaginatedProducts.fromMap(json.decode(source));

  PaginatedProducts.fromResponse(Response response) {
    this.statusCode = response.statusCode;
    Map<String, dynamic> map = json.decode(response.body);
    count = map['count'] as int;
    next = map['next'];
    previous = map['previous'];
    results = List<Advertisement>.from(
        map['results']?.map((x) => Advertisement.fromMap(x)));
    nItems = results.length;
  }

  PaginatedProducts.withError(
      {this.errorMessage, this.count, this.next, this.previous, this.results});
}
