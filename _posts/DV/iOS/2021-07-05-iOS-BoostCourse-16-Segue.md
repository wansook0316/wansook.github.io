---
layout: post
title: "16: Segue"
category: "DV/iOS"
comments: true
tags: [iOS, "Segue"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "테이블 뷰에 대해서 알아보자."
---

# Segue

* 스토리 보드에서 뷰 컨트롤러 사이의 화면 전환을 위해 사용하는 객체
* 코드 없이 스토리보드에서 세그를 연결할 수 있음


## UIStoryBoardSegue

* UIKit에서 사용할 수 있는 표준 화면 전환을 위한 프로퍼티와 메서드 포함
* 커스텀 전환을 정의하기 위해 서브클래스 구현하여 사용 가능
* UIViewController의 `performSegue` 메서드를 사용하여 세그 객체를 코드로 실행할 수 있음
* Segue 객체는 뷰 컨트롤러의 뷰 전환과 관련된 정보를 가지고 있음
* 세그는 뷰 컨트롤러의 뷰를 다른 뷰 컨트롤러의 뷰로 전환할 때 `prepare` 메서드를 사용하여 새로운 뷰 컨트롤러에 데이터 전달 가능





# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/16893?isDesc=false)
* [UIStoryBoardSegue](https://developer.apple.com/documentation/uikit/uistoryboardsegue)
* [Using Segues](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html)

