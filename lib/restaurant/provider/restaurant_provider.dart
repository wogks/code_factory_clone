import 'package:codfac/common/model/cursor_pagination_model.dart';
import 'package:codfac/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestuarantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestuarantStateNotifier(repository: repository);
  return notifier;
});

//CursorPaginationBase를 타입으로 쓰면 이걸 상속받은 클래스가 모두 오ㅓㄹ수 있다
class RestuarantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;
  RestuarantStateNotifier({required this.repository})
      : super(CursorPaginationLoading()) {
    //이 레포지토리 노티파이어가 처음 불려와지면 무조건 이 함수를 실행해라
    paginate();
  }

  paginate() async {
    final resp = await repository.pagenate();
    //커서페이지네이션 안에 들어있는 레스토랑 모델을 반환하기 때문에 그냥 들어간다
    state = resp;
  }
}
