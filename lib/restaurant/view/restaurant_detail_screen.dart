import 'package:codfac/common/const/data.dart';
import 'package:codfac/common/layout/default_layout.dart';
import 'package:codfac/product/component/product_card.dart';
import 'package:codfac/restaurant/component/restaurant_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  const RestaurantDetailScreen({super.key, required this.id});

  Future getRestaurantDetail() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final res = await dio.get(
      'http://$ip/restaurant/$id',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '불타는 떡볶이',
        child: FutureBuilder(
          future: getRestaurantDetail(),
          builder: (context, snapshot) {
            print(snapshot.data);
            return CustomScrollView(
              slivers: [
                _renderTop(),
                _renderLabel(),
                _renderProducts(),
              ],
            );
          },
        )

        // child: Column(
        //   children: [
        //     RestaurantCard(
        //       image: Image.asset(
        //           '/Users/wogks/Desktop/simbatt/codfac/asset/img/food/ddeok_bok_gi.jpg'),
        //       name: '떡볶이',
        //       tags: const ['맛남', '나이스', '매움'],
        //       ratingsCount: 100,
        //       deliveryTime: 30,
        //       deliveryFee: 12333,
        //       ratings: 12,
        //       isDetail: true,
        //       detail: '맛있는 떡볶이',
        //     ),
        //     const Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 16.0),
        //       child: ProductCard(),
        //     )
        //   ],
        // ),
        );
  }

  SliverToBoxAdapter _renderTop() {
    //일반 위젯을 넣으려면 SliverToBoxAdapter안에 넣어야 한다
    return SliverToBoxAdapter(
      child: RestaurantCard(
        image: Image.asset(
            '/Users/SIMBAAT/Desktop/simbaat/codfac/codfac/asset/img/food/ddeok_bok_gi.jpg'),
        name: '떡볶이',
        tags: const ['맛남', '나이스', '매움'],
        ratingsCount: 100,
        deliveryTime: 30,
        deliveryFee: 12333,
        ratings: 12,
        isDetail: true,
        detail: '맛있는 떡볶이',
      ),
    );
  }

  SliverPadding _renderProducts() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: ProductCard(),
          );
        },
        childCount: 10,
      )),
    );
  }

  _renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
