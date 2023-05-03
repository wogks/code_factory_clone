import 'package:codfac/common/layout/default_layout.dart';
import 'package:codfac/common/rating/component/rating_card.dart';
import 'package:codfac/product/component/product_card.dart';
import 'package:codfac/restaurant/component/restaurant_card.dart';
import 'package:codfac/restaurant/model/restaurant_detail_model.dart';
import 'package:codfac/restaurant/provider/restaurant_provider.dart';
import 'package:codfac/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

import '../model/restaurant_model.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const RestaurantDetailScreen({super.key, required this.id});

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  Future<RestaurantDetailModel> getRestaurantDetail(WidgetRef ref) async {
    return ref
        .watch(restaurantRepositoryProvider)
        .getRestaurantDetail(id: widget.id);

    // final dio = ref.watch(dioProvider);

    // final repository =
    //     RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
    // return repository.getRestaurantDetail(id: id);

    // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    // final res = await dio.get(
    //   'http://$ip/restaurant/$id',
    //   options: Options(
    //     headers: {
    //       'authorization': 'Bearer $accessToken',
    //     },
    //   ),
    // );
    // return res.data;
  }

  @override
  void initState() {
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restauratDetailProvider(widget.id));
    if (state == null) {
      return const DefaultLayout(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    }
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          //레스토랑 스크린에 이미 있던 데이터에서 뽑아왔기때문에 로딩이 없음
          _renderTop(model: state),
          if (state is! RestaurantDetailModel) renderLoading(),
          if (state is RestaurantDetailModel) _renderLabel(),
          if (state is RestaurantDetailModel)
            _renderProducts(products: state.products),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: RatingCard(
                avatarImage: AssetImage(''),
                content: '맛있습니다',
                email: 'wogks@naver.com',
                images: [],
                rating: 4,
              ),
            ),
          )
        ],
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(
                    lines: 5, padding: EdgeInsets.zero),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _renderTop({required RestaurantModel model}) {
    //일반 위젯을 넣으려면 SliverToBoxAdapter안에 넣어야 한다
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding _renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(model: model),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  _renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
