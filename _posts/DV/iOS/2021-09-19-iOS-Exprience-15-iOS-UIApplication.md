---
layout: post
title: "15: UIApplication"
category: "DV/iOS"
comments: true
tags: [iOS, "UIApplication"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "UIApplication란? 무엇을 담당하는 녀석일까?"
---

# UIApplication란?

![image](https://user-images.githubusercontent.com/37871541/134481305-bd166a3a-bd51-4347-9902-b74eb66110e4.png){: .center}_실행 흐름_


> iOS앱을 구동하기 위한 조정과 중앙 집중식 제어를 담당하는 곳

* 모든 iOS 앱에는 딱 하나의 UIApplication 인스턴스가 존재한다.
* 앱이 시작되면 `UIApplicationMain()`을 호출한다.
* 싱글톤이기 때문에 `shared` 메서드로 접근이 가능하다.
* 사용자 이벤트 초기 라우팅을 처리하는 것이 중요한 역할이다.
* 즉, 이벤트가 들어왔을 때, 해당 타겟으로 보내는 시점을 관장한다.
  * 터치이벤트 -> UIApplication이 받음 -> UIControl 객체에 전달 -> 최종 대상으로 전달
* 런타임 이벤트에 대응할 수 있다. (UIApplicationDelegate)
  * 앱 시작
  * 메모리 부족 경고
  * 앱 종료
  * 터치 이벤트 일시 중지 (beginIgnoringInteractionEvents)
  * 원격 알림 등록 (registerForRemoteNotifications)
  * undo-redo UI 트리거 (applicationSupportsShakeToEdit)
  * URL scheme을 다루도록 설치된 앱이 등록되었는지 확인(canOpenURL:)
  * 백그라운드에서 작업을 완료할 수 있도록 앱 실행을 확장(beginBackgroundTaskWithExpirationHandler:, beginBackgroundTaskWithName:expirationHandler:)
  * 로컬 알림 스케줄링, 취소 (scheduleLocalNotification:, cancelLocalNotification:)
  * 원격 제어 이벤트 수신 조정(beginReceivingRemoteControlEvents, endReceivingRemoteControlEvents)
  * app-level 상태 복원 작업 (methods in the Managing the State Restoration Behavior task group)
* 그래서 AppDelegate에서 이를 처리할 수 있는 것.

# Reference

* [Threading Programming Guide - RunLoop](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/RunLoopManagement/RunLoopManagement.html)