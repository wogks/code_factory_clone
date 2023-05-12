import 'package:codfac/common/const/data.dart';
import 'package:codfac/common/secure_storage/secure_storage.dart';
import 'package:codfac/user/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(CustomIntercepter(
    storage: storage,
    ref: ref,
  ));

  return dio;
});

class CustomIntercepter extends Interceptor {
  final Ref ref;
  final FlutterSecureStorage storage;

  CustomIntercepter({
    required this.storage,
    required this.ref,
  });
//인터셉터의 기능
//1) 요청 보낼때 ~했을때를 개발자는 on을 사용한다
//요청이 보내질때마다 만약에 요청의 Header에 accessToken: true라는 값이 있다면
//실제 토큰을 가져와서 (storage에서) authorization : bearer $token으로 헤더를 변경한다
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      //헤더 삭제(트루값이있는)
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      //실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }
    return super.onRequest(options, handler);
  }

//2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');
    //하고싶은 작업이 있으면 한다
    return super.onResponse(response, handler);
  }
//3) 에러가 났을때

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    //401error(token error). 토큰을 재발급 받는 시도를 하고 토큰이 재발급 되면 다시 새로은 토큰으로 요청을 한다
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    //리프레쉬 토큰이 없으면 당연히 에러를 던진다
    if (refreshToken == null) {
      //에러를 던질때는 handler.reject를 사용한다
      return handler.reject(err);
    }
    final isStatus401 = err.response?.statusCode == 401;
    //요청을 보낸 패스가 토큰을 리프레쉬 하다가 에러가 난건지 확실하는것
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();
      try {
        final resp = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );
        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        //토큰 변경하기
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        //요청재전송
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } on DioError catch (e) {
        ref.read(authProvider.notifier).logout();
        return handler.reject(e);
      }
    }
    return handler.reject(err);
  }
}
