---
layout: post
title: "08: assert, guard"
category: "DV/Swift"
comments: true
tags: [Swift, "assert", "gaurd"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "Swift"
summary: "assert란? 왜 굳이 guard를 쓸까?"
---


# Assertion

* `assert` 함수 사용
* 디버깅 모드에서만 동작
* 배포하는 애플리케이션에서는 제외된다.
* 조건의 검증을, 즉 테스트를 위해서 사용

```swift
var someInt: Int = 0

// 검증 조건, 실패 조건을 작성
assert(someInt == 0, "someInt != 0") // 현재는 넘어감

someInt = 1
//assert(someInt == 0) // 동작 실패 : test.playground:7: Assertion failed
//assert(someInt == 0, "someInt != 0") // 동작 실패 : test.playground:8: Assertion failed: someInt != 0

func functionWithAssert(age: Int?) {
    
    assert(age != nil, "age == nil, 문제 발생")
    
    assert((age! >= 0) && (age! <= 130), "나이값 입력이 잘못되었습니다")
    print("당신의 나이는 \(age!)세입니다")
}

functionWithAssert(age: 50)
//functionWithAssert(age: -1) // 동작 중지, 검증 실패
//functionWithAssert(age: nil) // 동작 중지, 검증 실패

```

* assert와 같은 역할을 하지만
* 배포 환경에서 동작하는 `precondition`이라는 함수도 있다.


# guard (Early Exit)

* `guard`를 사용하여 잘못된 값의 절달시 특정 실행 구문을 빠르게 종료한다.
* 디버깅 모든 뿐만 아니라, 어떤 조건에서도 동작함
* else 불럭 내부에는 특정 코드블럭을 종료하는 지시어(return, break)가 있어야 함
* 타입 캐스팅, 옵셔널과도 자주 사용됨
* 그외에도 단순 조건 판단 후 빠르게 종료할 때도 사용함 

```swift
func functionWithGuard(age: Int?)
{
    guard let unwrappedAge = age,
          unwrappedAge < 130,
          unwrappedAge >= 0 else {
        print("나이값이 잘못 입력되었습니다.")
        return
    }
    
    print("당신의 나이는 \(unwrappedAge)입니다.")
}

functionWithGuard(age: -3) // 나이값이 잘못 입력되었습니다.
functionWithGuard(age: 140) // 나이값이 잘못 입력되었습니다.
functionWithGuard(age: nil) // 나이값이 잘못 입력되었습니다.
functionWithGuard(age: 21) // 당신의 나이는 21입니다.
```
여기서 알아야 하는 건 unwrappedAge를 아래에서 사용하고 있다는 것이다. if를 쓰면 사용하지 못한다.

```swift
// 1. if let 옵셔널 바인딩
if let unwrapped: Int = someValue { 
// do something
   unwrapped = 3
} 
// if 구문 외부에서는 unwrapped 사용이 불가능 합니다.
// unwrapped = 5 

// 2. guard 옵셔널 바인딩
// gaurd 구문 이후에도 unwrapped 사용 가능합니다.
guard let unwrapped: Int = someValue else {
         return 
}
unwrapped = 3
```

```swift
var count = 1
while true {
    guard count < 3 else {
        break
    }
    print(count)
    count += 1
}
// 1
// 2
```


# Reference

* [iOS 프로그래밍을 위한 스위프트 기초](https://www.boostcourse.org/mo122/lecture/11299?isDesc=false)
* [apple official document : assert](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID335)
* [apple official document : guard](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html#//apple_ref/doc/uid/TP40014097-CH9-ID525)
* [assertion과 컴파일 최적화](http://seorenn.blogspot.com/2016/05/swift-assertion.html)