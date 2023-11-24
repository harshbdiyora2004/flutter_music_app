// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:music_app/models/catogory.dart';
import 'package:music_app/screens/search_result/search_result.dart';
import 'package:page_transition/page_transition.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final allTags = tags.map((e) => TagsModel.fromJson(e)).toList();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Search',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                color: Colors.black,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const SearchResult(),
                            type: PageTransitionType.rightToLeft));
                  },
                  child: Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Icon(
                              Icons.search,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Songs, Artists or Geners',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Your Top genre',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allTags.sublist(0, 4).length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 16 / 8),
                    itemBuilder: (context, index) {
                      return TagWidget(allTags: allTags.sublist(0, 4)[index]);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Your Top genre',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allTags.sublist(4).length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 16 / 8),
                    itemBuilder: (context, index) {
                      return TagWidget(allTags: allTags.sublist(4)[index]);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  const TagWidget({
    super.key,
    required this.allTags,
  });

  final TagsModel allTags;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: allTags.color,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              offset: const Offset(1, 1),
              spreadRadius: 1,
              blurRadius: 50,
              blurStyle: BlurStyle.outer,
            )
          ]),
      child: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            bottom: 5,
            right: -10,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: allTags.color, borderRadius: BorderRadius.circular(3)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: CachedNetworkImage(
                  imageUrl: allTags.image,
                  fit: BoxFit.cover,
                  width: 70,
                  height: 70,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              allTags.tag,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
