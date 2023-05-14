import 'package:codfac/common/const/color.dart';
import 'package:codfac/common/layout/default_layout.dart';
import 'package:codfac/product/component/product_card.dart';
import 'package:codfac/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketScreen extends ConsumerWidget {
  static String routeName = 'basket';
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    if (basket.isEmpty) {
      return const DefaultLayout(
        title: '장바구니',
        child: Center(
          child: Text('장바구니가 비었소'),
        ),
      );
    }
    return DefaultLayout(
      title: '장바구니',
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 32,
                    );
                  },
                  itemBuilder: (context, index) {
                    final model = basket[index];
                    return ProductCard.fromProdectModel(
                      model: model.product,
                      onAdd: () {
                        ref
                            .read(basketProvider.notifier)
                            .addToBasket(product: model.product);
                      },
                      onSubtract: () {
                        ref
                            .read(basketProvider.notifier)
                            .removeFromBasket(product: model.product);
                      },
                    );
                  },
                  itemCount: basket.length,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '장바구니 금액',
                        style: TextStyle(color: BODY_TEXT_COLOR),
                      ),
                      Text(
                          '₩${basket.fold<int>(0, (p, n) => p + (n.product.price * n.count))}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '배달비',
                        style: TextStyle(color: BODY_TEXT_COLOR),
                      ),
                      Text('₩${basket.first.product.restaurant.deliveryFee}')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '총액',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          '₩${(basket.fold<int>(0, (p, n) => p + (n.product.price * n.count))) + (basket.first.product.restaurant.deliveryFee)}')
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
                  child: const Text('결제하기'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
