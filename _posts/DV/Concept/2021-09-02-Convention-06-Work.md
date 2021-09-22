---
layout: post
title: "06: Work"
category: "DV/Concept"
comments: true
tags: [Concept, "Convention","Work"]
feature-img: "assets/img/82.jpg"
feature-title: ""
use_math: true
series: "Conventions"
summary: "일하기 전에 꼭 해야 하는 요소를 정리하자."
---


1. gitignore
   * [iOS gitignore](https://wansook0316.github.io/dv/ios/2021/08/08/iOS-Exprience-11-iOS-gitignore.html)
2. 기능 리스트 분리
3. branch 따기




# 코드 컨벤션

1. Guard는 특정 상황이 아니면 한번에 연달아서 처리한다.
2. 정적 변수는 최대한 지양한다.
3. 상수는 따로 관리한다.
4. 수동, 능동 표현을 잘 사용한다.
5. 함수 이름에 목적어가 포함된 경우 뒤의 첫번째 파라미터의 이름을 생략한다.
6. 그렇지 않은 경우 모두 명시한다.


# 폴더 구조

* App
  * AppDelegate
  * SceneDelegate
  * info.plist
* Assets -> 아카이브 되는 녀석들
  * Storyboard
  * Assets
* Domain
  * Model
  * Service
    * API 통신 같은 것들을 담는다.
* Pages
  * 페이지 별로 사용하는 것들을 담는다.
  * Cell, VC
* Utils