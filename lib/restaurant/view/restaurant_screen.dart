import 'package:codfac/common/dio/dio.dart';
import 'package:codfac/restaurant/component/restaurant_card.dart';
import 'package:codfac/restaurant/model/restaurant_model.dart';
import 'package:codfac/restaurant/repository/restaurant_repository.dart';
import 'package:codfac/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/data.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);

    // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    //베이스 유알엘은 항상 같다. 레포지토리에서 다르게 설정하기 때문
    final resp =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .pagenate();
    return resp.data;
    // final response = await dio.get(
    //   'http://$ip/restaurant',
    //   options: Options(
    //     headers: {
    //       'authorization': 'Bearer $accessToken',
    //     },
    //   ),
    // );
    // return response.data['data'];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List<RestaurantModel>>(
            future: paginateRestaurant(ref),
            builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final pItem = snapshot.data![index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RestaurantDetailScreen(id: pItem.id),
                        ),
                      );
                    },
                    child: RestaurantCard.fromModel(
                      model: pItem,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
              );
            },
          )),
    );
  }
}
