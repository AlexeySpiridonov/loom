import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/datas/html.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key, required this.loomEvent}) : super(key: key);

  final LoomEvent loomEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: SvgPicture.asset("assets/images/back.svg"),
            onPressed: () => context.read<LoomBloc>().add(loomEvent),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.faq,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
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
