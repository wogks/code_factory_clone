import 'package:codfac/common/const/color.dart';
import 'package:codfac/order/model/order_model.dart';
import 'package:flutter/widgets.dart';

class OrderCard extends StatelessWidget {
  final DateTime orderDate;
  final Image image;
  final String name;
  final String productsDetail;
  final int price;

  const OrderCard({
    super.key,
    required this.orderDate,
    required this.image,
    required this.name,
    required this.productsDetail,
    required this.price,
  });

  factory OrderCard.fromModel({required OrderModel model}) {
    final productDetail = model.products.length < 2
        ? model.products.first.product.name
        : '${model.products.first.product.name} 외${model.products.length}개';
    return OrderCard(
      orderDate: model.createdAt,
      image: Image.network(
        model.restaurant.thumbUrl,
        height: 50,
        width: 50,
        fit: BoxFit.cover,
      ),
      name: model.restaurant.name,
      productsDetail: productDetail,
      price: model.totalPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            //2022.09.01
            '${orderDate.year}.${orderDate.month.toString().padLeft(2, '0')}.${orderDate.day.toString().padLeft(2, '0')} 주문완료'),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: image,
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  '$productsDetail $price원',
                  style: const TextStyle(
                      color: BODY_TEXT_COLOR, fontWeight: FontWeight.w300),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
