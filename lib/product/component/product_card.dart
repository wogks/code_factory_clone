import 'package:codfac/common/const/color.dart';
import 'package:codfac/product/model/product_model.dart';
import 'package:codfac/restaurant/model/restaurant_detail_model.dart';
import 'package:codfac/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;
  final String id;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;
  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.id,
    required this.detail,
    required this.price,
    this.onSubtract,
    this.onAdd,
  });

  factory ProductCard.fromProdectModel({
    required ProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      id: model.id,
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }

  factory ProductCard.fromRestauratnModel({
    required RestaurantProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      id: model.id,
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    //IntrinsicHeight 내부에 있는 모든 위젯들중 최대 높이를 가지고 있는 위젯에 높이가 맞춰진다
    return Column(
      children: [
        IntrinsicHeight(
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
        ),
        if (onSubtract != null && onAdd != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Footer(
              total: (basket
                          .firstWhere((element) => element.product.id == id)
                          .count *
                      basket
                          .firstWhere((element) => element.product.id == id)
                          .product
                          .price)
                  .toString(),
              count: basket
                  .firstWhere((element) => element.product.id == id)
                  .count,
              onAdd: onAdd!,
              onSubtract: onSubtract!,
            ),
          )
      ],
    );
  }
}

class Footer extends StatelessWidget {
  final String total;
  final int count;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;
  const Footer({
    super.key,
    required this.total,
    required this.count,
    required this.onAdd,
    required this.onSubtract,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '총액 ₩$total',
          style: const TextStyle(color: PRIMARY_COLOR),
        ),
        const Spacer(),
        Row(
          children: [
            renderButton(icon: Icons.remove, onTap: onSubtract),
            const SizedBox(width: 8),
            Text(
              count.toString(),
              style: const TextStyle(color: PRIMARY_COLOR),
            ),
            const SizedBox(width: 8),
            renderButton(icon: Icons.add, onTap: onAdd),
          ],
        )
      ],
    );
  }

  Widget renderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: PRIMARY_COLOR,
            width: 1,
          )),
      child: InkWell(
        onTap: onTap,
        child: Icon(icon, color: PRIMARY_COLOR),
      ),
    );
  }
}
