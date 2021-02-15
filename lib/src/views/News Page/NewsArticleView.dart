import 'package:diamond_fm_app/models/article_model.dart';
import 'package:flutter/material.dart';

class NewsArticleView extends StatefulWidget {
  final ArticleModel article;
  NewsArticleView({@required this.article});
  @override
  _NewsArticleViewState createState() => _NewsArticleViewState();
}

class _NewsArticleViewState extends State<NewsArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //leading: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFCEFF5A),
        elevation: 8,
        title: Text(
          'News',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
        child: Container(
          color: Color(0xFF121219),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(widget.article.image)),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  widget.article.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xFFCEFF5A),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${widget.article.body}',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
