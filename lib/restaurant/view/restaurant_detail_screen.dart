import 'package:codfac/common/const/data.dart';
import 'package:codfac/common/dio/dio.dart';
import 'package:codfac/common/layout/default_layout.dart';
import 'package:codfac/product/component/product_card.dart';
import 'package:codfac/restaurant/component/restaurant_card.dart';
import 'package:codfac/restaurant/model/restaurant_detail_model.dart';
import 'package:codfac/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;
  const RestaurantDetailScreen({super.key, required this.id});

  Future<RestaurantDetailModel> getRestaurantDetail(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);

    final repository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
    return repository.getRestaurantDetail(id: id);
    // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    // final res = await dio.get(
    //   'http://$ip/restaurant/$id',
    //   options: Options(
    //     headers: {
    //       'authorization': 'Bearer $accessToken',
    //     },
    //   ),
    // );
    // return res.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
        title: '불타는 떡볶이',
        child: FutureBuilder<RestaurantDetailModel>(
          future: getRestaurantDetail(ref),
          builder: (_, AsyncSnapshot<RestaurantDetailModel> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // final item = RestaurantDetailModel.fromJson(snapshot.data!);
            return CustomScrollView(
              slivers: [
                _renderTop(model: snapshot.data!),
                _renderLabel(),
                _renderProducts(products: snapshot.data!.products),
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

  SliverToBoxAdapter _renderTop({required RestaurantDetailModel model}) {
    //일반 위젯을 넣으려면 SliverToBoxAdapter안에 넣어야 한다
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding _renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(model: model),
            );
          },
          childCount: products.length,
        ),
      ),
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
