import 'dart:convert';

import 'package:flutter/foundation.dart';

class Entries {
  final int video;
  final int type;
  final String video_thumbnail;
  final String video_title;

  String video_type() {
    return (this.type == 0) ? 'Questionnaire' : 'Survey';
  }

  Entries({
    @required this.video,
    @required this.type,
    @required this.video_thumbnail,
    @required this.video_title,
  });

  Map<String, dynamic> toMap() {
    return {
      'video': video,
      'type': type,
      'video_thumbnail': video_thumbnail,
      'video_title': video_title,
    };
  }

  factory Entries.fromMap(Map<String, dynamic> map) {
    return Entries(
      video: map['video'],
      type: map['type'],
      video_thumbnail: map['video_thumbnail'],
      video_title: map['video_title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Entries.fromJson(String source) =>
      Entries.fromMap(json.decode(source));
}
