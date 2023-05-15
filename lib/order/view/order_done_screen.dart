import 'package:codfac/common/layout/default_layout.dart';
import 'package:codfac/common/view/root_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderDoneScreen extends StatelessWidget {
  static String routeName = 'orderDone';
  const OrderDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.thumb_up_alt_outlined),
          ElevatedButton(
              onPressed: () {
                context.goNamed(RootTab.routeName);
              },
              child: const Text('홈으로'))
        ],
      ),
    );
  }
}
