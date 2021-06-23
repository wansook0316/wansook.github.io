---
layout: post
title: "06: MVC"
category: "DV/Swift"
comments: true
tags: [iOS, "MVC"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "Model View Controller를 알아보자."
---

# Model-View-Controller

![image](https://user-images.githubusercontent.com/37871541/123034938-75ca4200-d425-11eb-8e18-2227f133bfeb.png){: .center-small}_MVC_



* iOS 앱 개발에서는 MVC 디자인 패턴을 사용
* 애플리케이션의 객체를 모델, 뷰, 컨트롤러의 세가지 역할 중 하나로 할당하는 것
* 각각의 객체에서 수행하는 역할을 정의
* 또한 그 객체들이 통신하는 방식 역시 정의


# Model Objects

* 애플리케이션과 관련된 데이터를 캡슐화
* 데이터를 조작하고 처리하는 로직, 계산을 정의
* 하나의 모델 객체는 다른 모델 객체와 일대일 또는 일대다 대응 관계를 맺을 수 있음, 다대다도 가능
* 모델 객체는 사용자 인터페이스, UI 표시 문제와 관련이 없어야 함
* 즉 분리되어서 존재하여야 함

## 잘 설계된 모델 클래스

* 모델 객체를 생성하는 클래스는 Core Data technology를 사용한다면 NSManagerdObject 서브 클래스를 많이 사용
* Objective-C 인 경우 보통 NSObject의 서브 클래스
* 스위프트인 경우 NSObject를 잘 상속받지 않음
* 값 타입의 모델이 필요한 경우 클래스 대신 구조체를 활용하기도 함


## 고려사항

* 인스턴스 변수
  * 애플리케이션 내에 캡슐화된 데이터를 유지하기 위한 인스턴스 변수를 선언
  * 객체, 스칼라 값, 구조체가 가능
  * 객체형 또는 비객체형을 사용하는 데에는 장단점이 있으므로 "객체 상호 관계"를 고려해야 함
    * 객체 상호 관계는 UML 다이어그램에서 보았던 객체간의 관계를 말함
* 접근자 메서드(Accessor methods)와 프로퍼티   
  * 인스턴스 변숫값을 획득하거나 설정 
  * getter and setter methods라 불림
  * 변수를 private, fileprivate로 접근을 제안한 경우 외부에서 접근하기 위해서는 접근자 메서드가 필요하다.
* 키-값 (key-value) 코딩
  * 클라이언트가 프로퍼티 이름을 키로 사용하여 객체의 프로퍼티에 접근할 수 있도록 하는 메커니즘
  * Core data에서 사용중
* 초기화 및 할당 해제
  * 대부분의 모델 클래스는 인스턴스 변수를 적절한 초깃값으로 설정하는 init 메서드를 구현함
  * deinit에서는 인스턴스 변수를 해제
* 객체 인코딩
  * 모델 클래스의 객체를 보관하려는 경우, 해당 객체의 인스턴스 변수를 인코딩 및 디코딩할 수 있어야 한다.
* 객체 복제
  * 클라이언트가 모델 객체를 복제할 것으로 예상하는 경우, 클래스에서 객체 복제를 구현해야 함


# View Objects

* 어플리케이션 내에서 사용자가 볼 수 있는 객체를 말함
* 동작에 응답할 수 있음
* 목적 : 모델 객체의 데이터를 보여주고, 해당 데이터를 편집할 수 있도록 하는 것
* 하지만 model 객체와 분리되어서 작동함


# Controller Objects

![image](https://user-images.githubusercontent.com/37871541/123036685-6a2c4a80-d428-11eb-8893-54a7e0c0b1e2.png){: .center-small}_controller_



* 컨트롤러 객체는 하나 이상의 어플리케이션 뷰 객체, 하나 이상의 모델 객체 사이의 중개자 역할
* 컨트롤러는 사용자의 액션을 받아 해석하고, 변경된 데이터를 모델 객체에 전달
* 반대로 모델 객체의 변경사항을 인지해서 화면에 보내는 것도 가능
* 양쪽 객체의 생애주기를 관리하기도 함

## 코디네이팅 컨트롤러 (Coordinating Controllers)

* 애플리케이션 전체 혹은 일부 기능을 감독하고 관리
* 애플리케이션 별로 다른 로직이 각 애플리케이션에 주입되는 장소
* 기능
  * 델리게이션(delegation) 메시지에 응답하고 알림(notifications)을 관리.
  * 사용자가 버튼과 같은 컨트롤을 탭 하거나 클릭함에 따라 전송되는 동작 메시지(action message)에 응답.
  * 객체 간의 연결을 확립하거나 기타 설정 작업을 수행. (예: 애플리케이션을 시작하는 경우)
  * 소유한(owned) 객체의 생명 주기 관리.
* iOS 애플리케이션에서는 뷰 컨트롤러가 코디네이팅 컨트롤러의 역할을 겸하는 경우가 많음



## 뷰 컨트롤러 (View Controllers)

* 콘텐츠를 화면에 표시하는 뷰를 관리
* 해당 뷰에 대한 reference 유지
* 후속 뷰로의 전환을 관리
* Modal view 표시
* 메모리 부족 응답
* 뷰 회전
* UIViewController 서브 클래스의 인스턴스


# 생각하기

* MVP (Model-View-Presenter)
* MVVM (Model-View-ViewModel)
* 이 부분은 MVP를 한 이후에 다시 보는 것이 맞다.

# Reference

[iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/16877/?isDesc=false)