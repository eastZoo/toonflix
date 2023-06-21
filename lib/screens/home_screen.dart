import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // FutureBuilder 는 stateless위젯에서 Future타입을 기다렸다가 빌드해준다.!!
      body: FutureBuilder(
        // future에 받아와야할 비동기 데이터를 적어주면 보이진 않지만 자동 await
        future: webtoons,
        //snapshot을 통해 상태를 알 수 있다.( error, data, state,,,)
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //ListView.builder 는 모든 아이템을 한 번에 만드는 대신 만들려는 아이템에 itemBuilder 함수를 실행
            // 그러면 여기서 build 되는 아이템의 인덱스에 접근할 수 있는 것.
            // 사용자가 보고있을때 만 만들어짐.

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                print(index);
                var webtoon = snapshot.data![index];
                return Text(webtoon.title);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
