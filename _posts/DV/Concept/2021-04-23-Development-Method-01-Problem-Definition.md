---
layout: post
title: "01: Problem Definition"
category: "DV/Concept"
comments: true
tags: [Concept, "Development Method"]
feature-img: "assets/img/78.jpg"
feature-title: ""
use_math: true
series: "Development Method"
summary: "언어, 프레임워크는 도구다. 가장 중요한 문제 정의하는 방법을 알아보자."
---

> 꾸준히 공부하지 않으면 망해버리는 분야.

> 각오를 단단히 잡고 해야한다.


# 문제의 분류

* 문제를 푸는 동기?
  * 시켜서
  * 자발적으로
* 어떤 방식으로 구현할 거야?
  * 생코딩 (from scratch)
  * 플랫폼 위에서 (open source)
* 하드웨어 의존성 - 소프트웨어 방향성을 알려줌
  * 있다. - 개발 환경이 정해진다.
    * Arduino - ATmega, C, Sketch IDE
    * RAspberryPi ARM Processor, GPIO, USB
    * CUDA - NVIDIA GPU, C/C++/Fortran
  * 없다.
* 기한은 언제까지인가?
  * 졸업 논문
  * 공모전
  * 서비스 배포 시기
* 필요한 성능은 얼마인가? -> Key poerformance Indexes (KPI) 지표가 필요함.
  * 인명 피해가 발생할 수 있는 경우
  * 응답 시간
  * 수용성
* Case Study
  * 웹 서버 개발
    * C++ & Proxygen (platform dependant : 해당 플랫폼이 있어야 함)
      * Facebook이 만듦
      * 장점 : 어떤 것보다 빠르다. 10배 이상 빠를 수도 있다.
      * 단점 : 어렵다.
    * Python & Django (platform independant : 없어도 웹서버 가능, http 내장)
    * Javascript & Node.js (platform independant)
      * 웹 클라이언트를 위해 만든 언어, 이제는 서버 프로그래밍까지.
    * Apache/Nginx (tools, non-programming)
      * 개발을 하지 않고도 만들 수 있다. 웹 서버를 그냥 설치해
  * 실제 직장이라면?
    * Due date? : 내가 익숙한 것, 혹은 내 능력에 맞춰 당장할 수 있는 것
    * 성능? : 고민, 정량적으로 평가 (KPI)


각각의 평가 방법에 따라 순위가 변경된다. 언어는 사용하는 분야에 따라 달라진다는 것을 알 수 있다. 근데 아무리 생각해도 파이썬은 너무 느리다.
![image](https://user-images.githubusercontent.com/37871541/116561553-6525b000-a93d-11eb-9b07-88a0f6dd5e75.png){: .center-small}
![image](https://user-images.githubusercontent.com/37871541/116561658-7a9ada00-a93d-11eb-9ed2-aaf246ba6385.png){: .center-small}
![image](https://user-images.githubusercontent.com/37871541/116562007-c5b4ed00-a93d-11eb-867e-9e84d879868e.png){: .center-small}


* 모바일 개발은 어떻게 할까?
  * Native (iOS, Android)
    * 성능 보장
    * 두개 이상 플랫폼? 고민
    * iOS
      * 매킨토시, xcode
      * 배포 개복잡..
    * Android
      * material design
      * kotlin, java
      * 그냥 apk 배포
  * Cross Platform (HTML/CSS/Javascript)
    * 개발 속도, 인력 감축
    * 성능 약화
    * Electron - 데스크톱 앱
    * Cordova - 앱개발

* 아니 그래서 어떻게 판단해야 하지? -> KPI 기반 검증
  * Due
  * Performance
  * Cost
  * Man-Power

![image](https://user-images.githubusercontent.com/37871541/116563651-2db80300-a93f-11eb-9522-b0517b49ee79.png){: .center}
