import 'package:codfac/common/dio/dio.dart';
import 'package:codfac/common/model/cursor_pagination_model.dart';
import 'package:codfac/common/model/pagination_params.dart';
import 'package:codfac/common/repository/base_pagination_repository.dart';
import 'package:codfac/restaurant/model/restaurant_detail_model.dart';
import 'package:codfac/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository =
      RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
  return repository;
});

@RestApi()
abstract class RestaurantRepository
    implements IBasePaginationRepository<RestaurantModel> {
  //baseUrl 일반화할 주소 = http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  //baseUrl 일반화할 주소 = http://$ip/restaurant/
  @override
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<RestaurantModel>> pagenate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  //baseUrl 일반화할 주소 = http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail({
    //get안의 변수를 자동으로 넣어준다
    @Path() required String id,
  });
}
