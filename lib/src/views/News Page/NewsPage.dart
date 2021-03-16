import 'package:diamond_fm_app/helpers/NewsHelper.dart';
import 'package:diamond_fm_app/models/article_model.dart';
import 'package:diamond_fm_app/src/components/LoadingCircle.dart';
import 'package:diamond_fm_app/src/components/MyScaffold.dart';
import 'package:diamond_fm_app/src/components/NewsCard.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  @override
  void initState() {
    super.initState();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    if (!mounted) {
      return;
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getNews();

    return MyScaffold(
      title: 'News',
      body: _loading
          ? loadingCircle()
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Text('News Publisher Website: https://diamondfm.net/news',
                    textAlign:TextAlign.center,
      style: TextStyle(color: Colors.white,fontSize:12),
                    ),
                      Text('News Publisher Contact Email: diamondfm88.7@gmail.com',
                    textAlign:TextAlign.center,

      style: TextStyle(color: Colors.white,fontSize:12),
                    ),
                    ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return NewsCard(article: articles[index]);
                    }),])
              ),
            ),
    );
  }
}
