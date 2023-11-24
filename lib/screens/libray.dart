import 'package:flutter/material.dart';
import 'package:music_app/Api/song_api/song_model.dart';

import 'package:music_app/screens/liked_songs.dart';
import 'package:music_app/screens/recently_played_screen.dart';
import 'package:music_app/shared_prefrences/liked_song_prefrences.dart';
import 'package:music_app/shared_prefrences/recently_precendence.dart';
import 'package:page_transition/page_transition.dart';

class LibrayScreen extends StatefulWidget {
  final VoidCallback refreshCallback;
  const LibrayScreen({Key? key, required this.refreshCallback})
      : super(key: key);

  @override
  State<LibrayScreen> createState() => _LibrayScreenState();
}

class _LibrayScreenState extends State<LibrayScreen> {
  List<Datum>? recentlyPlayed;
  List<Datum>? likedSongs;

  @override
  void initState() {
    featchRecentlyPlayed();
    featchLikedSongs();
    super.initState();
  }

  Future<void> featchRecentlyPlayed() async {
    List<Datum> featchSong = await RecentlyPlayed.getRecentlyPlayed();
    setState(() {
      recentlyPlayed = featchSong;
    });
  }

  Future<void> featchLikedSongs() async {
    List<Datum> featchSongs = await FavMusic.getFavourite();
    setState(() {
      likedSongs = featchSongs;
    });
  }

  void _navigateToLikedSong() async {
    final result = await Navigator.push(
      context,
      PageTransition(
        child: const LikedSongs(),
        type: PageTransitionType.rightToLeft,
      ),
    );
    if (result == true) {
      featchLikedSongs();
    }
  }

  void _navigateToRecentlyPlayed() async {
    final result = await Navigator.push(
      context,
      PageTransition(
        child: const RecentlyPlayedScrren(),
        type: PageTransitionType.rightToLeft,
      ),
    );
    if (result == true) {
      featchRecentlyPlayed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: LibraryAppBar(width: width),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _navigateToLikedSong();
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         child: const LikedSongs(),
                  //         type: PageTransitionType.rightToLeft));
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Colors.blue,
                        child: const Center(
                            child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Liked Songs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${likedSongs?.length ?? 0} Songs',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _navigateToRecentlyPlayed();
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         child: const RecentlyPlayedScrren(),
                  //         type: PageTransitionType.rightToLeft));
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Colors.green,
                        child: const Center(
                            child: Icon(
                          Icons.restore,
                          color: Colors.white,
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recently Played',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${recentlyPlayed?.length ?? 0} Songs',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // const Text(
              //   'Your PlayList',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 18,
              //   ),
              // ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ));
  }
}

class LibraryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LibraryAppBar({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Your Libray',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
