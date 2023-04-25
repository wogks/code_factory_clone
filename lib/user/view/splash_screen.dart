// ignore_for_file: use_build_context_synchronously

import 'package:codfac/common/const/color.dart';
import 'package:codfac/common/const/data.dart';
import 'package:codfac/common/layout/default_layout.dart';
import 'package:codfac/common/view/root_tab.dart';
import 'package:codfac/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //deleteToken();
    checkToken();
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    //이닛스테이트에서는 어웨잇이 안되기 때문에 일반함수를 만들어서 넣는다
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final dio = Dio();
    try {
      final resp = await dio.post(
        'http://$ip/auth/token',
        options: Options(
          //리프레쉬 토큰일때는 베어러
          headers: {'authorization': 'Bearer $refreshToken'},
        ),
      );
      await storage.write(
          key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const RootTab()),
          (route) => false);
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgoundColor: PRIMARY_COLOR,
      child: SizedBox(
        // 너비를 최대로 하면 자동으로 가운데 정렬이 된다
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              '/Users/SIMBAAT/Desktop/simbaat/codfac/codfac/asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 16,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
