---
layout: post
title: "07: Apple Development Documents"
category: "DV/Swift"
comments: true
tags: [iOS, "Documents"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "개발자 문서 읽는 방법을 알아보자."
---


일단 대략 적인 구성이나 팁을 안다면 더 빠르게 성장할 수 있지 않을까?



# 구성

1. 참조 자료 (API Reference)
   * 클래스의 메서드
   * 프로퍼티와 같은 기술적인 세부사항
2. 가이드 (Guide)
   * 특정 분야에 대해 상세히 소개
   * 내부적인 구동 방법에 대한 설명
   * 모두 읽게되면 예상치 못한 정보를 배우게 될 것
   * 예제 코드도 있으니 올바른 코딩에 도움이 됨
3. 샘플 코드 (Sample Code)
   * API 사용 방법 예시


# Tip

* 가이드 읽기 : 개략적인 기능에 대한 이해
* 참조자료 : 프로퍼티, 메서드 숙지

UITextField를 사용하는 경우를 예로 들어보겠습니다.

1. [Text Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/Introduction/Introduction.html) 가이드 문서의 개요를 통해 UIKit 중 문자를 보여주거나 관리하는 주요 구성요소와 기능에 대해 살펴봅니다. 
2. UITextField 외에 문자를 다루는 다른 클래스(UITextLabel, UITextView)에는 무엇이 있는지도 함께 살펴보고 차이에 대해 이해하면 좋습니다.
3. UITextField 참조 문서를 통해 기본적인 객체를 어떻게 생성할 수 있는지 알아봅니다.
4. 텍스트 필드의 문자 색상/폰트/정렬 방법을 수정 하고 싶다면 프로퍼티 부분을 살펴봅니다.
5. 텍스트 필드의 모양과 위치를 재정의하고 싶으면 메서드 부분을 살펴봅니다.
6. 만약 원하는 프로퍼티나 메서드를 찾을 수 없다면 부모클래스의 문서로 이동하여 원하는 기능을 찾아봅니다.
7. 텍스트 필드에 특정 이벤트가 발생하는 것을 감지하고 싶다면 델리게이트가 있는지 살펴봅니다.
8. 델리게이트가 있다면 해당 프로토콜 문서를 찾아가 살펴봅니다.
9. 만약 OS 버전에 따라서 특정 동작을 하지 않거나 오류가 발생한다면 Deprecated된 기능을 사용하고 있지는 않은지 확인해봅니다.

# Reference



[iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/20638/?isDesc=false)