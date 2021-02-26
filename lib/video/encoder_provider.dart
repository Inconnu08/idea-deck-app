import 'dart:io';

import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_ffmpeg/media_information.dart';

class EncodingProvider {
  static final FlutterFFmpeg _encoder = FlutterFFmpeg();
  static final FlutterFFprobe _probe = FlutterFFprobe();
  static final FlutterFFmpegConfig _config = FlutterFFmpegConfig();

  static Future<String> getThumb(videoPath, width, height) async {
    assert(File(videoPath).existsSync());

    final String outPath = '$videoPath.jpg';
    final arguments =
        '-y -i $videoPath -vframes 1 -an -s ${width}x$height -ss 1 $outPath';

    final int rc = await _encoder.execute(arguments);
    assert(rc == 0);
    assert(File(outPath).existsSync());

    return outPath;
  }

  static Future<MediaInformation> getMediaInformation(String path) async {
    return await _probe.getMediaInformation(path);
  }

  static double getAspectRatio(Map<dynamic, dynamic> info) {
    final int width = info['streams'][0]['width'];
    final int height = info['streams'][0]['height'];
    final double aspect = height / width;
    return aspect;
  }

  static int getDuration(Map<dynamic, dynamic> info) {
    return info['duration'];
  }

  static Future<String> encodeHLS(videoPath, outDirPath) async {
    assert(File(videoPath).existsSync());

    final arguments = '-y -i $videoPath ' +
        '-preset ultrafast -g 48 -sc_threshold 0 ' +
        '-map 0:0 -map 0:1 -map 0:0 -map 0:1 ' +
        '-c✌0 libx264 -b✌0 2000k ' +
        '-c✌1 libx264 -b✌1 365k ' +
        '-c:a copy ' +
        '-var_stream_map "v:0,a:0 v:1,a:1" ' +
        '-master_pl_name master.m3u8 ' +
        '-f hls -hls_time 6 -hls_list_size 0 ' +
        '-hls_segment_filename "$outDirPath/%v_fileSequence_%d.ts" ' +
        '$outDirPath/%v_playlistVariant.m3u8';

    final int rc = await _encoder.execute(arguments);
    assert(rc == 0);

    return outDirPath;
  }
}
