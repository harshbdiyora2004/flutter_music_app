// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:music_app/Api/album/album_api.dart';
import 'package:music_app/Api/album/album_model.dart';
import 'package:music_app/Api/home_api/home_api.dart';
import 'package:music_app/Api/home_api/home_page_model.dart';
import 'package:music_app/Api/playlist/playlist_api.dart';
import 'package:music_app/Api/playlist/playlist_model.dart';
import 'package:music_app/Api/song_api/song_api.dart';
import 'package:music_app/Api/song_api/song_model.dart';
import 'package:music_app/screens/alubm_view.dart';
import 'package:music_app/screens/player_screen.dart';

import 'package:music_app/widgets/song_card.dart';
import 'package:page_transition/page_transition.dart';

import '../shared_prefrences/recently_precendence.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<HomePageModel> homePagedata;
  List<Datum>? recentlyPlayed;

  Future<void> featchFavSongs() async {
    List<Datum> featchSong = await RecentlyPlayed.getRecentlyPlayed();
    setState(() {
      recentlyPlayed = featchSong;
    });
  }

  @override
  void initState() {
    homePagedata = HomeApi.feachAllData();
    featchFavSongs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height * 0.6,
              width: width,
              decoration: const BoxDecoration(
                color: Color(0xFf1C7A74),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recently Played',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.history,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 16),
                                  Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: 180,
                            key: const Key('recentlyPlayedSizedBox'),
                            child: FutureBuilder(
                              future: homePagedata,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return recentlyPlayed!.isNotEmpty
                                      ? ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: recentlyPlayed!.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () async {
                                                await Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        child: PlayerScreen(
                                                            currentSongIndex:
                                                                index,
                                                            likedSongs:
                                                                recentlyPlayed),
                                                        type: PageTransitionType
                                                            .rightToLeft));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SongCard(
                                                  image: NetworkImage(
                                                      recentlyPlayed![index]
                                                          .image[2]
                                                          .link),
                                                  label: recentlyPlayed![index]
                                                      .name,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : const Center(
                                          child: Text(
                                            "No Recently PlayedSong",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Good evening',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 175,
                            child: FutureBuilder(
                              future: homePagedata,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        snapshot.data!.data.charts.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          PlayListApi.playListApiKey = snapshot
                                              .data!.data.charts[index].id;
                                          PlayListModel playListModel =
                                              await PlayListApi
                                                  .featchAllAlbum();

                                          bool? rebuild = await Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: AlbumView(
                                                      playListSong:
                                                          playListModel),
                                                  type: PageTransitionType
                                                      .rightToLeft));

                                          if (rebuild == true &&
                                              rebuild != null) {
                                            setState(() {
                                              featchFavSongs();
                                            });
                                          }
                                        },
                                        child: SongCard(
                                          image: NetworkImage(snapshot
                                              .data!
                                              .data
                                              .charts[index]
                                              .image[2]
                                              .link),
                                          label: snapshot
                                              .data!.data.charts[index].title,
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 0,
                          ),
                          const Text(
                            "Trending Albums",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 175,
                            child: FutureBuilder(
                              future: homePagedata,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot
                                        .data!.data.trending.albums.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          AlbumApi.albumApiKey = snapshot.data!
                                              .data.trending.albums[index].id;
                                          log(AlbumApi.albumApiKey!);
                                          AlbumModel albumModel =
                                              await AlbumApi.featchAllAlbum();

                                          bool? isRebuild =
                                              await Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child: AlbumView(
                                                          albumSongs:
                                                              albumModel),
                                                      type: PageTransitionType
                                                          .rightToLeft));
                                          if (isRebuild == true &&
                                              isRebuild != null) {
                                            featchFavSongs();
                                            setState(() {});
                                          }
                                        },
                                        child: SongCard(
                                          image: NetworkImage(snapshot
                                              .data!
                                              .data
                                              .trending
                                              .albums[index]
                                              .image[2]
                                              .link),
                                          label: snapshot.data!.data.trending
                                              .albums[index].name,
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        bottom: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Albums",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 175,
                            child: FutureBuilder(
                              future: homePagedata,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        snapshot.data!.data.albums.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          AlbumApi.albumApiKey = snapshot
                                              .data!.data.albums[index].id;
                                          log(AlbumApi.albumApiKey!);
                                          AlbumModel albumModel =
                                              await AlbumApi.featchAllAlbum();
                                          bool? isRebuild =
                                              await Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child: AlbumView(
                                                        albumSongs: albumModel,
                                                      ),
                                                      type: PageTransitionType
                                                          .rightToLeft));

                                          if (isRebuild == true &&
                                              isRebuild != null) {
                                            featchFavSongs();
                                            setState(() {});
                                          }
                                        },
                                        child: SongCard(
                                          image: NetworkImage(snapshot
                                              .data!
                                              .data
                                              .albums[index]
                                              .image[2]
                                              .link),
                                          label: snapshot
                                              .data!.data.albums[index].name,
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        bottom: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Trending Songs",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 175,
                            child: FutureBuilder(
                              future: homePagedata,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot
                                        .data!.data.trending.songs.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          SongApi.songId = snapshot.data!.data
                                              .trending.songs[index].id;
                                        },
                                        child: SongCard(
                                          image: NetworkImage(snapshot
                                              .data!
                                              .data
                                              .trending
                                              .songs[index]
                                              .image[2]
                                              .link),
                                          label: snapshot
                                              .data!
                                              .data
                                              .trending
                                              .songs[index]
                                              .primaryArtists[0]
                                              .name,
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.all(5),
                                        width: 140,
                                        height: 120,
                                        color: Colors.white,
                                        child: const Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
