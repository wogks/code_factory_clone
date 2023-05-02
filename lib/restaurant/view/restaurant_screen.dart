import 'package:codfac/common/model/cursor_pagination_model.dart';
import 'package:codfac/restaurant/component/restaurant_card.dart';
import 'package:codfac/restaurant/provider/restaurant_provider.dart';
import 'package:codfac/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    //애드리스너 안에는 함수가 하나 들어간다
    controller.addListener(scrollListener);
    super.initState();
  }

//리스트뷰속 스크롤이 바뀔때마다 실행
  void scrollListener() {
    //현재위치가 최대길이보다 조금 덜되는 위치까지 왔다면 새로운 데이터를 추가요청
    //offset = 현재 스크롤 위치 controller.position.maxScrollExtent = 최대 스크롤가능한 기능
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(
            fetchMore: true,
          );
    }
  }
  // Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
  //   final dio = ref.watch(dioProvider);

  //   // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
  //   //베이스 유알엘은 항상 같다. 레포지토리에서 다르게 설정하기 때문
  //   final resp =
  //       await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
  //           .pagenate();
  //   return resp.data;
  //   // final response = await dio.get(
  //   //   'http://$ip/restaurant',
  //   //   options: Options(
  //   //     headers: {
  //   //       'authorization': 'Bearer $accessToken',
  //   //     },
  //   //   ),
  //   // );
  //   // return response.data['data'];
  // }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);
    //완전 처음 로딩일때
    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    //에러
    if (data is CursorPaginationError) {
      return Center(child: Text(data.message));
    }
    //CursorPgination
    //CursorPginationFetchingMore
    //CursorPginationRefetching 세개다 //CursorPgination의 차일드
    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length,
        itemBuilder: (context, index) {
          final pItem = cp.data[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantDetailScreen(id: pItem.id),
                ),
              );
            },
            child: RestaurantCard.fromModel(
              model: pItem,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
