import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/widget/loom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key, required this.loomEvent}) : super(key: key);

  final LoomEvent loomEvent;
  final String htmlText = """<html>
          <head></head>
          <body>
            <b>
              <div>1. *************</div>
              <div>2. *************</div>
              <div>3. *************</div>
              <div>4. *************</div>
            </b>
          </body>
          </html>""";

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0 * devicePixelRatio),
                //TODO change to standart app bar
                child: LoomAppBar(
                  loomEvent: loomEvent,
                  text: "FAQ",
                ),
              ),
              Expanded(
                child: WebView(
                  initialUrl: 'about:blank',
                  onWebViewCreated: (WebViewController webViewController) {
                    if (Platform.isAndroid) {
                      WebView.platform = SurfaceAndroidWebView();
                    }
                    webViewController.loadUrl(Uri.dataFromString(htmlText,
                            mimeType: 'text/html',
                            encoding: Encoding.getByName('utf-8'))
                        .toString());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
