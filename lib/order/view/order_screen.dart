import 'package:codfac/common/component/pagination_list_view.dart';
import 'package:codfac/order/component/order_card.dart';
import 'package:codfac/order/model/order_model.dart';
import 'package:codfac/order/provider/order_provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView<OrderModel>(
      provider: orderProvider,
      itemBuilder: <OderModel>(context, index, model) {
        return OrderCard.fromModel(model: model);
      },
    );
  }
}
