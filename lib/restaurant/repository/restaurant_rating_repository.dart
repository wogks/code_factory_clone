import 'package:codfac/common/rating/model/rating_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';
part 'restaurant_rating_repository.g.dart';

//http://ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @GET('/')
  //dio에서의 헤더를 가져올수도 있기때문에 hide
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<RatingModel>> pagenate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
