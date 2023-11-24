// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:music_app/Api/album/album_model.dart';
import 'package:music_app/Api/playlist/playlist_model.dart';
import 'package:music_app/screens/player_screen.dart';
import 'package:music_app/second_to_minutes/second_to_minutes.dart';

// ignore: must_be_immutable
class AlbumView extends StatefulWidget {
  AlbumModel? albumSongs;
  PlayListModel? playListSong;
  AlbumView({
    Key? key,
    this.albumSongs,
    this.playListSong,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AlbumViewState createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  late ScrollController scrollController;
  double imageSize = 0;
  double initialSize = 240;
  double containerHeight = 500;
  double containerinitalHeight = 500;
  double imageOpacity = 1;
  bool showTopBar = false;

  @override
  void initState() {
    imageSize = initialSize;
    scrollController = ScrollController()
      ..addListener(() {
        imageSize = initialSize - scrollController.offset;
        if (imageSize < 0) {
          imageSize = 0;
        }
        containerHeight = containerinitalHeight - scrollController.offset;
        if (containerHeight < 0) {
          containerHeight = 0;
        }
        imageOpacity = imageSize / initialSize;
        if (scrollController.offset > 224) {
          showTopBar = true;
        } else {
          showTopBar = false;
        }
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: widget.albumSongs != null
          ? albumSongView(context)
          : playListView(context),
    );
  }

  Stack playListView(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Container(
            height: containerHeight,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Colors.pink,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: imageOpacity.clamp(0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          offset: const Offset(0, 20),
                          blurRadius: 32,
                          spreadRadius: 16,
                        )
                      ],
                    ),
                    child: Image(
                      image:
                          NetworkImage(widget.playListSong!.data.image[2].link),
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        SafeArea(
          child: ListView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(1),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      SizedBox(height: initialSize + 32),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Image(
                                  image: AssetImage('assets/images/logo.png'),
                                  width: 32,
                                  height: 32,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Spotify",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "1,888,132 likes 5h 3m",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 16),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 16),
                                    Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 32),
                    Text(
                      "You might also like",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.playListSong!.data.songs.length,
                itemBuilder: (context, index) {
                  String inputString =
                      widget.playListSong!.data.songs[index].duration;
                  String? formateDuration;

                  try {
                    int totalSecond = int.parse(inputString);
                    Duration duration = convertSecondsToDuration(totalSecond);
                    formateDuration = formatDuration(duration);
                  } catch (e) {
                    log(e.toString());
                  }
                  return GestureDetector(
                    onTap: () {
                      log(widget.playListSong!.data.songs[index].id);
                      Navigator.push(
                          context,
                          PageTransition(
                              child: PlayerScreen(
                                currentSongIndex: index,
                                playListSong: widget.playListSong!.data.songs,
                              ),
                              type: PageTransitionType.rightToLeft));
                    },
                    child: ListTile(
                      leading: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: CachedNetworkImage(
                          imageUrl: widget
                              .playListSong!.data.songs[index].image[2].link,
                        ),
                      ),
                      title: Text(
                        widget.playListSong!.data.songs[index].name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        formateDuration!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        // App bar
        Positioned(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            color: showTopBar
                ? const Color(0xFFC61855).withOpacity(1)
                : const Color(0xFFC61855).withOpacity(0),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: SafeArea(
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_left,
                          size: 38,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: showTopBar ? 1 : 0,
                      child: Text(
                        "Ophelia",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom:
                          80 - containerHeight.clamp(120.0, double.infinity),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff14D860),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              size: 38,
                            ),
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.shuffle,
                              color: Colors.black,
                              size: 14,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

// AlbumView
  Stack albumSongView(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Container(
            height: containerHeight,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Colors.pink,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: imageOpacity.clamp(0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          offset: const Offset(0, 20),
                          blurRadius: 32,
                          spreadRadius: 16,
                        )
                      ],
                    ),
                    child: Image(
                      image:
                          NetworkImage(widget.albumSongs!.data.image[2].link),
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        SafeArea(
          child: ListView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(1),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      SizedBox(height: initialSize + 32),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Image(
                                  image: AssetImage('assets/images/logo.png'),
                                  width: 32,
                                  height: 32,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Spotify",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "1,888,132 likes 5h 3m",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 16),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 16),
                                    Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 32),
                    Text(
                      "You might also like",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.albumSongs!.data.songs.length,
                itemBuilder: (context, index) {
                  String inputString =
                      widget.albumSongs!.data.songs[index].duration;
                  String? formateDuration;

                  try {
                    int totalSecond = int.parse(inputString);
                    Duration duration = convertSecondsToDuration(totalSecond);
                    formateDuration = formatDuration(duration);
                  } catch (e) {
                    log(e.toString());
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: PlayerScreen(
                                  currentSongIndex: index,
                                  albumSongs: widget.albumSongs!.data.songs),
                              type: PageTransitionType.rightToLeft));
                    },
                    child: ListTile(
                      leading: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: CachedNetworkImage(
                          imageUrl: widget
                              .albumSongs!.data.songs[index].image[2].link,
                        ),
                      ),
                      title: Text(
                        widget.albumSongs!.data.songs[index].name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        formateDuration!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        // App bar
        Positioned(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            color: showTopBar
                ? const Color(0xFFC61855).withOpacity(1)
                : const Color(0xFFC61855).withOpacity(0),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: SafeArea(
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_left,
                          size: 38,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: showTopBar ? 1 : 0,
                      child: Text(
                        "Ophelia",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom:
                          80 - containerHeight.clamp(120.0, double.infinity),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff14D860),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              size: 38,
                            ),
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.shuffle,
                              color: Colors.black,
                              size: 14,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
