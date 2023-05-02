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

  void paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    //State 5가지 가능성
    //1)CursorPagination - 정상적으로 데이터가 있는 상태
    //2)CursorPaginationLoading - 데이터가 로딩중인 상태(현재 캐시없음)
    //3)CursorPaginationError - 에러가 있는상태
    //4)CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올때
    //5)CursorPaginationFetchMore = 추가 데이터를 paginate 해오라는 요청을 받았을때

    //바로 반환하는 상황(또 실행이 되면 안되는 상황)
    //1)hasMore = false (기존 상태에서 이미 다음데이터가 없다는 값을 들고있다면)
    if (state is CursorPagination && forceRefetch == false) {
      //CursorPaginationBase의 어떤값도 될수 있기때문에 강제로 가정해준다
      final pState = state as CursorPagination;
      if (!pState.meta.hasMore) {
        return;
      }
    }
    //2)로딩중 - fetchMore:true
    //  fetchMore가 아닐때 - 새로고침의 의도가 있을수있더ㅏ(기존요청이 중요하지 않다)
    final isLoading = state is CursorPaginationLoading;
    final isRefetching = state is CursorPaginationRefetching;
    final isFetchingMore = state is CursorPaginationFetchingMore;
    if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
      return;
    }
  }
}
