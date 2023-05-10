import 'package:codfac/common/const/color.dart';
import 'package:codfac/product/model/product_model.dart';
import 'package:codfac/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;
  const ProductCard(
      {super.key,
      required this.image,
      required this.name,
      required this.detail,
      required this.price});

  factory ProductCard.fromProdectModel({required ProductModel model}) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  factory ProductCard.fromRestauratnModel({
    required RestaurantProductModel model,
  }) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    //IntrinsicHeight 내부에 있는 모든 위젯들중 최대 높이를 가지고 있는 위젯에 높이가 맞춰진다
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(8), child: image),
          const SizedBox(width: 16),
          //클립알렉트가 왼쪽 끝에 붙어있으니까 나머지 오른쪽 공간은 익스팬디드로 먹어준다
          Expanded(
            child: Column(
              //좌우로 쭉 늘려준다
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //컴포넌트간의 간격을 똑같이 준다
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      color: BODY_TEXT_COLOR,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '₩$price',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 12,
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
