// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:music_app/Api/album/album_model.dart' as album_model;
import 'package:music_app/Api/home_api/home_page_model.dart';
import 'package:music_app/Api/playlist/playlist_model.dart';
import 'package:music_app/Api/search_song/search_song_model.dart' as song_model;
import 'package:music_app/Api/song_api/song_model.dart';
import 'package:music_app/widgets/custom_player/album_song_player.dart';
import 'package:music_app/widgets/custom_player/chats_player_song.dart';
import 'package:music_app/widgets/custom_player/liked_song_player.dart';
import 'package:music_app/widgets/custom_player/result_song_player.dart';

class PlayerScreen extends StatefulWidget {
  int? currentSongIndex;
  List<song_model.Result>? songs;
  List<album_model.Song>? albumSongs;
  List<PlayListSong>? playListSong;
  List<Datum>? likedSongs;
  List<AlbumElement>? trandingSongs;

  PlayerScreen(
      {Key? key,
      required this.currentSongIndex,
      this.songs,
      this.albumSongs,
      this.playListSong,
      this.likedSongs,
      this.trandingSongs})
      : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widget.songs != null
            ? ResultSongPlayer(
                resultSongs: widget.songs!,
                isFav: isFav,
                currentSongIndex: widget.currentSongIndex!)
            : widget.albumSongs != null
                ? AlbumSongPlayer(
                    albumSongs: widget.albumSongs!,
                    isFav: isFav,
                    currentSongIndex: widget.currentSongIndex!,
                  )
                : widget.playListSong != null
                    ? ChatSongPlayer(
                        chartsSong: widget.playListSong!,
                        isFav: isFav,
                        currentSongIndex: widget.currentSongIndex!,
                      )
                    : LikedSongPlayer(
                        dataum: widget.likedSongs!,
                        isFav: isFav,
                        currentSongIndex: widget.currentSongIndex!),
      ),
    );
  }
}
