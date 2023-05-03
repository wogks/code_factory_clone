import '../const/data.dart';

class DataUtils {
  static String pathToUrl(String value) {
    return 'http://$ip$value';
  }

  static List<String> listPathsUrls(List<String> paths) {
    //pathTourl에 집어넣어서 똑같은 박식으로 만들어서 리스트로 만들어서 리턴
    return paths.map((e) => pathToUrl(e)).toList();
  }
}
