import 'package:codfac/restaurant/model/restaurant_model.dart';
import 'package:codfac/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestuarantStateNotifier, List<RestaurantModel>>(
        (ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestuarantStateNotifier(repository: repository);
  return notifier;
});

class RestuarantStateNotifier extends StateNotifier<List<RestaurantModel>> {
  final RestaurantRepository repository;
  RestuarantStateNotifier({required this.repository}) : super([]) {
    //이 레포지토리 노티파이어가 처음 불려와지면 무조건 이 함수를 실행해라
    paginate();
  }

  paginate() async {
    final resp = await repository.pagenate();
    state = resp.data;
  }
}
