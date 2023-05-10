import 'package:codfac/common/model/cursor_pagination_model.dart';
import 'package:codfac/common/provider/pagination_provider.dart';
import 'package:codfac/restaurant/model/restaurant_model.dart';
import 'package:codfac/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restauratDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    return null;
  }
  return state.data.firstWhere((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestuarantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestuarantStateNotifier(repository: repository);
  return notifier;
});

//CursorPaginationBase를 타입으로 쓰면 이걸 상속받은 클래스가 모두 오ㅓㄹ수 있다
class RestuarantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  @override
  RestuarantStateNotifier({required super.repository});

  getDetail({
    required String id,
  }) async {
    //만약에 데이터가 아직 하나도 없는 상태라면(curcorpagination이 아니라면 데이터를 가져오는 시도를 한다)
    if (state is! CursorPagination) {
      await paginate();
    }

    //state가 cursorpagination이 아닐때 그냥 리턴
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;
    final resp = await repository.getRestaurantDetail(id: id);

    state = pState.copyWith(
      data: pState.data
          .map<RestaurantModel>((e) => e.id == id ? resp : e)
          .toList(),
    );
  }
}
