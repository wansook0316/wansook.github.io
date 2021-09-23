---
layout: post
title: "14: RunLoop"
category: "DV/iOS"
comments: true
tags: [iOS, "RunLoop"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "RunLoop란? 어떻게 이벤트를 처리하도록 설계되어있는지 알아보자."
---

# RunLoop란?

* 목적
  * 스레드를 바쁘게 만들기 위한 것
  * 할일이 있으면 바쁘게 돌도록, 없으면 쉬도록
* 런루프 관리는 자동이 아니다.
* 적절한 시점에 런루프를 시작해줘야 한다.
* 애플리케이션을 시작하면 해당 애플리케이션의 main thread의 런루프는 자동으로 생성된다. 명시적으로 작동시킬 필요가 없다.
* 두번째 스레드의 런루프를 실행시켜야 한다면 명시적으로 작동시켜줘야 한다.


# 개요



* 이벤트 핸들러이다.
* 또한 Timer까지 처리한다.
* 모든 스레드는 각각의 Run Loop를 갖는다.
* 하지만 자동으로 실행되는 것은 아니다.
  * 실행은 프로그래머의 몫
  * Main runLoop는 예외
    * Main의 경우 프레임워크 차원에서 자동으로 런루프를 설정하고 실행시킨다.
    * 그래서 일일히 runloop를 실행시켜주지 않아도 되었던 것
* [Foundation - Processes and Threads](https://developer.apple.com/documentation/foundation/processes_and_threads) 여기에 보면, Foundation의 class 변수로 접근 가능함

```swift
class RunLoop: NSObject {
    class var current: RunLoop { get } 
}
```

* 이런식으로 선언되어 있기 때문에, 현재 동작하고 있는 코드내에서, `RunLoop.current` 를 통해 현재 작동하고 있는 스레드의 런루프에 접근 가능


# 작동 원리

![image](https://user-images.githubusercontent.com/37871541/134439086-e0c65f82-8b23-4abb-b20f-6074e1825d24.png){: .center-small}_Structure of a run loop and its sources_

* 이벤트 수신
  * Input sources
    * 다른 스레드나, application으로부터 온 비동기 이벤트 전달
  * Timer
    * 예약된 시간, 반복 간격으로 발생하는 동기 이벤트 전달
* 실행
  * 위의 노란색 루프가 한번의 실행임
  * 이벤트를 수신한 것을 쌓아두고 한번 실행하면 이 이벤트들을 처리함
  * 루프라는 이름을 달고있는 것과 달리 **주기적으로 실행하지 않음 **
  * 그래서 명시적으로 for, while과 같이 실행을 반복시켜주어야 함
  * 즉, 한번 실행되고 나면 그대로 대기한다는 것..
  * 애초에 목적이 일이 있으면 실행, 없으면 대기라서 이렇게 설계한 듯 하다.


# 프로그램의 실행과 런루프

![image](https://user-images.githubusercontent.com/37871541/134481305-bd166a3a-bd51-4347-9902-b74eb66110e4.png){: .center}_실행 흐름_

* 런루프가 보인다.
* 일단 런루프는, `UIApplicationMain()` 함수를 통해 메인 런루프가 시작된다.
* 같은 목적으로 OSX, iOS에는 두개의 런루프를 가진다.
  * CFRunLoopRef
    * 스레드 안전하다.
  * NSRunLoop
    * CFRunLoopRef의 wrapper이다.
    * 스레드 안전하지 않다.
      * 즉 작업을 하는 도중에 해당 코드블락을 다른 스레드에서 접근할 수 있다.
* 앞에서도 말했지만 런루프의 동작은 프로그래머가 해주어야 한다.
* 하지만 런루프를 실행한 경우, 다른 동작이 불가하기 때문에, 다음과 같은 사용법으로 활용해야 한다.

```swift
var isRunning = false
do {
  isRunning = RunLoop.current.run(mode: .default, before: .distantFuture)
} while (isRunning)
```

## 사용 예

* 포트 또는 사용자 정의 입력 소스를 사용하여 다른 스레드와 통신하는 경우
  * 이해를 하지 못했다.
* 스레드 타이머 사용
* 스레드를 주기적으로 작동시키고 싶은 경우

# Reference

* [RunLoops](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/RunLoopManagement/RunLoopManagement.html)
* [Foundation - Processes and Threads](https://developer.apple.com/documentation/foundation/processes_and_threads)
* [iOS Run Loop, What Why When](https://prafullkumar77.medium.com/ios-run-loop-what-why-when-7febead400b7)