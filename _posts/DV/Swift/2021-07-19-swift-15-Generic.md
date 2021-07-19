---
layout: post
title: "15: Generics"
category: "DV/Swift"
comments: true
tags: [Swift, "Generic"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "Swift"
summary: "스위프트의 Generics이란?"
---


# Generics

* 타입 파라미터
  * 다양한 타입을 통칭해서 받을 파라미터를 의미
  * 보통 `T`와 같은 문자를 사용
  * generic function임을 알려주기 위해서는 `function<T>` 와 같이 명시해야 함
  * 이걸 <mark style='background-color: #fff5b1'> Place Holder </mark>라 부름
  * 복수의 타입 파라미터를 사용하고 싶은 경우 `,`로 구분함
* 이름 짓는 방법
  * Element간의 상관관계가 있는 경우
    * ex) 딕셔너리에서 왼쪽은 Key의 의미, 오른쪽은 Value의 의미인 경우
  * 말고는 T, U, V와 같은 단일 문자로 파라미터 이름을 지을 것
* 확장
  * 구조체, 열거형, 프로토콜, 클래스에서 확장하듯, 이녀석도 같은 방식으로 가능하다.
* 타입 제한
  * 제네릭은 일반적으로 같은 동작을 하는 함수가, Argument가 다를 경우 이를 묶어서 활용하는 방법이다.
  * 그런데, 그렇게 묶어서 사용하는 경우에도 인자로 들어가는 녀석들의 성격자체가 특정한 성격을 띄는 경우에만 가능한 경우가 있다.

```swift
func someFunction<T>(a: T, b: T) -> Bool {
    return a == b
}
```

만약에 이러한 함수가 있다고 해보자. 나는 integer 2개의 값이 같은지, 또는 string 2개의 값이 같은지를 비교하고 싶은데, 코드가 중복되어 Generic을 사용하였다. 그런데, 이 안에 인자로 들어오는 T 자체는 모든 자료형을 뜻하고 있다. 그런데 만약 특정 사용자가 구조체를 정의 했고, `==` 연산자에 대해 구현하지 않았다면 어떻게 될까? 해당 함수는 동작할 수가 없다. 

즉, `==`에 대해 계산이 가능한 타입에 대해 해당 함수는 동작할 수 있는 것이다. 이런 경우 스위프트는 프로토콜을 만족함으로써 특정 타입의 속성을 결정하는데, 이 경우 `Equatable`이라는 프로토콜을 준수하는 자료형만 해당 함수에서 처리하도록 하여 문제를 해결할 수 있다.

```swift
func someFunction<T: Equatable>(a: T, b: T) -> Bool {
    return a == b
}
```


# Reference

* [Generics](https://docs.swift.org/swift-book/LanguageGuide/Generics.html)
* [Generics 번역판](https://jusung.gitbook.io/the-swift-language-guide/language-guide/22-generics)