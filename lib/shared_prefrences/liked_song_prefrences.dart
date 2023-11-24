import 'dart:convert';
import 'dart:developer';

import 'package:music_app/Api/song_api/song_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavMusic {
  static const String favoriteKey = 'favorite';

  static Future<List<Datum>> getFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? favouriteJson = prefs.getString(favoriteKey);
    if (favouriteJson == null) {
      return [];
    }
    final List<dynamic> favouriteData = json.decode(favouriteJson);
    List<Datum> favourite =
        favouriteData.map((data) => Datum.fromJson(data)).toList();
    return favourite;
  }

  static Future<void> saveFavourite(List<Datum> favourite) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> favData =
        favourite.map((e) => e.toJson()).toList();

    final String favJson = json.encode(favData);
    await preferences.setString(favoriteKey, favJson);
  }

  static Future<void> addToFavourite(Datum data) async {
    List<Datum> favourite = await getFavourite();
    favourite.add(data);
    log(favourite.length.toString());
    await saveFavourite(favourite);
  }

  static Future<void> removeFromFavorites(
    String songId,
  ) async {
    List<Datum> favorites = await getFavourite();
    favorites.removeWhere((song) => song.id == songId);
    await saveFavourite(favorites);
  }
}
