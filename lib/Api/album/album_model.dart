// To parse this JSON data, do
//
//     final albumModel = albumModelFromJson(jsonString);

import 'dart:convert';

AlbumModel albumModelFromJson(String str) =>
    AlbumModel.fromJson(json.decode(str));

String albumModelToJson(AlbumModel data) => json.encode(data.toJson());

class AlbumModel {
  String status;
  dynamic message;
  AlbumModelData data;

  AlbumModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) => AlbumModel(
        status: json["status"],
        message: json["message"],
        data: AlbumModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class AlbumModelData {
  String id;
  Name name;
  String year;
  DateTime releaseDate;
  String songCount;
  String url;
  String primaryArtistsId;
  String primaryArtists;
  List<dynamic> featuredArtists;
  List<dynamic> artists;
  List<DownloadUrl> image;
  List<Song> songs;

  AlbumModelData({
    required this.id,
    required this.name,
    required this.year,
    required this.releaseDate,
    required this.songCount,
    required this.url,
    required this.primaryArtistsId,
    required this.primaryArtists,
    required this.featuredArtists,
    required this.artists,
    required this.image,
    required this.songs,
  });

  factory AlbumModelData.fromJson(Map<String, dynamic> json) => AlbumModelData(
        id: json["id"],
        name: Name.NIGHT_VISIONS,
        year: json["year"],
        releaseDate: DateTime.parse(json["releaseDate"]),
        songCount: json["songCount"],
        url: json["url"],
        primaryArtistsId: json["primaryArtistsId"].toString(),
        primaryArtists: json["primaryArtists"],
        featuredArtists:
            List<dynamic>.from(json["featuredArtists"].map((x) => x)),
        artists: List<dynamic>.from(json["artists"].map((x) => x)),
        image: List<DownloadUrl>.from(
            json["image"].map((x) => DownloadUrl.fromJson(x))),
        songs: List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "year": year,
        "releaseDate":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "songCount": songCount,
        "url": url,
        "primaryArtistsId": primaryArtistsId,
        "primaryArtists": primaryArtistsValues.reverse[primaryArtists],
        "featuredArtists": List<dynamic>.from(featuredArtists.map((x) => x)),
        "artists": List<dynamic>.from(artists.map((x) => x)),
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
      };
}

class DownloadUrl {
  Quality quality;
  String link;

  DownloadUrl({
    required this.quality,
    required this.link,
  });

  factory DownloadUrl.fromJson(Map<String, dynamic> json) => DownloadUrl(
        quality: qualityValues.map[json["quality"]]!,
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "quality": qualityValues.reverse[quality],
        "link": link,
      };
}

enum Quality {
  // ignore: constant_identifier_names
  THE_12_KBPS,
  // ignore: constant_identifier_names
  THE_150_X150,
  // ignore: constant_identifier_names
  THE_160_KBPS,
  // ignore: constant_identifier_names
  THE_320_KBPS,
  // ignore: constant_identifier_names
  THE_48_KBPS,
  // ignore: constant_identifier_names
  THE_500_X500,
  // ignore: constant_identifier_names
  THE_50_X50,
  // ignore: constant_identifier_names
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

// ignore: constant_identifier_names
enum Name { NIGHT_VISIONS }

final nameValues = EnumValues({"Night Visions": Name.NIGHT_VISIONS});

// ignore: constant_identifier_names
enum PrimaryArtists { IMAGINE_DRAGONS }

final primaryArtistsValues =
    EnumValues({"Imagine Dragons": PrimaryArtists.IMAGINE_DRAGONS});

class Song {
  String id;
  String name;
  String type;
  AlbumModelAlbum album;
  String year;
  DateTime releaseDate;
  String duration;
  Label label;
  String primaryArtists;
  String primaryArtistsId;
  String featuredArtists;
  String featuredArtistsId;
  int explicitContent;
  String playCount;
  Language language;
  String hasLyrics;
  String url;
  Copyright copyright;
  List<DownloadUrl> image;
  List<DownloadUrl> downloadUrl;

  Song({
    required this.id,
    required this.name,
    required this.type,
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

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        album: AlbumModelAlbum.fromJson(json["album"]),
        year: json["year"],
        releaseDate: DateTime.parse(json["releaseDate"]),
        duration: json["duration"],
        label: Label.KID_INA_KORNER_INTERSCOPE,
        primaryArtists: json["primaryArtists"],
        primaryArtistsId: json["primaryArtistsId"],
        featuredArtists: json["featuredArtists"],
        featuredArtistsId: json["featuredArtistsId"],
        explicitContent: json["explicitContent"],
        playCount: json["playCount"],
        language: Language.ENGLISH,
        hasLyrics: json["hasLyrics"],
        url: json["url"],
        copyright: Copyright.THE_2012_KI_DINA_KORNER_INTERSCOPE_RECORDS,
        image: List<DownloadUrl>.from(
            json["image"].map((x) => DownloadUrl.fromJson(x))),
        downloadUrl: List<DownloadUrl>.from(
            json["downloadUrl"].map((x) => DownloadUrl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "album": album.toJson(),
        "year": year,
        "releaseDate":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "duration": duration,
        "label": labelValues.reverse[label],
        "primaryArtists": primaryArtistsValues.reverse[primaryArtists],
        "primaryArtistsId": primaryArtistsId,
        "featuredArtists": featuredArtists,
        "featuredArtistsId": featuredArtistsId,
        "explicitContent": explicitContent,
        "playCount": playCount,
        "language": languageValues.reverse[language],
        "hasLyrics": hasLyrics,
        "url": url,
        "copyright": copyrightValues.reverse[copyright],
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "downloadUrl": List<dynamic>.from(downloadUrl.map((x) => x.toJson())),
      };
}

class AlbumModelAlbum {
  String id;
  Name name;
  String url;

  AlbumModelAlbum({
    required this.id,
    required this.name,
    required this.url,
  });

  factory AlbumModelAlbum.fromJson(Map<String, dynamic> json) =>
      AlbumModelAlbum(
        id: json["id"],
        name: Name.NIGHT_VISIONS,
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "url": url,
      };
}

// ignore: constant_identifier_names
enum Copyright { THE_2012_KI_DINA_KORNER_INTERSCOPE_RECORDS }

final copyrightValues = EnumValues({
  "℗ 2012 KIDinaKORNER/Interscope Records":
      Copyright.THE_2012_KI_DINA_KORNER_INTERSCOPE_RECORDS
});

// ignore: constant_identifier_names
enum Label { KID_INA_KORNER_INTERSCOPE }

final labelValues = EnumValues(
    {"Kid Ina Korner / Interscope": Label.KID_INA_KORNER_INTERSCOPE});

// ignore: constant_identifier_names
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
