import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:music_app/Api/album/album_model.dart';

class AlbumApi {
  static String? albumApiKey;

  static Future<AlbumModel> featchAllAlbum() async {
    String albumApi = 'https://saavn.me/albums?id=$albumApiKey';
    log(albumApi);
    final response = await http.get(Uri.parse(albumApi));
    if (response.statusCode == 200) {
      return albumModelFromJson(response.body);
    } else {
      throw Exception('Some Error');
    }
  }
}
