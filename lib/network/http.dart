import 'package:flutter/foundation.dart';

// const domain = 'http://www.ideadeck.com';
const testdomain = 'http://10.0.2.2:8000';
// const testdomain = 'http://127.0.0.1:8000';
const domain = kDebugMode ? 'http://10.0.2.2:8000' : 'http://www.ideadeck.com';
const baseURL = "$domain/api/v1/";
const mediaBaseUrl = '$domain/media/';

getVideoUrl(String id) => id.replaceAll('.mkv', '.m3u8');
