import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:music_app/Api/playlist/playlist_model.dart';

class PlayListApi {
  static String? playListApiKey;

  static Future<PlayListModel> featchAllAlbum() async {
    String playListApi = 'https://saavn.me/playlists?id=$playListApiKey';
    log(playListApi);
    final response = await http.get(Uri.parse(playListApi));
    if (response.statusCode == 200) {
      return playListModelFromJson(response.body);
    } else {
      throw Exception('Some Error');
    }
  }
}
