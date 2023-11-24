import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:music_app/Api/search_song/search_song_model.dart';

class SearchSongApi {
  static String? searchSong;
  static String? songApiUrl;

  static Future<SearchSongModel> fetchAllSong() async {
    songApiUrl =
        'https://saavn.me/search/songs?query=$searchSong&page=2&limit=20';
    log(songApiUrl!);
    final response = await http.get(Uri.parse(songApiUrl!));
    if (response.statusCode == 200) {
      return searchSongModelFromJson(response.body);
    } else {
      throw Exception('Some Error');
    }
  }
}
