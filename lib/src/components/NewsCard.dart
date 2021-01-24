import 'package:diamond_fm_app/models/article_model.dart';
import 'package:diamond_fm_app/src/views/News%20Page/NewsArticleView.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final ArticleModel article;
  NewsCard({@required this.article});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color(0xFF302B54),
      child: GestureDetector(
        onTap: () {
          //TODO
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => NewsArticleView(
          //               articleUrl: url,
          //             )));
        },
        child: Container(
          margin: EdgeInsets.all(16),
          //padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(article.image)),
              Text(
                article.title,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.lightGreenAccent[200],
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '${article.body.characters.take(60)}...',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              FlatButton(
                color: Colors.black87,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsArticleView(
                                article: article,
                              )));
                },
                child: Text(
                  'Read More',
                  style: TextStyle(color: Color(0xFFB64100)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
