import 'dart:convert';
import 'package:diamond_fm_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url = 'https://diamondfm.net/get-news';
    //'http://newsapi.org/v2/top-headlines?country=ng&apiKey=f34a971b04f6412aaf0655956268448e';
    var response = await http.post(url, body: {
      'key': 'e4cdb181895402c964f257b6492a226b',
    });
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      jsonData.forEach((number, element) {
        if (element['image'] != null && element['title'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              body: element['body'],
              id: int.parse(element['id']),
              image: Uri.decodeFull(element['image']),
              date: element['publishedAt'] == null
                  ? DateTime.now()
                  : DateTime.parse(element['publishedAt']));
          news.add(articleModel);
        }
      });
    }
  }
}
