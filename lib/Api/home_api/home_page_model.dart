// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

HomePageModel homePageModelFromJson(String str) =>
    HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
  String status;
  dynamic message;
  HomePageData data;

  HomePageModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
        status: json["status"],
        message: json["message"],
        data: HomePageData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class HomePageData {
  List<AlbumElement> albums;
  List<Playlist> playlists;
  List<Chart> charts;
  Trending trending;

  HomePageData({
    required this.albums,
    required this.playlists,
    required this.charts,
    required this.trending,
  });

  factory HomePageData.fromJson(Map<String, dynamic> json) => HomePageData(
        albums: List<AlbumElement>.from(
            json["albums"].map((x) => AlbumElement.fromJson(x))),
        playlists: List<Playlist>.from(
            json["playlists"].map((x) => Playlist.fromJson(x))),
        charts: List<Chart>.from(json["charts"].map((x) => Chart.fromJson(x))),
        trending: Trending.fromJson(json["trending"]),
      );

  Map<String, dynamic> toJson() => {
        "albums": List<dynamic>.from(albums.map((x) => x.toJson())),
        "playlists": List<dynamic>.from(playlists.map((x) => x.toJson())),
        "charts": List<dynamic>.from(charts.map((x) => x.toJson())),
        "trending": trending.toJson(),
      };
}

class AlbumElement {
  String id;
  String name;
  String year;
  AlbumType type;
  String playCount;
  Language language;
  String explicitContent;
  String? songCount;
  String url;
  List<Artist> primaryArtists;
  List<dynamic> featuredArtists;
  List<Artist>? artists;
  List<ImageElement> image;
  List<dynamic>? songs;
  DateTime? releaseDate;
  AlbumAlbum? album;
  String? duration;
  String? label;

  AlbumElement({
    required this.id,
    required this.name,
    required this.year,
    required this.type,
    required this.playCount,
    required this.language,
    required this.explicitContent,
    this.songCount,
    required this.url,
    required this.primaryArtists,
    required this.featuredArtists,
    this.artists,
    required this.image,
    this.songs,
    this.releaseDate,
    this.album,
    this.duration,
    this.label,
  });

  factory AlbumElement.fromJson(Map<String, dynamic> json) => AlbumElement(
        id: json["id"],
        name: json["name"],
        year: json["year"],
        type: albumTypeValues.map[json["type"]]!,
        playCount: json["playCount"],
        language: languageValues.map[json["language"]]!,
        explicitContent: json["explicitContent"],
        songCount: json["songCount"],
        url: json["url"],
        primaryArtists: List<Artist>.from(
            json["primaryArtists"].map((x) => Artist.fromJson(x))),
        featuredArtists:
            List<dynamic>.from(json["featuredArtists"].map((x) => x)),
        artists: json["artists"] == null
            ? []
            : List<Artist>.from(
                json["artists"]!.map((x) => Artist.fromJson(x))),
        image: List<ImageElement>.from(
            json["image"].map((x) => ImageElement.fromJson(x))),
        songs: json["songs"] == null
            ? []
            : List<dynamic>.from(json["songs"]!.map((x) => x)),
        releaseDate: json["releaseDate"] == null
            ? null
            : DateTime.parse(json["releaseDate"]),
        album:
            json["album"] == null ? null : AlbumAlbum.fromJson(json["album"]),
        duration: json["duration"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "year": year,
        "type": albumTypeValues.reverse[type],
        "playCount": playCount,
        "language": languageValues.reverse[language],
        "explicitContent": explicitContent,
        "songCount": songCount,
        "url": url,
        "primaryArtists":
            List<dynamic>.from(primaryArtists.map((x) => x.toJson())),
        "featuredArtists": List<dynamic>.from(featuredArtists.map((x) => x)),
        "artists": artists == null
            ? []
            : List<dynamic>.from(artists!.map((x) => x.toJson())),
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "songs": songs == null ? [] : List<dynamic>.from(songs!.map((x) => x)),
        "releaseDate":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "album": album?.toJson(),
        "duration": duration,
        "label": label,
      };
}

class AlbumAlbum {
  String id;
  String name;
  String url;

  AlbumAlbum({
    required this.id,
    required this.name,
    required this.url,
  });

  factory AlbumAlbum.fromJson(Map<String, dynamic> json) => AlbumAlbum(
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

class Artist {
  String id;
  String name;
  String url;
  dynamic image;
  PrimaryArtistType type;
  Role role;

  Artist({
    required this.id,
    required this.name,
    required this.url,
    required this.image,
    required this.type,
    required this.role,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        image: json["image"],
        type: primaryArtistTypeValues.map[json["type"]]!,
        role: roleValues.map[json["role"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "image": image,
        "type": primaryArtistTypeValues.reverse[type],
        "role": roleValues.reverse[role],
      };
}

class ImageElement {
  Quality quality;
  String link;

  ImageElement({
    required this.quality,
    required this.link,
  });

  factory ImageElement.fromJson(Map<String, dynamic> json) => ImageElement(
        quality: qualityValues.map[json["quality"]]!,
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "quality": qualityValues.reverse[quality],
        "link": link,
      };
}

// ignore: constant_identifier_names
enum Quality { THE_150_X150, THE_500_X500, THE_50_X50 }

final qualityValues = EnumValues({
  "150x150": Quality.THE_150_X150,
  "500x500": Quality.THE_500_X500,
  "50x50": Quality.THE_50_X50
});

// ignore: constant_identifier_names
enum Role { EMPTY, MUSIC, SINGER }

final roleValues =
    EnumValues({"": Role.EMPTY, "music": Role.MUSIC, "singer": Role.SINGER});

// ignore: constant_identifier_names
enum PrimaryArtistType { ARTIST }

final primaryArtistTypeValues =
    EnumValues({"artist": PrimaryArtistType.ARTIST});

// ignore: constant_identifier_names
enum Language { ENGLISH, HINDI, SPANISH, GUJARATI }

final languageValues = EnumValues({
  "english": Language.ENGLISH,
  "hindi": Language.HINDI,
  "spanish": Language.SPANISH,
  "gujarati": Language.GUJARATI
});

// ignore: constant_identifier_names
enum AlbumType { ALBUM, SONG }

final albumTypeValues =
    EnumValues({"album": AlbumType.ALBUM, "song": AlbumType.SONG});

class Chart {
  String id;
  String title;
  Firstname subtitle;
  ChartType type;
  List<ImageElement> image;
  String url;
  Firstname firstname;
  String explicitContent;
  Language language;

  Chart({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.image,
    required this.url,
    required this.firstname,
    required this.explicitContent,
    required this.language,
  });

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        id: json["id"],
        title: json["title"],
        subtitle: firstnameValues.map[json["subtitle"]]!,
        type: chartTypeValues.map[json["type"]]!,
        image: List<ImageElement>.from(
            json["image"].map((x) => ImageElement.fromJson(x))),
        url: json["url"],
        firstname: firstnameValues.map[json["firstname"]]!,
        explicitContent: json["explicitContent"],
        language: languageValues.map[json["language"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": firstnameValues.reverse[subtitle],
        "type": chartTypeValues.reverse[type],
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "url": url,
        "firstname": firstnameValues.reverse[firstname],
        "explicitContent": explicitContent,
        "language": languageValues.reverse[language],
      };
}

// ignore: constant_identifier_names
enum Firstname { JIO_SAAVN }

final firstnameValues = EnumValues({"JioSaavn": Firstname.JIO_SAAVN});

// ignore: constant_identifier_names
enum ChartType { PLAYLIST }

final chartTypeValues = EnumValues({"playlist": ChartType.PLAYLIST});

class Playlist {
  String id;
  UserId userId;
  String title;
  String subtitle;
  ChartType type;
  List<ImageElement> image;
  String url;
  String songCount;
  Firstname firstname;
  String followerCount;
  String lastUpdated;
  String explicitContent;

  Playlist({
    required this.id,
    required this.userId,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.image,
    required this.url,
    required this.songCount,
    required this.firstname,
    required this.followerCount,
    required this.lastUpdated,
    required this.explicitContent,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        id: json["id"],
        userId: userIdValues.map[json["userId"]]!,
        title: json["title"],
        subtitle: json["subtitle"],
        type: chartTypeValues.map[json["type"]]!,
        image: List<ImageElement>.from(
            json["image"].map((x) => ImageElement.fromJson(x))),
        url: json["url"],
        songCount: json["songCount"],
        firstname: firstnameValues.map[json["firstname"]]!,
        followerCount: json["followerCount"] ?? '0',
        lastUpdated: json["lastUpdated"],
        explicitContent: json["explicitContent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userIdValues.reverse[userId],
        "title": title,
        "subtitle": subtitle,
        "type": chartTypeValues.reverse[type],
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "url": url,
        "songCount": songCount,
        "firstname": firstnameValues.reverse[firstname],
        "followerCount": followerCount,
        "lastUpdated": lastUpdated,
        "explicitContent": explicitContent,
      };
}

// ignore: constant_identifier_names
enum UserId { PHULKI_USER }

final userIdValues = EnumValues({"phulki_user": UserId.PHULKI_USER});

class Trending {
  List<AlbumElement> songs;
  List<AlbumElement> albums;

  Trending({
    required this.songs,
    required this.albums,
  });

  factory Trending.fromJson(Map<String, dynamic> json) => Trending(
        songs: List<AlbumElement>.from(
            json["songs"].map((x) => AlbumElement.fromJson(x))),
        albums: List<AlbumElement>.from(
            json["albums"].map((x) => AlbumElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
        "albums": List<dynamic>.from(albums.map((x) => x.toJson())),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
