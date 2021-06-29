---
layout: post
title: "13: Target-Action"
category: "DV/Swift"
comments: true
tags: [iOS, "Target-action", "design pattern"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "타겟 액션 디자인 패턴에 대해서 알아보자."
---

# Target-Action

* 이벤트가 발생할 때, 다른 객체에 메시지를 보내는 방법
* 액션 : 특정 이벤트가 발생했을 때, 호출할 메서드를 의미
* 타겟 : 액션이 호출될 객체 - 모든 객체가 될 수 있으나 보통은 컨트롤러
* 액션 메시지 : 이벤트 발생 시 전송된 메시지

## 왜 사용하는가?

* 사실 그냥 이벤트가 발생했을 때, 해당하는 객체에 접근해서 메서드를 호출하면 된다.
* 그럼 굳이 사용하는 이유가 무엇일까?
* 역시 디자인 패턴의 핵심은 재사용성에 가장 큰 방점이 있다.
* 예를 들어 특정 이벤트가 발생했을 때, `abc`라는 이름의 메서드를 실행해야 하는 경우가 있다고 하자.
* 그런데 이 메서드는 A 클래스에도 정의되어 있고 B 클래스에도 정의되어 있다.
* 혹은 A 클래스의 인스턴스가 여러개인 경우도 있다.
* 이런 경우에 일일히 이벤트가 발생했을 때 메서드를 직접 호출한다면 유지보수 측면에서 애로사항이 많을 것이다.
* 그렇기 때문에 이러한 디자인 패턴을 사용하여 쉽고 유용하게 운용한다.

![image](https://user-images.githubusercontent.com/37871541/123735759-bd941200-d8da-11eb-9b6b-1c854a148abd.png){: .center-small}_target action_

# Action method

* 특정한 양식이 필요하다.
* `@IBAction` 은 인터페이스 빌더가 메서드를 인지할 수 있게 해준다.
* 프로그래밍 방식으로 사용하기 위해서는 `@objc` 키워드가 추가적으로 필요하다.
  * 이는 Objective-c 코드가 swift 클래스를 사용하기 위해 달아주는 것이다.

```swift
// 프로그래밍 방식
@objc func doSomething(_ sender: Any) {

}

// 인터페이스 빌더
@IBAction func doSomething(_ sender: Any) { 

}
```

* 애플의 프레임워크에는 Objective-C 언어로 작성된 코드가 많기 때문에,
* 스위프트 언어로 작성한 코드에서는 Objective-C와 호환하기 위해서 `@objc` 라고 표시해야 한다.
* swift 4미만에서는 컴파일러가 자동으로 해주었지만, 4이상 부터는 명시적으로 작성해야 한다.




# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/20638/?isDesc=false)
* [Target-Action](https://developer.apple.com/library/archive/documentation/General/Conceptual/Devpedia-CocoaApp/TargetAction.html)
