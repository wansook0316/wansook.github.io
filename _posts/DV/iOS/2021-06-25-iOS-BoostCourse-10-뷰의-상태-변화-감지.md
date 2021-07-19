---
layout: post
title: "10: 뷰의 상태 변화 감지"
category: "DV/iOS"
comments: true
tags: [iOS, "Documents"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "뷰의 상태와 레이아웃 변화에 따라 호출되는 메서드에 대해서 알아보자."
---

# 뷰의 상태 변화 감지 메서드

* 뷰가 화면에 보여지는 상태의 변화
* 뷰의 레이아웃의 변화
  * 메서드를 호출하여 서브 클래스가 대응을 할 수 있게 함

![image](https://user-images.githubusercontent.com/37871541/123414130-76620480-d5ee-11eb-9ffd-99ce2661c6c4.png){: .center-small}_view state Transitions_

## 상태 변화 메서드

* `viewDidLoad()`
  * 뷰 계층이 메모리에 로드된 직후 호출되는 메서드
  * 뷰의 추가적인 초기화 작업을 진행
  * 메모리에 처음 로딩될 때, 1회 호출됨
  * 뷰가 사라지지 않는 이상 다시 호출되지 않음(메모리 경고)
* `viewWillAppear`
  * 뷰가 뷰 게층에 추가되고 화면이 표시되기 직전에 호출되는 메서드
  * 뷰의 추가적인 초기화 작업을 하기 좋은 시점
  * 다른 뷰로 이동했다가 되돌아오면 재호출되는 메서드
  * 그래서 화면이 나타날 때마다 수행해야 하는 작업을 하기 좋은 시점
* `viewWillDisappear`
  * 뷰가 뷰 계층에서 사라지기 직전에 호출되는 메서드
  * 뷰가 생성된 뒤 발생한 변화를 이전으로 되돌리기 좋은 시점
* `viewDidDisappear`
  * 뷰가 뷰 계층에서 사라진 후 호출되는 메서드
  * 뷰를 숨기는 것과 관련된 추가적인 작업을 하기 좋은 시점
  * 시간이 오래 걸리는 작업은 하지 않는 것이 좋음. 당연하지 다음 뷰까지 오래걸리니까


## 뷰의 레이아웃 변화 메서드

뷰가 생성된 후, 바운드 및 위치 등의 레이아웃에 변화가 발생했을 때 호출되는 메서드이다.

* `viewWillLayoutSubViews()`
  * 뷰가 서브뷰의 레이아웃을 변경하기 직전에 호출되는 메서드
  * 서브뷰의 레이아웃을 변경하기 전에 수행할 작업을 하기 좋은 시점
* `viewDidLayoutSubviews()`
  * 서브뷰의 레이아웃이 변경된 후 호출되는 메서드
  * 서브뷰의 레이아웃을 변경한 후 추가적인 작업을 수행하기 좋은 시점

이외에도 다양한 메서드가 있다. 


# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/20638/?isDesc=false)
* [UIViewController](https://developer.apple.com/documentation/uikit/uiviewcontroller)
