// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:just_audio/just_audio.dart';
import 'package:line_icons/line_icons.dart';
import 'package:music_app/Api/playlist/playlist_model.dart';
import 'package:music_app/Api/song_api/song_api.dart';

import 'package:music_app/Api/song_api/song_model.dart';
import 'package:music_app/second_to_minutes/second_to_minutes.dart';
import 'package:music_app/shared_prefrences/liked_song_prefrences.dart';
import 'package:music_app/shared_prefrences/recently_precendence.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class ChatSongPlayer extends StatefulWidget {
  List<PlayListSong> chartsSong;
  bool isFav;
  int currentSongIndex;
  ChatSongPlayer({
    Key? key,
    required this.chartsSong,
    required this.isFav,
    required this.currentSongIndex,
  }) : super(key: key);

  @override
  State<ChatSongPlayer> createState() => _LikedSongPlayerState();
}

class _LikedSongPlayerState extends State<ChatSongPlayer> {
  int sliderValue = 0;
  final AudioPlayer audioPlayer = AudioPlayer();
  String? songBegin;
  StreamSubscription<Duration>? positionSubscription;
  bool isPlaying = false;
  PermissionStatus? permissionStatus;
  double? progress;

  Future<void> _seek(int value) async {
    await audioPlayer.seek(Duration(seconds: value));
  }

  Future<void> addToFav() async {
    SongApi.songId = widget.chartsSong[widget.currentSongIndex].id;
    SongDetailsModel songDetailsModel = await SongApi.feachAllData();
    await FavMusic.addToFavourite(songDetailsModel.data[0]);
  }

  Future<void> removeToFav() async {
    await FavMusic.removeFromFavorites(
        widget.chartsSong[widget.currentSongIndex].id);
  }

  Future<void> toggleFav() async {
    List<Datum> fav = await FavMusic.getFavourite();
    widget.isFav = fav.any((element) =>
        element.id == widget.chartsSong[widget.currentSongIndex].id);
  }

  Future<void> featchSongDetails() async {
    SongApi.songId = widget.chartsSong[widget.currentSongIndex].id;
    SongDetailsModel songDetailsModel = await SongApi.feachAllData();
    await RecentlyPlayed.addToRecent(songDetailsModel.data[0]);
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    setState(() {
      permissionStatus = status;
    });
  }

  void _navigateBackToHomeScreen(BuildContext context) {
    Navigator.pop(context, true); // Passing true to indicate rebuild
  }

  @override
  void initState() {
    audioPlayer
        .setUrl(widget.chartsSong[widget.currentSongIndex].downloadUrl[2].link);
    positionSubscription = audioPlayer.positionStream.listen((state) {
      setState(() {
        sliderValue = state.inSeconds;
        Duration duration = convertSecondsToDuration(sliderValue);
        songBegin = formatDuration(duration);
      });
    });
    toggleFav();
    featchSongDetails();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    positionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    String inputString = widget.chartsSong[widget.currentSongIndex].duration;
    String? formateDuration;
    try {
      int totalSecond = int.parse(inputString);
      Duration duration = convertSecondsToDuration(totalSecond);
      formateDuration = formatDuration(duration);
    } catch (e) {
      log(e.toString());
    }
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 300, sigmaY: 300),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black87,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black,
                Colors.black45,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _navigateBackToHomeScreen(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              const Text(
                                'NOW PLAYING',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                widget.chartsSong[widget.currentSongIndex].name
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: CachedNetworkImage(
                        imageUrl: widget
                            .chartsSong[widget.currentSongIndex].image[2].link,
                        fit: BoxFit.cover,
                        memCacheHeight: (200 * devicePixelRatio).round(),
                        memCacheWidth: (200 * devicePixelRatio).round(),
                        maxHeightDiskCache: (200 * devicePixelRatio).round(),
                        maxWidthDiskCache: (200 * devicePixelRatio).round(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.chartsSong[widget.currentSongIndex].name
                                  .toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.chartsSong[widget.currentSongIndex]
                                  .primaryArtists
                                  .toString(),
                              maxLines: 2,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            if (widget.isFav == false) {
                              addToFav();
                              widget.isFav = true;
                            } else {
                              removeToFav();
                              widget.isFav = false;
                            }
                          });
                        },
                        icon: widget.isFav == false
                            ? const Icon(Icons.favorite_border)
                            : const Icon(Icons.favorite),
                        color:
                            widget.isFav == false ? Colors.white : Colors.green,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Slider(
                  inactiveColor: Colors.grey,
                  activeColor: Colors.white,
                  min: 0.0,
                  max: audioPlayer.duration?.inSeconds.toDouble() ?? 0.0,
                  value: sliderValue.toDouble(),
                  onChanged: (value) {
                    _seek(value.toInt());
                  },
                ),
                const SizedBox(
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 40,
                        child: Text(
                          songBegin ?? '00:00',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text(
                          formateDuration.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        LineIcons.random,
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          IconButton(
                            onPressed: () {
                              if (widget.currentSongIndex > 0) {
                                widget.currentSongIndex =
                                    widget.currentSongIndex - 1;
                                audioPlayer.setUrl(widget
                                    .chartsSong[widget.currentSongIndex]
                                    .downloadUrl[2]
                                    .link);

                                featchSongDetails();
                                toggleFav();
                                setState(() {
                                  sliderValue = 0;
                                  audioPlayer.play();
                                  isPlaying = true;
                                  log('playerScreen : ${widget.currentSongIndex}');
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.skip_previous,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 80,
                            width: 120,
                            child: IconButton(
                              onPressed: isPlaying == false
                                  ? () {
                                      isPlaying = true;
                                      audioPlayer.play();
                                      setState(() {});
                                    }
                                  : () {
                                      isPlaying = false;
                                      audioPlayer.pause();
                                      setState(() {});
                                    },
                              icon: Icon(
                                isPlaying == false
                                    ? CupertinoIcons.play_circle_fill
                                    : CupertinoIcons.pause_circle_fill,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              log(widget.currentSongIndex.toString());

                              if (widget.currentSongIndex <
                                  widget.chartsSong.length - 1) {
                                widget.currentSongIndex =
                                    widget.currentSongIndex + 1;
                                audioPlayer.setUrl(widget
                                    .chartsSong[widget.currentSongIndex]
                                    .downloadUrl[2]
                                    .link);
                                featchSongDetails();
                                toggleFav();
                                setState(() {
                                  sliderValue = 0;
                                  audioPlayer.play();
                                  isPlaying = true;
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        CupertinoIcons.arrow_2_circlepath,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          requestPermission();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Downloadding.....'),
                            ),
                          );
                          FileDownloader.downloadFile(
                            notificationType: NotificationType.all,
                            url: widget.chartsSong[widget.currentSongIndex]
                                .downloadUrl[2].link,
                            name: widget
                                .chartsSong[widget.currentSongIndex].name
                                .toString(),
                            onProgress: (fileName, processing) {
                              setState(() {
                                progress = processing;
                              });
                            },
                            onDownloadCompleted: (value) {
                              log('===$value=====');
                              setState(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Downloaded'),
                                  ),
                                );
                                progress = null;
                              });
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.download_sharp,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ),
                      const Icon(
                        Icons.library_music_outlined,
                        color: Colors.grey,
                        size: 18,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
