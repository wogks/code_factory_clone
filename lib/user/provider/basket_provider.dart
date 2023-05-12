import 'package:codfac/product/model/product_model.dart';
import 'package:codfac/user/model/basket_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  BasketProvider() : super([]);

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    //1)아직 장바구니에 해당되는 상품이 없다면 장바구니에 추가한다
    //2)만약에 이미 있다면 장바구니의 값에 +1을 한다
    //firstwhereornull 퍼스트값이 있거나 없으면 널반환
    final exist =
        state.firstWhereOrNull((element) => element.product.id == product.id) !=
            null;

    if (exist) {
      state = state
          .map((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count + 1) : e)
          .toList();
    } else {
      state = [
        ...state,
        BasketItemModel(
          product: product,
          count: 1,
        ),
      ];
    }
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    bool isDelete = false,
    //true면 아예삭제
  }) async {
    //1) 장바구니에 상품이 존재할때
    //   1)상품의 카운트가 1보다 크면 -1
    //   2)상품의 카운트가 1이면 삭제한다
    //2)상품이 존재하지 않을때
    //  즉시 함수를 반환하고 아무것도 하지않는다
    final exists =
        state.firstWhereOrNull((element) => element.product.id == product.id) !=
            null;
    if (!exists) {
      return;
    }

    final existingProduct =
        state.firstWhere((element) => element.product.id == product.id);
    if (existingProduct.count == 1 || isDelete) {
      state =
          state.where((element) => element.product.id != product.id).toList();
    } else {
      state = state
          .map((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count - 1) : e)
          .toList();
    }
  }
}
