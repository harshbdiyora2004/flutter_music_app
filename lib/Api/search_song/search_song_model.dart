// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final songModel = songModelFromJson(jsonString);

import 'dart:convert';

SearchSongModel searchSongModelFromJson(String str) =>
    SearchSongModel.fromJson(json.decode(str));

String searchSongModelToJson(SearchSongModel data) =>
    json.encode(data.toJson());

class SearchSongModel {
  String status;
  dynamic message;
  Data data;

  SearchSongModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SearchSongModel.fromJson(Map<String, dynamic> json) =>
      SearchSongModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int total;
  int start;
  List<Result> results;

  Data({
    required this.total,
    required this.start,
    required this.results,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        start: json["start"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "start": start,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String id;
  String name;
  String type;
  Album album;
  String year;
  dynamic releaseDate;
  String duration;
  String label;
  String primaryArtists;
  String primaryArtistsId;
  String featuredArtists;
  String featuredArtistsId;
  int explicitContent;
  String playCount;
  String language;
  String hasLyrics;
  String url;
  String copyright;
  List<DownloadUrl> image;
  List<DownloadUrl> downloadUrl;

  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        album: Album.fromJson(json["album"]),
        year: json["year"],
        releaseDate: json["releaseDate"],
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
        "liked": false,
        "id": id,
        "name": name,
        "type": type,
        "album": album.toJson(),
        "year": year,
        "releaseDate": releaseDate,
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
