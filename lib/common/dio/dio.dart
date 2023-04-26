import 'package:codfac/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomIntercepter extends Interceptor {
  final FlutterSecureStorage storage;

  CustomIntercepter({required this.storage});
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
//3) 에러가 났을때
}
