import 'package:codfac/common/const/data.dart';
import 'package:codfac/common/secure_storage/secure_storage.dart';
import 'package:codfac/user/model/user_model.dart';
import 'package:codfac/user/repository/auth_repository.dart';
import 'package:codfac/user/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final userMeProvider = StateNotifierProvider<UserMeStateNotifier,UserModelBase?>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final userMeRepository = ref.watch(userMeRepositoryProvider);
    final storage = ref.watch(secureStorageProvider);
    return UserMeStateNotifier(
      authRepository: authRepository,
      repository: userMeRepository,
      storage: storage,
    );
  },
);

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    getMe();
  }
  getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }
    final resp = await repository.getMe();

    state = resp;
  }

  Future<UserModelBase> login({
    required String userName,
    required String password,
  }) async {
    try {
      state = UserModelLoading();

      final resp = await authRepository.login(
        userName: userName,
        password: password,
      );

      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      final userResp = await repository.getMe();
      state = userResp;

      return userResp;
    } catch (e) {
      state = UserModelError(message: '로그인 실패');
      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;

    //동시에 실행
    await Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY)
    ]);
  }
}
