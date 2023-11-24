// To parse this JSON data, do
//
//     final playListModel = playListModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

PlayListModel playListModelFromJson(String str) =>
    PlayListModel.fromJson(json.decode(str));

String playListModelToJson(PlayListModel data) => json.encode(data.toJson());

class PlayListModel {
  String status;
  dynamic message;
  PlayListData data;

  PlayListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PlayListModel.fromJson(Map<String, dynamic> json) => PlayListModel(
        status: json["status"],
        message: json["message"],
        data: PlayListData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class PlayListData {
  String id;
  String userId;
  String name;
  String followerCount;
  String songCount;
  String fanCount;
  String username;
  String firstname;
  String lastname;
  String shares;
  List<PlayListImage> image;
  String url;
  List<PlayListSong> songs;

  PlayListData({
    required this.id,
    required this.userId,
    required this.name,
    required this.followerCount,
    required this.songCount,
    required this.fanCount,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.shares,
    required this.image,
    required this.url,
    required this.songs,
  });

  factory PlayListData.fromJson(Map<String, dynamic> json) => PlayListData(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        followerCount: json["followerCount"],
        songCount: json["songCount"],
        fanCount: json["fanCount"],
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        shares: json["shares"],
        image: List<PlayListImage>.from(
            json["image"].map((x) => PlayListImage.fromJson(x))),
        url: json["url"],
        songs: List<PlayListSong>.from(
            json["songs"].map((x) => PlayListSong.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "followerCount": followerCount,
        "songCount": songCount,
        "fanCount": fanCount,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "shares": shares,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "url": url,
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
      };
}

class PlayListImage {
  Quality quality;
  String link;

  PlayListImage({
    required this.quality,
    required this.link,
  });

  factory PlayListImage.fromJson(Map<String, dynamic> json) => PlayListImage(
        quality: qualityValues.map[json["quality"]]!,
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "quality": qualityValues.reverse[quality],
        "link": link,
      };
}

enum Quality {
  THE_12_KBPS,
  THE_150_X150,
  THE_160_KBPS,
  THE_320_KBPS,
  THE_48_KBPS,
  THE_500_X500,
  THE_50_X50,
  THE_96_KBPS
}

final qualityValues = EnumValues({
  "12kbps": Quality.THE_12_KBPS,
  "150x150": Quality.THE_150_X150,
  "160kbps": Quality.THE_160_KBPS,
  "320kbps": Quality.THE_320_KBPS,
  "48kbps": Quality.THE_48_KBPS,
  "500x500": Quality.THE_500_X500,
  "50x50": Quality.THE_50_X50,
  "96kbps": Quality.THE_96_KBPS
});

class PlayListSong {
  String id;
  String name;
  PlayListAlbum album;
  String year;
  DateTime releaseDate;
  String duration;
  String label;
  String primaryArtists;
  String primaryArtistsId;
  String featuredArtists;
  String featuredArtistsId;
  int explicitContent;
  String playCount;
  Language language;
  String hasLyrics;
  String url;
  String copyright;
  List<PlayListImage> image;
  List<PlayListImage> downloadUrl;

  PlayListSong({
    required this.id,
    required this.name,
    required this.album,
    required this.year,
    required this.releaseDate,
    required this.duration,
    required this.label,
    required this.primaryArtists,
    required this.primaryArtistsId,
    required this.featuredArtists,
    required this.featuredArtistsId,
    required this.explicitContent,
    required this.playCount,
    required this.language,
    required this.hasLyrics,
    required this.url,
    required this.copyright,
    required this.image,
    required this.downloadUrl,
  });

  factory PlayListSong.fromJson(Map<String, dynamic> json) => PlayListSong(
        id: json["id"],
        name: json["name"],
        album: PlayListAlbum.fromJson(json["album"]),
        year: json["year"],
        releaseDate: DateTime.tryParse(json["releaseDate"]) ?? DateTime(2000),
        duration: json["duration"],
        label: json["label"],
        primaryArtists: json["primaryArtists"],
        primaryArtistsId: json["primaryArtistsId"],
        featuredArtists: json["featuredArtists"],
        featuredArtistsId: json["featuredArtistsId"],
        explicitContent: json["explicitContent"],
        playCount: json["playCount"],
        language: languageValues.map[json["language"]] ?? Language.ENGLISH,
        hasLyrics: json["hasLyrics"],
        url: json["url"],
        copyright: json["copyright"],
        image: List<PlayListImage>.from(
            json["image"].map((x) => PlayListImage.fromJson(x))),
        downloadUrl: List<PlayListImage>.from(
            json["downloadUrl"].map((x) => PlayListImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "album": album.toJson(),
        "year": year,
        "releaseDate":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "duration": duration,
        "label": label,
        "primaryArtists": primaryArtists,
        "primaryArtistsId": primaryArtistsId,
        "featuredArtists": featuredArtists,
        "featuredArtistsId": featuredArtistsId,
        "explicitContent": explicitContent,
        "playCount": playCount,
        "language": languageValues.reverse[language],
        "hasLyrics": hasLyrics,
        "url": url,
        "copyright": copyright,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "downloadUrl": List<dynamic>.from(downloadUrl.map((x) => x.toJson())),
      };
}

class PlayListAlbum {
  String id;
  String name;
  String url;

  PlayListAlbum({
    required this.id,
    required this.name,
    required this.url,
  });

  factory PlayListAlbum.fromJson(Map<String, dynamic> json) => PlayListAlbum(
        id: json["id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}

enum Language { ENGLISH }

final languageValues = EnumValues({"english": Language.ENGLISH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
