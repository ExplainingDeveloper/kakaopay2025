# 🧾 kakaopay2025

Flutter 프로젝트에서 **카카오페이 단건결제(single payment)**를 구현한 예제입니다.

---

## 📺 YouTube 시연 영상  
[👉 YouTube 링크](https://youtu.be/g7348GhQ-wY)

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

## 파이어베이스 호스팅 명령어
1. npm install -g firebase-tools
2. firebase login
3. firebase init hosting

---
## 📌 구현 흐름 요약

1. 결제 준비 API 호출 → 결제 URL 생성
2. 웹뷰(`InAppWebView`)로 결제 페이지 열기
3. 카카오톡 앱 실행 (`kakaotalk://` 스킴)
4. 결제 완료 후 `pg_token` 포함한 리디렉션 감지
5. 승인 API 호출 → 결제 완료 처리
6. 파이어베이스 호스팅을 통한 리디렉션 핸들링

---
## 🤗 저를 응원해주세요

튜토리얼을 만드는 데는 **많은 시간과 정성**이 들어갑니다.  
이 프로젝트가 도움이 되셨다면, 커피 한 잔으로 응원해주세요!

<a href="https://buymeacoffee.com/codewithsora" target="_blank">
  <img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174">
</a>

작은 응원이 큰 힘이 됩니다. 감사합니다! 🙇

---
## 🎥 YouTube Tutorial

This code is part of my **KakaoPay Flutter Single Payment Integration** tutorial. Watch the step-by-step guide on my channel to understand how it works and see it in action:  
👉 [Watch the Tutorial](https://youtu.be/g7348GhQ-wY)

---

## 🤝 Support My Work

Creating detailed technical tutorials takes time, effort, and coffee ☕.  
If this project helped you, please consider supporting me:

<a href="https://buymeacoffee.com/codewithsora" target="_blank">
  <img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174">
</a>

Your support allows me to keep producing high-quality, free content for the developer community.

---

## 📄 License

This project is licensed under the **MIT License**.  
Feel free to use, modify, and share it — but please credit the original work.

---

## 🌟 How You Can Help

If this project or video helped you:

1. 🌟 **Star this repository** on GitHub.  
2. 💬 **Leave a comment or feedback.**  
3. 📢 **Share the video or code with your community.**

Thank you! 🙏

---
