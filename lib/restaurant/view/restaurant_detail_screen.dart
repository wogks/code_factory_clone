import 'package:codfac/common/layout/default_layout.dart';
import 'package:codfac/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: Column(
        children: [
          RestaurantCard(
            image: Image.asset(
                '/Users/wogks/Desktop/simbatt/codfac/asset/img/food/ddeok_bok_gi.jpg'),
            name: '떡볶이',
            tags: const ['맛남', '나이스', '매움'],
            ratingsCount: 100,
            deliveryTime: 30,
            deliveryFee: 12333,
            ratings: 12,
            isDetail: true,
            detail: '맛있는 떡볶이',
          )
        ],
      ),
    );
  }
}
