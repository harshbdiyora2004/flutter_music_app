import 'dart:developer';

import 'package:music_app/Api/song_api/song_model.dart';
import 'package:http/http.dart' as http;

class SongApi {
  static String? songId;

  static Future<SongDetailsModel> feachAllData() async {
    String songApi = 'https://saavn.me/songs?id=$songId';
    log('=======$songApi============');
    final response = await http.get(Uri.parse(songApi));
    if (response.statusCode == 200) {
      return songDetailsModelFromJson(response.body);
    } else {
      throw Exception('Some Error');
    }
  }
}
