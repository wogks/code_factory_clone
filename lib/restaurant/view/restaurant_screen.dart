import 'package:codfac/restaurant/component/restaurant_card.dart';
import 'package:codfac/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/const/data.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final response = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    return response.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder<List>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  final pItem = RestaurantModel.fromJson(json: item);
                  return RestaurantCard.fromModel(
                    model: pItem,
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
