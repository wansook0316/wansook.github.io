---
layout: post
title: "10: Lazy를 잘 안쓰는 이유"
category: "DV/iOS"
comments: true
tags: [iOS, "lazy"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "Lazy Property는 좋아보이나, 사실 많이 쓰지 않는다. 왜일까?"
---

* 장점
  * 객체 생성시, 해당 변수를 만들지 않기 때문에 시간이 적게 걸린다.
  * 자주 사용하지 않고, 사용하는 경우가 드물경우 사용하면 좋다.
* 단점
  * 대신 실제 해당 변수를 만들어 사용할 때, 생성하기 때문에 그 시점에서 속도저하가 일어난다.


자.. 그런데, 가장 큰 문제는 무엇일까?

![image](https://user-images.githubusercontent.com/37871541/128620249-9e67149c-0c16-4c8d-af9a-dfa84f8e748f.png){: .center}_not thread-safe_

* 애플 공식문서에 명시되어 있다.
* 다중 스레드에서 해당 변수에 접근했을 때, 한번만 초기화되는 것이 보장되지 않는다..
* 즉, 스레드 안전하지 않다는 것..!

그런데 왜 이렇게 만들었을까??

* [Make "lazy var" threadsafe](https://bugs.swift.org/browse/SR-1042)
* 해당 내용은 스레드 안전하게 만들어달라는 이슈이다.
* 그런데, 해당 의견에 대해서도 찬반이 있었다.
* 찬성
  * 동시성 프로그래밍을 할 때, lazy를 사용하는 것자체가 잘못된 방법이라고 생각하게 만든다.
  * 만약 lazy를 사용하고자 할 때, 스레드 안전하게 초기화하는 방법자체가 복잡하니, 제공하는 게 좋지 않나
* 반대
  * 결국 추가적인 로직이 들어가야 한다는 것임
  * 읽기를 수행할 때, 이걸 감시하는 값도 필요함
  * 동기화를 위한 추가적인 저장공간도 필요함
  * 결국 COst가 너무 높다!


둘다 일리가 있는 것 같지만 실력이 부족하여 반대의견을 제대로 이해하지 못했다.



# Reference
* [Swift의 lazy var](https://brunch.co.kr/@tilltue/71)
* [Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html)