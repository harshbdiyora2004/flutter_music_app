import 'dart:convert';

import 'package:music_app/Api/song_api/song_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentlyPlayed {
  static const String recentlyPlayedKey = 'recentlyPlayed';

  static Future<List<Datum>> getRecentlyPlayed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? recentlyJson = prefs.getString(recentlyPlayedKey);
    if (recentlyJson == null) {
      return [];
    }
    final List<dynamic> recentlyPlayedData = json.decode(recentlyJson);
    List<Datum> recentlyPlayed =
        recentlyPlayedData.map((e) => Datum.fromJson(e)).toList();
    return recentlyPlayed;
  }

  static Future<void> saveToRecent(List<Datum> recentlyPlayed) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> recentData =
        recentlyPlayed.map((e) => e.toJson()).toList();

    final String recentJson = json.encode(recentData);
    await sharedPreferences.setString(recentlyPlayedKey, recentJson);
  }

  static Future<void> addToRecent(Datum result) async {
    List<Datum> recentlyPlayed = await getRecentlyPlayed();

    bool songExist = recentlyPlayed.any((element) => element.id == result.id);
    if (!songExist) {
      recentlyPlayed.add(result);
      await saveToRecent(recentlyPlayed);
    }
  }

  static Future<void> removeFromFavorites(
    String songId,
  ) async {
    List<Datum> recentlyPlayed = await getRecentlyPlayed();
    recentlyPlayed.removeWhere((song) => song.id == songId);
    await saveToRecent(recentlyPlayed);
  }
}
