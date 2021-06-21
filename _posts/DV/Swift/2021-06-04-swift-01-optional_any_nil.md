---
layout: post
title: "01: Optional, Any, AnyObject, nil"
category: "DV/Swift"
comments: true
tags: [Swift, "optional", "옵셔널 바인딩", "Any", "AnyObject", "nil"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "Swift"
summary: "헷갈리는 문법 위주의 공부, optional, any, nil"
---


# Style Guide

[raywenderlich.com 공식 Swift 스타일 가이드](https://github.com/swift-kr/swift-style-guide-raywenderlich/blob/master/ko_style_guide.md)  
[Swift Naming Guide](https://swift.org/documentation/api-design-guidelines/#naming)  
[API design guide 번역](https://minsone.github.io/swift-internals/api-design-guidelines/)  




# 특징

* 다양성이 높은 언어
* 명료성은 간결함보다 중요하다.
* 모든 선언문에 문서화용 주석을 작성해라.
  * 요약
  * 추가설명
  * 매개변수
  * 참고사항
* 네이밍
  * 명확한 사용을 권장한다.
    * remove(x) : x라는 값을 지우라는 것인가? x번째 인덱스를 지우라는 것인가?
    * remove(at :x)
  * mutatating/nonmutating 메소드 쌍을 일관되게 이름을 지정
    * reference로 변경하는 경우 동사형
    * return 하는 경우 ed, ing

# Constant, Variable

* 스위프트는 함수형 패러다임을 채용한 언어
* 불변 객체를 중요하게 여김
* 상수 표현이 자주 등장하게 됨

# Any, AnyObject, nil

* Any
  * Swift의 모든 타입을 지칭하는 키워드
  * 중요한 점은 예를 들어 Any 타입의 변수안에 Double형 변수를 넣어두었다 하더라도
  * 다른 Double 변수에 이 변수를 직접적으로 할당할 수 없다는 것이다.
  * 꼭 형변환을 해줘야 한다.
* AnyObject
  * 모든 클래스 타입을 지칭하는 프로토콜
  * 프로토콜은 추후에 알아보자.
  * AnyObject는 클래스의 인스턴스만 받아먹기 때문에, 다른 인스턴스를 사용하면 에러가 난다.
* nil
  * '없음'을 의미
  * `Any`, `AnyObject`에 값을 할당할 수 없다!!!!!!!!!!


# Collection

* Set
* Dictionary
* Array


# Optional

* nil의 가능성을 명시적으로 표현
* 주석 작성 필요 없음
* 전달받은 값이 옵셔널이 아니라면, 안심하고 사용이 가능함
* 예외 상황을 최소화하는 안전한 코딩을 할 수 있음

```swift

// someOptionalParm에 nil이 할당 될 수 있다.
func someFunction(someOptionalParam: Int?) {
       // ....
}

/// someOptionalParm에 nil이 할당 될 수 없다.
func someFunction(someOptionalParam: Int) {
       // ....
}

// 위의 함수에, parameter의 성격을 정의를 했기 때문에, compiler가
// 아래의 경우 불가하다는 것을 인지할 수 있음
// 즉 안전한 코딩이 가능함
someFunction(someOptionalParam: nil)
// someFunction(someParam: nil) 

```

* 열거형과 general 프로그래밍의 합작품

```swift
enum Optional<Wrapped> : ExpressibleByNilLiteral {
    case .none
    case .some(Wrapped)

let optionalValue: Optional<Int> = nil
let optionalValue: Int? = nil

}
```

## 암시적 옵셔널 추출 (!)

* 타입 뒤에 느낌표를 찍으면 된다.
* 옵셔널은 기본적으로 enum임
* 기존 변수처럼 사용이 가능하다.
* nil도 할당이 가능함
* 그런데, 잘못된 접근 (nil 상황에서 연산을 하려고함)으로 인해 런타임 오류가 발생할 수 있음
* 즉 뭐야? 이전 프로그래밍 언어와 같아진 것.
* 컴파일 타임에서 에러를 체크하기 어렵고, 런타임에서 망가지는 경우가 발생
* 일단 옵셔널이긴 함! 연산만 가능하게 해둔 것.

```swift
// Implicitly Unwrapped Optional
var implicitlyUnwrappedOptionalValue: Int! = 100

switch implicitlyUnwrappedOptionalValue {
case .none:
    print("This Optional variable is nil")
case .some(let value):
    print("Value is \(value)")
}

// 기존 변수처럼 사용 가능
implicitlyUnwrappedOptionalValue = implicitlyUnwrappedOptionalValue + 1

// nil 할당 가능
implicitlyUnwrappedOptionalValue = nil

// 잘못된 접근으로 인한 런타임 오류 발생
//implicitlyUnwrappedOptionalValue = implicitlyUnwrappedOptionalValue + 1
```

## 물음표를 이용한 옵셔널 (?)

* 일단 얘는 nil 할당은 가능해
* 그런데, 연산이 불가해
* 왜? Optional 타입이기 때문에 애초에 다른 타입인거야
* 만약 위에처럼 연산이 가능해버리면 결국 특정상황에 nil이 들어갔을 때 연산을 할 수 있게된다는 것이고 런타임에러로 이어짐
* 그렇기 때문에 값을 감싼것. 그리고 연산도 못하게 막아둔것

```swift
// Optional
var optionalValue: Int? = 100

switch optionalValue {
case .none:
    print("This Optional variable is nil")
case .some(let value):
    print("Value is \(value)")
}

// nil 할당 가능
optionalValue = nil

// 기존 변수처럼 사용불가 - 옵셔널과 일반 값은 다른 타입이므로 연산불가
//optionalValue = optionalValue + 1

```

## 옵셔널 언래핑

* 그러면 일단 ?를 사용하는게 맞겠지.
* 그러면 어떻게 연산을 할 수 있게 만들 수 있을까?
* 이러한 방법에는 두가지가 있다.

### Optional Binding

![image](https://user-images.githubusercontent.com/37871541/122674769-915cff00-d211-11eb-8f8d-fc30f3164621.png){: .center-small}_그림으로 연상하기_

* nil 체크 + 안전한 값 추출
* 옵셔널은 값을 보호해주는 상자가 있다고 생각해보자.
* 일단 !, ?모두 옵셔널중 하나니, 값을 감싸는 것은 맞다.


<img width="595" alt="스크린샷 2021-06-20 오후 9 54 27" src="https://user-images.githubusercontent.com/37871541/122674905-16e0af00-d212-11eb-9e53-a64c57421b3d.png">{: .center-small}_값을 물어보는 것이 Optional binding_


* 옵셔널 바인딩은 이러한 상자에 대고 값이 있는지를 먼저 물어보는 것

```swift
func printName(_ name: String){
    print(name)
}

var myName: String? = nil

printName(myName) // 에러 발생
```

이렇게 작성할 경우, argument의 데이터 타입과 다르기 때문에 컴파일 에러가 난다. 해당 함수를 변경하지 않고 사용하기 위해서는 현재 옵셔널로 지정되어 있는 `myName` 변수를 언래핑 해주어야 한다.


```swift
if let name: String = myName {
    printName(name)
} else {
    print("myName == nil")
}
// myName == nil
```

값이 있는 경우 가장 첫번째 구문이 실행되고, 없는 경우, nil이면 아래 구문이 실행된다. 이 때 사용된 name 상수는 스코프 안에서만 살아있다. 만약 다음과 같은 구문을 작성했다면 에러가 난다.

```swift
if let name: String = myName {
    printName(name)
} else {
    print("myName == nil")
}
print(name) // 에러
```

이러한 언래핑은 하나의 변수에 대해서만 할 수 있는 것이 아니다.

```swift
var myName:String? = "wansook"
var yourName: String? = nil

if let name = myName, let friend = yourName {
    print("\(name) and \(friend)") // 실행되지 않음, friend = nil임
}

```

myName과 yourName을 받아서 각각의 값이 nil이 아닌 경우에 print가 동작한다. 이전과 달리 else 구문이 없어도 실행된다. 위의 코드는 friend가 nil이기 때문에 동작하지 않는다.

```swift
var myName:String? = "wansook"
var yourName: String? = "jungmoo"

if let name = myName, let friend = yourName {
    print("\(name) and \(friend)")
}
// wansook and jungmoo
```

실제로 값이 들어간 경우 정상작동하는 것을 볼 수 있다.



### Force Unwrapping

* 강제로 추출하는 방식

![image](https://user-images.githubusercontent.com/37871541/122675291-bb172580-d213-11eb-9bc3-46def4f8ed2d.png){: .center-small}_강제 추출_

```swift
func printName(_ name: String) {
    print(name)
}
var myName: String? = "wansook"
var youName: String! = nil

printName(myName!) // wansook

```

지금 같은 경우는 myName에 값이 있기 때문에 정상 작동한다.

```swift
myName = nil
print(myName!) // 강제추출시 값이 없으므로 런타임 오류 발생
```

하지만 이런 경우, 값이 없을 경우에 다른 처리를 해주지 않았기 때문에 에러가 난다. print 함수는 nil이 들어갔을 경우를 처리하지 못하는 것. print 함수의 인자로는 Any 타입이 들어가야 하는데, 앞에서 배웠듯 Any 타입에는 nil을 할당할 수 없다. 그렇기 때문에 문제가 발생한 것.

```swift
func printName(_ name: String) {
    print(name)
}
var yourName: String! = nil
yourName = "sdgsg"
printName(yourName)
```

그런데 암시적으로 (!) 선언한 경우에는 굳이 Unwrapping을 해주지 않아도 해당 함수에 들어간다! 잘 생각해보면 만약에 타입을 ?로 선언했다면 강제 언래핑을 하던 아니면 옵셔널 바인딩을 하던 이를 풀어주는 것이 필요했다. 하지만 암시적으로 선언한 경우 일단 연산이 가능하도록 만들었기 때문에 값이 들어가긴 한다. 즉 암시적 선언한 경우는 이런 강제 언래핑을 기본으로 갖고 있는 것.

```swift
func printName(_ name: String) {
    print(name)
}
var yourName: String! = nil
printName(yourName)// nil 값이 전달되기 때문에 런타임 오류발생
```

하지만 그렇기 때문에 만약 nil이 들어갈 수 있다면 해당 함수는 동작하지 않는다. 

* 정리
  * 느낌표는 정말 값이 있다는 것이 확실할 때 사용하는 언래핑 방법
  * 찜찜하다면 옵셔널 바인딩을 하는 것이 안전한 코딩을 하는 방법
  * Any, AnyObject에는 nil을 할당할 수 없음
# Reference

[SmileHan](https://www.youtube.com/channel/UCM8wseo6DkA-D7yGlCrcrwA)