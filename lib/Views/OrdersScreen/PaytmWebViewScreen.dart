import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Views/CartScreen/OrderPlacedScreen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaytmWebViewScreen extends StatefulWidget {
  final String? paymentUrl;
  final String? successUrl;
  final String? failedUrl;
  final String? orderCode;

  PaytmWebViewScreen(
      {this.paymentUrl, this.failedUrl, this.successUrl, this.orderCode});

  @override
  _PaytmWebViewScreenState createState() => _PaytmWebViewScreenState();
}

class _PaytmWebViewScreenState extends State<PaytmWebViewScreen> {
  late WebViewController webViewController;
  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print("onPageStarted url : $url");
            if (url.contains(widget.successUrl!)) {
              Get.offAll(OrderPlacedScreen(
                oderId: widget.orderCode,
              ));
            }
          },
          onPageFinished: (String url) {
            print("onPageFinished url : $url");
            if (url.contains(widget.failedUrl!)) {
              Get.back();
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            print('allowing navigation to $request');
            if (request.url.startsWith(widget.successUrl!)) {
              Get.offAll(OrderPlacedScreen(
                oderId: widget.orderCode,
              ));
            }
            if (request.url.startsWith(widget.failedUrl!)) {
              Get.back();
              Get.snackbar(
                "Sorry!",
                "Payment failed",
                backgroundColor: Colors.white,
                icon: Icon(
                  Icons.error_outline_sharp,
                  color: Colors.red,
                ),
                titleText: Text(
                  "Sorry!",
                  style: TextStyle(
                    fontFamily:
                    'Poppins', // Replace with the desired font family for the title
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                messageText: Text(
                  "Payment Failed",
                  style: TextStyle(
                    fontFamily:
                    'Poppins', // Replace with the desired font family for the message
                  ),
                ),
              );
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..enableZoom(true)
      ..loadRequest(Uri.parse(widget.paymentUrl ?? ''));
    // Enable hybrid composition.
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: webViewController),
      ),
    );
  }
}
