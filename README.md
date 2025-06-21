# 🧾 kakaopay2025

Flutter 프로젝트에서 **카카오페이 단건결제(single payment)**를 구현한 예제입니다.

---

## 📺 YouTube 시연 영상  
[👉 YouTube 링크](여기에_유튜브_URL_붙여넣기)

---

## 📄 공식 문서  
- 카카오페이 단건결제 가이드:  
  🔗 https://developers.kakaopay.com/docs/payment/online/single-payment

---

## 🧩 사용한 Flutter 라이브러리

| 라이브러리 | 설명 | 링크 |
|------------|------|------|
| `http` | 카카오페이 API 통신 | [pub.dev/http](https://pub.dev/packages/http) |
| `url_launcher` | 외부 앱 실행 (`kakaotalk://` 등) | [pub.dev/url_launcher](https://pub.dev/packages/url_launcher) |
| `flutter_inappwebview` | 결제창 웹뷰 구현 | [pub.dev/flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview) |

---

## 📌 구현 흐름 요약

1. 결제 준비 API 호출 → 결제 URL 생성
2. 웹뷰(`InAppWebView`)로 결제 페이지 열기
3. 카카오톡 앱 실행 (`kakaotalk://` 스킴)
4. 결제 완료 후 `pg_token` 포함한 리디렉션 감지
5. 승인 API 호출 → 결제 완료 처리
6. 파이어베이스 호스팅을 통한 리디렉션 핸들링
