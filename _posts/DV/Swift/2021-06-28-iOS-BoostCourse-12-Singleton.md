---
layout: post
title: "12: Singleton"
category: "DV/Swift"
comments: true
tags: [iOS, "Singleton", "design pattern"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "싱글턴 디자인 패턴에 대해서 알아보자."
---

# Singleton

* 특정 클래스의 인스턴스가 오직 하나임을 보장하는 객체
* 애플리케이션이 요청한 횟수와는 관계없이 이미 생성된 같은 인스턴스를 반환한다.
* 딱 하나만 있기 때문에, 다른 인스턴스들이 공유해서 사용이 가능하다.

![image](https://user-images.githubusercontent.com/37871541/123731530-4018d380-d8d3-11eb-9bfd-e9b68f9f7d14.png){: .center-small}_singleton pattern_


# Cocoa 프레임 워크에서의 싱글턴 사용예

* FileManager
  * 애플리케이션 파일 시스템을 관리하는 클래스
* URLSession
  * URL 세션을 관리하는 클래스임
  * URLSession.shared
* NotificationCenter
  * 등록된 알림의 정보를 사용할 수 있게 해주는 클래스
  * NotificationCenter.default
* UserDefaults
  * Key-Value 형태로 간단한 데이터를 저장하고 관리할 수 있는 인터페이스를 제공
  * 데이터 베이스 클래스
* UIApplication
  * iOS에서 실행되는 중앙제어 애플리케이션 객체
  * UIApplication.shared

# 주의할 점

* 애플리케이션 내의 특정 클래스의 인스턴스가 하나만 존재
* 즉, 여러개 만들 필요가 없는 경우에 사용
* 환경 설정, 네트워크 연결 처리, 데이터 관리
* **멀티 스레드 환경에서 동시에 싱글턴 객체를 참조할 경우 문제 발생 가능**
* 항상 장단점을 고려하여 활용한다.




# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/20638/?isDesc=false)
* [Singleton](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/Singleton.html)
* [Managing a Shared Resource Using a Singleton](https://developer.apple.com/documentation/swift/cocoa_design_patterns/managing_a_shared_resource_using_a_singleton)