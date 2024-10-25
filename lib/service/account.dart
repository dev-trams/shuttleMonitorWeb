import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shuttle_monitor_web/service/model/account.dart';

Future getAccountFetch() async {
  String url = 'https://core.apis.ctrls-studio.com/pwdsv';
  Uri uri = Uri.parse(url);

  final http.Response response = await http.get(uri);

  if (response.statusCode == 200) {
    try {
      // JSON 배열을 디코딩합니다.
      List<dynamic> responseData = json.decode(response.body);

      // Account 객체 리스트로 변환
      List<Account> accountData =
          responseData.map((data) => Account.fromJson(data)).toList();
      return accountData;
    } catch (e) {
      print('Error parsing JSON: $e');
      return null;
    }
  } else {
    print(
        'Failed to fetch data from server with status: ${response.statusCode}');
    return null;
  }
}
