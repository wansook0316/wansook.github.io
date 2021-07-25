---
layout: post
title: "17: Lazy Variables"
category: "DV/Swift"
comments: true
tags: [Swift, "Lazy"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "Swift"
summary: "Lazy 변수의 사용 의도, 이해"
---

스위프트에서 메모리는 굉장히 예민한 주제이다. 이러한 부분에서 메모리와 관련한 문법인 Lazy를 알아보자.

# Lazy Variable

> 처음 사용되기 전에는 연산이 되지 않는 저장 Property이다.

* 사용할 떄 Load되는 경우가 꼭 필요하다.
* 고려 사항
  * var와 함께 사용되어야 한다.
    * 초기에 값이 존재하지 않고, 이후에 값이 생기기 때문
  * struct, class에서만 사용이 가능하다.
  * computed property에는 사용이 불가능
    * lazy는 처음 사용될 때 메모리에 값을 올리고, 이후부터는 메모리에 올라온 값을 사용한다.
    * 사용할 때마다 값을 연산하는 `Computed Property` 에는 사용이 불가하다.
  * lazy and closure
    * lazy에 특별한 연산을 통해 값을 넣기 위해서는 closure를 사용한다.
    * struct, class에 다른 프로퍼티 값을 사용하기 위해서는 일단 self를 통해 접근할 수 있다.
    * 만약 lazy를 선언하지 않은 상태에서 클로저 내에서 self를 통해 인스턴스내의 멤버 변수에 접근한다면 아직 생성이 되지 않았기 때문에 접근이 불가함
      1. 쟤는 지금 프로퍼티임
      2. 프로퍼티는 인스턴스가 생성될 때 무조건 초기화가 되어있는 상태여야 함
      3. 멤버 메소드는 인스턴스가 초기화가 되어 있다는 가정이 되어 있기 때문에 해당 블록 안에서 self 사용이 가능
      4. 지금 쟤는 프로퍼티로서 할당이 되어 있는데, 초기화 단계에서 self 를 쓴다는 것이 말이 안됨
      5. 그러니까 self를 찾을 수 없다고 뜸
    * 그런데, lazy를 쓰면, 생성후 추후에 접근하겠다는 의미기 때문에 self로 접근이 가능

```swift
class Person {
    var name:String
    
    lazy var greeting:String = {
        return "Hello my name is \((self.name))"
    }()
  
    init(name:String){
        self.name = name
    }
}

var me = Person(name:"John")

print(me.greeting // Hello my name is John

me.name = "James"

print(me.greeting) // Hello my name is John
```

* 이렇게 사용이 가능.
* 클래스 내부에서 클로저를 사용하면, 순환 참조 때문에 메모리 누수가 날 수 있음
* 하지만 지금 같은 경우는, 생성하고 실행한 뒤 reference count를 바로 줄여주기 때문에, 메모리 누수가 발생하지 않음
* 만약 클로저 자체를 해당 클래스의 인스턴스가 가지고 있어야 하는 상황이라면,

```swift
class Person {
    var name:String
    
    lazy var greeting: ()->String = { [weak self] in
        return "Hello my name is \(((self?.name))!)"
    }
    init(name:String){
        self.name = name
    }
}

var me = Person(name:"John")

print(me.greeting()) // Hello my name is John

me.name = "James"

print(me.greeting()) // Hello my name is James
```

* 해당 클래스 인스턴스를 약한 참조(해당 클래스 인스턴스의 reference count를 늘리지 않음, 또한 참조하는 인스턴스가 kill 될 경우, 본인도 죽어야 함) 하여야 한다.

# Reference

* [Generics](https://docs.swift.org/swift-book/LanguageGuide/Generics.html)
* [Generics 번역판](https://jusung.gitbook.io/the-swift-language-guide/language-guide/22-generics)