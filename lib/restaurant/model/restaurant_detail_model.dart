import 'package:codfac/restaurant/model/restaurant_model.dart';

//  추가되는 값들
//  "detail": "오늘 주문하면 배송비 3000원 할인!",
//   "products": [
//     {
//       "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
//       "name": "마라맛 코팩 떡볶이",
//       "imgUrl": "/img/img.png",
//       "detail": "서울에서 두번째로 맛있는 떡볶이집! 리뷰 이벤트 진행중~",
//       "price": 8000
//     }
//   ]
//extends를 통해서 RestaurantModel에 있는 속성들을 중복으로 선언하지 않고 상속을 통해서 모든 값들을 세팅할수 있다.
class RestaurantDetailModel extends RestaurantModel {
  //속성 추가
  final String detail;
  //final List<Map<String, dynamic>> 으로 하면 키값이 뭔지 모르는 문제가 생겨서 product에 해당되는 모델을 또 만든다
  final List<RestaurantProductModel> products;
  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });
  factory RestaurantDetailModel.fromJson({required Map<String, dynamic> json}) {
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: json['thumbUrl'],
      tags: List<String>.from(['tags']),
      priceRange: RestaurantPriceRange.values
          .firstWhere((element) => element.name == json['priceRange']),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      //tag에 리스트<다이나믹>을 넣을수 없는것 처럼 여기도 마찬가지로 마음대로 리스트로 넣을수가 없다
      products: json['products'],
    );
  }
}

//     {
//       "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
//       "name": "마라맛 코팩 떡볶이",
//       "imgUrl": "/img/img.png",
//       "detail": "서울에서 두번째로 맛있는 떡볶이집! 리뷰 이벤트 진행중~",
//       "price": 8000
//     }
class RestaurantProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final String price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });
}