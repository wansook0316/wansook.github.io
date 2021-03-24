---
layout: post
title: "언어별 특징 비교"
category: "DV/Tips"
comments: true
tags: [Tips, "언어비교"]
feature-img: "assets/img/73.jpg"
feature-title: ""
use_math: true
series: "Language Comparison"
summary: "언어별 특징을 비교해보자. 후에 항목이 길어지면 나눠서 배포"
---

# Java

## Author

James Gosling

## Features

- 객체 지향 프로그래밍 언어
- 이름의 유래는 너무 설이 많다. 여튼 대충 지었다.
- 웹 애플리케이션 개발에 가장 많이 사용하는 언어 중 하나이다.
- 모바일 기기용 소프트웨어 개발에도 사용되고 있다.
- 유닉스 기반 배경의 개발자들이 만들었다. 그래서 문법이 C와 비슷하다.
- 컴파일 언어(ex C, C++)과 궤를 달리한다. 그 이유는 컴파일된 코드가 **플랫폼 독립**이기 때문이다.
- 컴파일 후에 바이트 코드라는 특수한 바이너리 형태로 변환하는데, 이 코드를 실행하기 위해서는 JVM이 필요하다. JVM을 어떠한 환경에서도 설치하기만 한다면 어느 플랫폼에서든 동일한 형태로 실행시킬 수 있다. 이러한 특징은 웹 어플리케이션(cpu, os, 브라우저 상관 없이 언제나 접속가능)에 맞아떨어져 폭발적인 인기를 끌었다.
- JVM 기반의 프로젝트에서는 하나의 언어만을 고집하지 않는다. 함수형 언어가 유리(최근 유행하는 빅데이터 등)한 부분은 Scala로 작업하며, 견고한 인터페이스와 대규모 통합이 필요한 곳은 Java로 작업한 뒤 이들을 서로 합쳐서 운영하는 게 가능하다. (Java에서 만든 객체를 Scala에서 그대로 사용할 수 있다.) 안드로이드 쪽에서는 크리티컬하지 않은 부분부터 Kotlin으로 코드를 교체하는 경우도 많아지고 있다.

## Reason

- 플랫폼에 독립적인 언어를 만들자.
- Write Once run Anywhere

## Pros

- Spring이라는 매우 좋은 웹 프레임워크가 있다.
- Android에도 사용할 수 있다.
- 플랫폼 독립적이다.
- 수많은 개발자와 레퍼런스
- 구인의 용이성
- 높은 생산성 (C/c++ 대비)
- 기기 호환성
- 안정성
- 소스코드 가독성

## Cons

- 속도가 느린편이다 (C/C++ 대비)
- JVM 로딩 속도 문제
- 가상 머신 바이트 코드 실행 속도 문제
- 예외 처리의 불편함
- 소스코드 길이가 길다..
- 명사형 사고 강제

## Famous open source

- Spring framework
- kotlin(JVM 구동가능 언어)

# Javascript

## Author

브랜든 아이크 (Brendan Eich)

## Features

- 웹 브라우저에 인터프리터가 내장되어 있다.
- 스크립트 언어
- C언어의 잔재가 남아있다.
- 멀티 패러다임 언어이다. 함수형, 명령형, 객체지향형 언어이다.
- 함수형 패러다임을 따르기 때문에 클로저를 빈번하게 사용한다.

## Reason

- 고수준 추상화 언어좀 만들어보자. 10일만에 만들어와. 해서 만들어졌다.
- 웹 페이지에 효과를 주거나 기능을 향상시키는 목적으로 사용

## Pros

- Json을 가지고 있다!
- 비동기 프로그래밍에 유리하다. → Node.js의 등장
- 무한히 많은 라이브러리가 생성중, pc용, 모바일용, 게임등 방대한 분야에서 발전이 이루어지고 있어 전망이 밝다.
- 확장성이 매우 높다.

## Cons

- 코드 이해를 할 떄 골치아프다. 비동기이기 때문
- 싱글 스레드이다. cpu작업이 많이 필요한 작업의 경우 비효율적이다.
- 콜백 지옥에 빠질 수 있다.
- 버전에 따라 되고 안되고가 너무 많다. 타입이 명시되어 있지 않다. → Typescript

## Famous open source

- React
- Vue
- Electron
- Node.js
- AngularJS
- jQuery

# Python

## Author

귀도 반 로섬(Guido van Rossum).

## Features

- 이름은 즐겨보던 코미디 그룹에서 따왔다.
- 실행할 수 있는 의사 코드 → 굉장히 쉽다.
- Write Once, Read Infinity

## Reason

- 크리스마스엔 역시 창조지. 심심해서 만든 프로그래밍 언어이다.
- "가장 아름다운 하나의 답이 존재한다"를 기본으로 하고 있다.
- 순수 객체 지향 언어이다. 원시 타입이 존재하지 않는다.
- 반복 가능한 객체(itarable)을 제공한다.
- [PEP20](https://zetawiki.com/wiki/PEP_20_-_%EC%A0%A0_%EC%98%A4%EB%B8%8C_%ED%8C%8C%EC%9D%B4%EC%8D%AC)을 보면 Python의 철학을 알 수 있다.


## Pros

- 코드가 깔끔하고 이해하기 좋다.
- 높은 생산성
- 낮은 난이도
- 미친듯한 개발 속도
- 과학 공학에 친화적이다.
- 만능 언어 - 웹 서버, 기계학습, 비전, 게임 등 가능한 것이 많다.
- 교육용으로 최고이다.

## Cons

- 문법이 엄격하다. 들어쓰기 같은 경우
- 실행속도.. 매우 느리다.
- 멀티스레딩 불가 ⇒ cpu 부하가 크게 걸리는 경우 옮지 않다.
- 패키지 관리와 개발 및 배포의 어려움

## Famous open source

- Django
- tensorflow
- pytorch
- sklearn
- numpy
- matplotlib
- pandas

# C++

## Author

비아르네 스트로우스트루프(Bjarne Stroustrup)

## Features

- C언어 기반 객체 지향 및 일반화 프로그래밍을 지원하는 멀티 패러다임 프로그래밍 언어
- C language with Classed → C++; C에서 1을 더한다.
- (엄마는) 개발자 널 전적으로 믿어. 개발자에게 거의 모든 것을 맡겨버린다.

## Reason

- A light-weight abstraction programming language
- C가 가지는 절차지향 언어에서 필요한 추상화정도를 더한 언어

## Pros

- 자유도가 높다.
- 일반화 프로그래밍이 가능하다. 템플릿을 사용한다.
- 성능이 매우 높다.
- 저수준 작업이 가능하다. 임베디드에서 사용한다.

## Cons

- 개발자를 너무 신용한 나머지 메모리 누수와 같은 문제가 발생할 수 있다.
- 개발 속도가 중요한 프로젝트에서 사용하기 어렵다.
- 난이도가 높다.

## Famous open source

- STL
- Opencv
- MFC