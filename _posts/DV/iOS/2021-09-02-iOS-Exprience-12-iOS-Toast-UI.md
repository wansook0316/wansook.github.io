---
layout: post
title: "12: Toast UI에 대한 생각"
category: "DV/iOS"
comments: true
tags: [iOS, "Toast UI"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "Toast UI란?, 그리고 좋을 걸까?"
---

# Toast UI란?

![image](https://user-images.githubusercontent.com/37871541/131846445-07f55d89-9d38-49fa-977d-9bcc8095554c.png){: .center-small}_Toast UI_

* [토스트 메시지 개요](https://developer.android.com/guide/topics/ui/notifiers/toasts?hl=ko)
* 아래에서 살짝쿵 올라오는 녀석
* 찾아보니, 안드로이드에서도 스낵바를 사용하라 한다. (foreground에 있을 때)
* 백그라운드에 있으면 알림을 사용하라 한다.
* 결국 이녀석은 사장된 놈으로 보인다.
  * 그런데 찾아보니, 스낵바라는 녀석도 음 크게 달라보이지는 않는다.


# iOS

* 일단 iOS에는 없다. 왜 없을까
* 사용자 경험을 방해한다는 것이 핵심.
  * 이게 계속 가려지면 짜증나잖아? 그러니까 최소한으로 하라는 것.
* 이러한 맥락에서 본다면 토스트는 그닥 좋지 않은 UI 요소라 할 수 있겠다.
* 역시 애플은 간단한 걸 좋아한다.
* 콘텐츠 영역에는 다른 걸 안 두겠다는 것.