import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String? _tid;

  bool isTestMode = true; // ✅ 테스트 CID 사용 여부 설정

  @override
  void initState() {
    super.initState();
  }

  Future<String?> _requestKakaoPay() async {
    final url =
        Uri.parse("https://open-api.kakaopay.com/online/v1/payment/ready");

    final bodyData = {
      "cid": isTestMode ? "TC0ONETIME" : "YOUR_REAL_CID",
      "partner_order_id": "order1234",
      "partner_user_id": "user1234",
      "item_name": "강아지옷",
      "quantity": "1",
      "total_amount": "12000",
      "tax_free_amount": "0",
      "approval_url": "https://developers.kakao.com/success",
      "fail_url": "https://developers.kakao.com/fail",
      "cancel_url": "https://developers.kakao.com/cancel"
    };

    final response = await http.post(
      url,
      headers: {
        "Authorization": "SECRET_KEY YOUR_SCERET_CODE",
        "Content-Type": "application/json",
      },
      body: json.encode(bodyData),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("✅ response data ${data}");
      final redirectMobileUrl = data['next_redirect_mobile_url'];
      _tid = data['tid'];
      _openWebView(redirectMobileUrl);
    } else {
      print("❌ 카카오페이 오류: ${response.body}");
    }

    return null;
  }

  void _openWebView(String url) {
    print("✅ _openWebView url $url");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text("카카오페이 결제")),
          body: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(url)),
            onLoadStart: (controller, url) {
              print("🌍 onLoadStart URL: $url");
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final uri = navigationAction.request.url;
              if (uri == null) return NavigationActionPolicy.ALLOW;

              final urlStr = uri.toString();
              print("🔍 Intercepted URL: $urlStr");

              // ✅ kakaotalk:// 같은 앱 스킴 감지
              if (urlStr.startsWith("kakaotalk://")) {
                try {
                  // launch() 대신 launchUrl() 사용
                  final uri = Uri.parse(urlStr);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                    return NavigationActionPolicy.CANCEL;
                  } else {
                    print("❌ 카카오톡 앱 실행 실패");
                  }
                } catch (e) {
                  print("❌ intent 처리 오류: $e");
                }
              }

              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, uri) {
              if (uri == null) return;

              final uriStr = uri.toString();
              print("🛰️ onLoadStop URL: $uriStr");

              if (uri.queryParameters.containsKey("pg_token")) {
                final pgToken = uri.queryParameters["pg_token"]!;
                print("✅ pg_token 감지됨: $pgToken");
                Navigator.pop(context);
                _approveKakaoPay(pgToken);
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> _approveKakaoPay(String pgToken) async {
    final url =
        Uri.parse("https://open-api.kakaopay.com/online/v1/payment/approve");
    print(
        "🧾 Approve Params: cid=${isTestMode ? "TC0ONETIME" : "REAL"}, tid=$_tid, pg_token=$pgToken");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "SECRET_KEY YOUR_SCERET_CODE",
        "Content-Type": "application/json",
      },
      body: json.encode({
        "cid": isTestMode ? "TC0ONETIME" : "YOUR_REAL_CID",
        "tid": _tid!,
        "partner_order_id": "order1234",
        "partner_user_id": "user1234",
        "pg_token": pgToken,
      }),
    );

    if (response.statusCode == 200) {
      print("🎉 결제 승인 완료: ${response.body}");
      _showResultDialog("결제 성공");
    } else {
      print("❌ 결제 승인 실패: ${response.body}");
      _showResultDialog("결제 실패");
    }
  }

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("확인"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Background image
        Positioned.fill(
          child: Image.asset(
            'lib/images/Products.png',
            fit: BoxFit.cover,
          ),
        ),
        // Button image at the bottom with onTap
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: GestureDetector(
              onTap: _requestKakaoPay,
              child: Image.asset(
                'lib/images/Bottom.png',
                width: 300,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
