import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub WebView',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const WebViewPage(),
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  static const String _targetUrl = 'https://github.com/rubyf2e/';

  late final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(_targetUrl));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('rubyf2e GitHub'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: kIsWeb
          ? const _WebFallback(targetUrl: _targetUrl)
          : WebViewWidget(controller: _controller),
    );
  }
}

class _WebFallback extends StatelessWidget {
  const _WebFallback({required this.targetUrl});

  final String targetUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Web 平台不支援內嵌 WebView。',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            SelectableText(
              targetUrl,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              '請改用 Android/iOS/macOS 執行，或直接在瀏覽器開啟此連結。',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
