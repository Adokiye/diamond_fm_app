import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsArticleView extends StatefulWidget {
  final String articleUrl;
  NewsArticleView({this.articleUrl});
  @override
  _NewsArticleViewState createState() => _NewsArticleViewState();
}

class _NewsArticleViewState extends State<NewsArticleView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //leading: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.lightGreenAccent[200],
        elevation: 8,
        title: Text(
          'News',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.articleUrl,
          onWebViewCreated: ((WebViewController webViewController) {
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
