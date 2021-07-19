---
layout: post
title: "11: Delegation"
category: "DV/iOS"
comments: true
tags: [iOS, "Documents"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "델리게이션 디자인 패턴에 대해서 알아보자."
---

# Delegation

* 위임, 대리
* 하나의 객체가 다른 객체를 대신해 동작, 조정하는 기능 제공
* Foundation, UIKit, AppKit, Cocoa Touch 등 프레임워크에서 광범위하게 활용
* 주로 프레임워크 객체가 위임을 요청 (야, 가져가서 니가 구현해)
* 커스텀 (프로그래머가 작성하는) 컨트롤러 객체가 위임받아 특정 이벤트에 대한 기능을 구현함

예시로 `UITextFieldDelegate`를 한번 보자.

```swift
// 대리자에게 특정 텍스트 필드의 문구를 편집해도 되는지 묻는 메서드
func textFieldShouldBeginEditing(UITextField)
	
// 대리자에게 특정 텍스트 필드의 문구가 편집되고 있음을 알리는 메서드
func textFieldDidBeginEditing(UITextField)

// 특정 텍스트 필드의 문구를 삭제하려고 할 때 대리자를 호출하는 메서드
func textFieldShouldClear(UITextField)

// 특정 텍스트 필드의 `Return` 키가 눌렸을 때 대리자를 호출하는 메서드
func textFieldShouldReturn(UITextField)
```

이 예시를 보면, 델리게이트는 특정 상황에 대리자(프로그래머가 작성하는 컨트롤러 객체)에 메시지를 전달하고, 적절한 기능을 구현하기 위한 목적으로 사용됨

![image](https://user-images.githubusercontent.com/37871541/123426151-00fe3000-d5fe-11eb-939f-e9786fdfd418.png){: .center}_Delegate Pattern_

# Data Source

* 델리게이트와 매우 비슷한 역할을 한다.
* 델리게이트가 사용자 인터페이스 제어에 관련된 권한을 위임받는 반면
* 데이터 소스는 데이터를 제어하는 기능을 위임 받음
* 많이 사용되는 데이터 소스에는 `UITableViewDataSource`와 `UICollectionViewDataSource`가 있다.

# Protocol

* 코코아 터치에서 프로토콜을 사용하여 델리게이션과 데이터소스를 구현할 수 있음
* 객체간 소통을 위한 강력한 통신 규약
* 데이터나 메시지를 전달할 때 사용함
* 프로토콜은 특별한 상황에 대한 역할을 정의하고 제시
* 하지만 세부기능은 구현하지 않음 (Interface)
* 구조체, 클래스, 열거형에서 프로토콜을 채택하고 특정 기능을 수행하기 위한 사항을 구현할 수 있음


# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/20638/?isDesc=false)
* [Delegation](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID276)
* [Cocoa Design Patterns](https://developer.apple.com/documentation/swift/cocoa_design_patterns#//apple_ref/doc/uid/TP40014216-CH7-ID8)