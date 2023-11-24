// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final double size;
  final ImageProvider image;
  final String label;

  const AlbumCard({
    Key? key,
    this.size = 120,
    required this.image,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: image,
          height: size,
          width: size,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
