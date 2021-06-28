import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BindDishWidget extends StatefulWidget {
  final url;
  const BindDishWidget({this.url}) : super();

  @override
  _BindDishWidgetState createState() => _BindDishWidgetState();
}

class _BindDishWidgetState extends State<BindDishWidget> {
  WebViewController _controller;
  String _title = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text("蜂云智膳"),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios),
              onPressed: () => {Navigator.pop(context)},
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => {
                        // Navigator.pop(context)
                        // Navigator.popUntil(context, (route) => false)
                        // Navigator.popUntil(context, (route) => false)
                        Navigator.popUntil(
                            context,
                            (route) => (route.settings.name ?? '')
                                .startsWith('bind_page')),
                        Navigator.popUntil(
                            context,
                            (route) => !(route.settings.name ?? '')
                                .startsWith('qrcode_page'))
                      })
            ]),
        body: WebView(
          initialUrl: widget.url,
          //JS执行模式 是否允许JS执行
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            _controller = controller;
          },
          onPageFinished: (url) {
            _controller.evaluateJavascript("document.title").then((result) {
              setState(() {
                _title = result.replaceAll('"', '');
              });
            });
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith("myapp://")) {
              print("即将打开 ${request.url}");

              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          javascriptChannels: <JavascriptChannel>[
            JavascriptChannel(
                name: "share",
                onMessageReceived: (JavascriptMessage message) {
                  print("参数： ${message.message}");
                }),
          ].toSet(),
        ),
      ),
    );
  }
}
