import 'package:codfac/common/const/data.dart';
import 'package:codfac/common/dio/dio.dart';
import 'package:codfac/common/model/login_response.dart';
import 'package:codfac/common/model/token_response.dart';
import 'package:codfac/common/utils/data_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return AuthRepository(dio: dio, baseUrl: 'http://$ip/auth');
  },
);

class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });
  Future<LoginResponse> login({
    required String userName,
    required String password,
  }) async {
    final serialized = DataUtils.plainTobase64('$userName:$password');

    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {
          'authorization': 'Basic $serialized',
        },
      ),
    );

    return LoginResponse.fromJson(
      resp.data,
    );
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post(
      '$baseUrl/token',
      options: Options(headers: {'refreshToken': 'true'}),
    );
    return TokenResponse.fromJson(resp.data);
  }
}
