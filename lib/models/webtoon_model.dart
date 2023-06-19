class WebtoonModel {
  final String title, thumb, id;

  // named constructure 이름이 있는 클래스 생성자
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
