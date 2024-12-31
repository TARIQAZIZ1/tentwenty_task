import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TrailerPlayerScreen extends StatefulWidget {
  final int id;

  const TrailerPlayerScreen({super.key, required this.id});

  @override
  TrailerPlayerScreenState createState() => TrailerPlayerScreenState();
}

class TrailerPlayerScreenState extends State<TrailerPlayerScreen> {
  late InAppWebViewController webViewController;

  late Future<void> _initializeWebView;

  @override
  void initState() {
    super.initState();
    _initializeWebView = _initializeWebViewAsync();
  }

  Future<void> _initializeWebViewAsync() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trailer Player'),
      ),
      body: FutureBuilder<void>(
        future: _initializeWebView,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return InAppWebView(
              initialUrlRequest: URLRequest(
                url:
                    WebUri("https://www.youtube.com/watch?v=${widget.id}"),
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                debugPrint("WebView started loading: $url");
              },
              onLoadStop: (controller, url) async {
                debugPrint("WebView finished loading: $url");
              },
              onProgressChanged: (controller, progress) {
                debugPrint("WebView loading progress: $progress%");
              },
            );
          }
        },
      ),
    );
  }
}
