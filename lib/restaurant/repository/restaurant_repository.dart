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
  @Headers({
    'authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNjgyNTEzNTMyLCJleHAiOjE2ODI1MTM4MzJ9.REGiOWxsssiPTXaTpRu-F6Sn1GQQI3B-6LUuTioxDlQ'
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    //get안의 변수를 자동으로 넣어준다
    @Path() required String id,
  });
}
