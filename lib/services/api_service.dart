import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    // API 요청이 처리돼서 응답을 반환할 때까지 기다려야한다.
    // 이런걸 async 프로그래밍이라고 한다.
    // 플러터에선 보통 http와같이 Future 타입과 같이 사용한다.
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // response.body에 커서를 갖다대면 String 타입이라고 나오는데 JSON 타입이기 때문에
      // JSON으로 변화해 줘야한다. 그래야 쉽게 꺼내 쓸 수 있다.
      print(response.body);

      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
