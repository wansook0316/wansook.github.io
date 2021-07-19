---
layout: post
title: "20: OperationQueue"
category: "DV/iOS"
comments: true
tags: [iOS, "OperationQueue"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "OperationQueue에 대해서 알아보자."
---

# OperationQueue
* 연산의 실행을 관리하고, 대기열의 동작관리를 함
* Operation
  * Task와 관련된 코드와 데이터를 나타내는 추상 클래스
* OperationQueue는 이 연산의 실행을 관리한다.
* Queue에 추가한 동작은 직접 제거가 불가능
* 이 Operation을 대기열에서 제거하기 위해서는 연산을 취소하는 방법밖에 없다.
* Operation Object의 `cancel` 메서드를 호출하거나,
* Operation queue의 `cancelAllOperations()` 메서드를 호출하여 대기열에 있는 모든 연산을 취소하는 방법으로 가능

## Operation Object

* 앱에서 수행하려는 연산(Operation)을 캡슐화하는데 사용하는 Foundation 프레임워크의 Operation 클래스의 인스턴스

# 주요 메서드/프로퍼티

* current
  * 현재 작업을 시작한 Operation queue를 반환
* main
  * 메인 스레드와 연결된 Operation Queue를 반환

나머지는 Doc을 읽으면 해결된다. 생략.

# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/16898/?isDesc=false)
* [Operation](https://developer.apple.com/documentation/foundation/operation)
* [OperationQueue](https://developer.apple.com/documentation/foundation/operationqueue)
