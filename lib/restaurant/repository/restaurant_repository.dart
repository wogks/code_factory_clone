import 'package:codfac/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  //baseUrl 일반화할 주소 = http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  //baseUrl 일반화할 주소 = http://$ip/restaurant/
  // @GET('/')
  // pagenate()

  //baseUrl 일반화할 주소 = http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail({
    //get안의 변수를 자동으로 넣어준다
    @Path() required String id,
  });
}
