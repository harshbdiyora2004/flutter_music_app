// To parse this JSON data, do
//
//     final songDetailsModel = songDetailsModelFromJson(jsonString);

import 'dart:convert';

SongDetailsModel songDetailsModelFromJson(String str) =>
    SongDetailsModel.fromJson(json.decode(str));

String songDetailsModelToJson(SongDetailsModel data) =>
    json.encode(data.toJson());

class SongDetailsModel {
  String status;
  dynamic message;
  List<Datum> data;

  SongDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SongDetailsModel.fromJson(Map<String, dynamic> json) =>
      SongDetailsModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String name;
  String type;
  Album album;
  String year;
  DateTime releaseDate;
  String duration;
  String label;
  String primaryArtists;
  String primaryArtistsId;
  String featuredArtists;
  String featuredArtistsId;
  int explicitContent;
  int playCount;
  String language;
  String hasLyrics;
  String url;
  String copyright;
  List<DownloadUrl> image;
  List<DownloadUrl> downloadUrl;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        album: Album.fromJson(json["album"]),
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
        language: json["language"],
        hasLyrics: json["hasLyrics"],
        url: json["url"],
        copyright: json["copyright"],
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
        "label": label,
        "primaryArtists": primaryArtists,
        "primaryArtistsId": primaryArtistsId,
        "featuredArtists": featuredArtists,
        "featuredArtistsId": featuredArtistsId,
        "explicitContent": explicitContent,
        "playCount": playCount,
        "language": language,
        "hasLyrics": hasLyrics,
        "url": url,
        "copyright": copyright,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "downloadUrl": List<dynamic>.from(downloadUrl.map((x) => x.toJson())),
      };
}

class Album {
  String id;
  String name;
  String url;

  Album({
    required this.id,
    required this.name,
    required this.url,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
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

class DownloadUrl {
  String quality;
  String link;

  DownloadUrl({
    required this.quality,
    required this.link,
  });

  factory DownloadUrl.fromJson(Map<String, dynamic> json) => DownloadUrl(
        quality: json["quality"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "quality": quality,
        "link": link,
      };
}
