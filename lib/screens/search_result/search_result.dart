import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Api/search_song/search_song_api.dart';
import 'package:music_app/Api/search_song/search_song_model.dart';
import 'package:music_app/Api/song_api/song_api.dart';
import 'package:music_app/Api/song_api/song_model.dart';
import 'package:music_app/screens/player_screen.dart';
import 'package:page_transition/page_transition.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final TextEditingController searchController = TextEditingController();
  Future<SearchSongModel>? songs;
  List<Result> allSong = [];
  List<Datum> datum = [];

  @override
  void initState() {
    SearchSongApi.searchSong = null;
    SearchSongApi.songApiUrl = '';
    log('Hello');
    //log(SongApi.searchSong.toString());
    super.initState();
    log('====$songs');
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   searchController.dispose();
  // }

  Duration convertSecondsToDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    return Duration(minutes: minutes, seconds: remainingSeconds);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds.remainder(60);

    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    String? formateDuration;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              width: width,
              height: height * 0.06,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: searchController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: InputBorder.none,
                  prefixIcon: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  suffixIcon: const Icon(
                    Icons.music_note,
                    color: Colors.white,
                  ),
                ),
                onSubmitted: (value) {
                  allSong = [];
                  SearchSongApi.searchSong = value;
                  songs = SearchSongApi.fetchAllSong();
                  log(SearchSongApi.songApiUrl.toString());
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: songs,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.data.results.length,
                      itemBuilder: (context, index) {
                        SongApi.songId = snapshot.data!.data.results[index].id;
                        var songData = snapshot.data!.data.results[index];
                        String inputString =
                            snapshot.data!.data.results[index].duration;

                        try {
                          int totalSecond = int.parse(inputString);
                          Duration duration =
                              convertSecondsToDuration(totalSecond);
                          formateDuration = formatDuration(duration);
                        } catch (e) {
                          log(e.toString());
                        }
                        // allSong.add(snapshot.data!.data.results[index]);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: PlayerScreen(
                                        songs: snapshot.data!.data.results,
                                        currentSongIndex: index,
                                      ),
                                      type: PageTransitionType.rightToLeft));
                              log('index == $index');
                              setState(() {});
                            },
                            leading: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                              child: CachedNetworkImage(
                                  imageUrl: songData.image[2].link),
                            ),
                            title: Text(
                              songData.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                            subtitle: Text(
                              formateDuration.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
