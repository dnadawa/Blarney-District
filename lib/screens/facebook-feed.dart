import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webview_flutter/webview_flutter.dart';

class FacebookFeed extends StatefulWidget {
  @override
  _FacebookFeedState createState() => _FacebookFeedState();
}

class _FacebookFeedState extends State<FacebookFeed> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'about:blank',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _controller = webViewController;
          String fileText = await rootBundle.loadString('images/feed.html');
          _controller.loadUrl(Uri.dataFromString(fileText,
                  mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
              .toString());
        },
      ),
    );
  }
}
