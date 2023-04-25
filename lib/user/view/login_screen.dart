import 'dart:convert';

import 'package:codfac/common/const/color.dart';
import 'package:codfac/common/const/data.dart';
import 'package:codfac/common/layout/default_layout.dart';
import 'package:codfac/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/component/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userName = '';
  String passord = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
      child: SingleChildScrollView(
        //키보드를 치다가 위아래도 스크롤 하면 키보드가 자동으로 사라짐
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                const SizedBox(height: 16),
                const _SubTitle(),
                Image.asset(
                  '/Users/SIMBAAT/Desktop/simbaat/codfac/codfac/asset/img/misc/logo.png',
                  //미디어 쿼리의 3분의2
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요',
                  onChanged: (String value) {
                    userName = value;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  onChanged: (value) {
                    passord = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final rawString = '$userName:$passord';
                    //다트에서 base64로 인코딩 하는법
                    //string을넣고 string을 반환받겠다
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    String token = stringToBase64.encode(rawString);

                    final resp = await dio.post(
                      'http://$ip/auth/login',
                      options: Options(
                        //일반 토큰일때는 베이직
                        headers: {'authorization': 'Basic $token'},
                      ),
                    );
                    print(resp.data);
                    final refreshToken = resp.data['refreshToken'];
                    final acsessToken = resp.data['accessToken'];
                    await storage.write(
                        key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await storage.write(
                        key: ACCESS_TOKEN_KEY, value: acsessToken);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RootTab(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: const Text('로그인'),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('회원가입'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
