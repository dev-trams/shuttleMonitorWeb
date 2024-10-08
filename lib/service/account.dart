import 'package:http/http.dart' as http;

Future getAccountFetch() async {
  String url = 'http://core.apis.ctrls-studio.com:27016/pwdsv';
  Uri uri = Uri.parse(url);
  return http.get(uri);
}
