import 'dart:convert';

import '../const/data.dart';

class DataUtils {
  static DateTime stringToDateTime(String value) {
    return DateTime.parse(value);
  }

  static String pathToUrl(String value) {
    return 'http://$ip$value';
  }

  static List<String> listPathsUrls(List paths) {
    //pathTourl에 집어넣어서 똑같은 박식으로 만들어서 리스트로 만들어서 리턴
    return paths.map((e) => pathToUrl(e)).toList();
  }

  static String plainTobase64(String plain) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encoded = stringToBase64.encode(plain);

    return encoded;
  }
}
