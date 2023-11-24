// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:music_app/Api/song_api/song_model.dart';
import 'package:music_app/screens/player_screen.dart';
import 'package:music_app/second_to_minutes/second_to_minutes.dart';
import 'package:music_app/shared_prefrences/recently_precendence.dart';
import 'package:page_transition/page_transition.dart';

class RecentlyPlayedScrren extends StatefulWidget {
  const RecentlyPlayedScrren({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentlyPlayedScrren> createState() => _RecentlyPlayedScrrenState();
}

class _RecentlyPlayedScrrenState extends State<RecentlyPlayedScrren> {
  List<Datum>? recentlyPlayed;

  @override
  void initState() {
    super.initState();
    featchFavSongs();
  }

  Future<void> featchFavSongs() async {
    List<Datum> featchSong = await RecentlyPlayed.getRecentlyPlayed();
    setState(() {
      recentlyPlayed = featchSong;
    });
  }

  void deleteFromRecentlyPlayed(String songId) async {
    await RecentlyPlayed.removeFromFavorites(songId);
  }

  void _navigateBackToLibraryScreen() {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size(width, 200),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            height: 200,
            child: ClipRRect(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1578070181910-f1e514afdd08?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=933&q=80',
                    height: 200,
                    memCacheHeight:
                        (200 * MediaQuery.of(context).devicePixelRatio).round(),
                    memCacheWidth: (MediaQuery.of(context).size.width *
                            MediaQuery.of(context).devicePixelRatio)
                        .round(),
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [Colors.black, Colors.black.withOpacity(.5)],
                        ),
                      ),
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Recently Played',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          _navigateBackToLibraryScreen();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  primary: false,
                  itemCount: recentlyPlayed?.length ?? 0,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    int totalSecond =
                        int.parse(recentlyPlayed?[index].duration ?? '0');
                    Duration duration = convertSecondsToDuration(totalSecond);
                    var formateDuration = formatDuration(duration);
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        deleteFromRecentlyPlayed(recentlyPlayed![index].id);
                        recentlyPlayed!.removeAt(index);
                        setState(() {});
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: PlayerScreen(
                                      likedSongs: recentlyPlayed!,
                                      currentSongIndex: index),
                                  type: PageTransitionType.rightToLeft));
                        },
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      recentlyPlayed![index].image[2].link,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                recentlyPlayed![index].name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                formateDuration,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
