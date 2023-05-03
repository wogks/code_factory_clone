import 'package:codfac/common/const/color.dart';
import 'package:flutter/material.dart';

class RatingCard extends StatelessWidget {
  final ImageProvider avatarImage;
  final List<Image> images;
  final int rating;
  final String email;
  final String content;
  const RatingCard({
    super.key,
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          email: email,
          rating: rating,
        ),
        const SizedBox(height: 8),
        _Body(content: content),
        const _Images()
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final String email;
  final int rating;
  const _Header(
      {required this.avatarImage, required this.email, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: avatarImage,
          backgroundColor: Colors.blue,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...List.generate(
            5,
            (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border_outlined,
                  color: PRIMARY_COLOR,
                ))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;
  const _Body({required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //플레시블 안에 텍스트를 넣으면 글이 길어지면 다음으로 넘어간다
        Flexible(
          child: Text(
            content,
            style: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  const _Images();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
