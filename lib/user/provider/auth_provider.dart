import 'package:codfac/user/model/user_model.dart';
import 'package:codfac/user/provider/user_me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  //splashScreen
  //앱을 처음 시작할때 토큰이 존재하는지 확인하고 로긴으로 보낼지 홈으로 보낼지 확인하는 과정
  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    final logginIn = state.location == '/login';
    //유저정보가 널인데 로그린중이면 그대로 로그인 페이지에 두고 만약에 로그인중이 아니라면 로그인페이지로 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }
    //user 가 null이 안미

    //UserModel
    //사용자 정보가 있는 상태면 로그인 중이거나 현재위치가 스플래쉬 스크린이면 홈으로 이동
    if (user is UserModel) {
      return logginIn || state.location == '/splash' ? '/' : null;
    }

    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }
    return null;
  }
}
