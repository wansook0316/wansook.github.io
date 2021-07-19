---
layout: post
title: "03: 코드리뷰 Part 2"
category: "DV/iOS"
comments: true
tags: [iOS, "코드리뷰"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "코드리뷰 정리 두번쨰"
---


# UIKit, Foundation

* UIKit은 기본적으로 Foundation을 포함하고 있다.
* 그렇기 때문에 중복해서 import하지 않는다.

![image](https://user-images.githubusercontent.com/37871541/124594821-3aa32680-de9b-11eb-8da5-cf6a8ff0ca41.png){: .center-small}_UIKit 내부_


# Singleton Pattern 유의

* 싱글턴 패턴의 핵심은, 어느 곳에서 접근하든지 간에 같은 인스턴스를 응답으로 주어야 한다.
* 결국 방어를 하도록 코드를 구성해야 한다.
* 내가 실수한 것은 생성자를 만들어주지 않고 사용했다는 것

```swift
class UserInfomation {
    static let shared: UserInfomation = UserInfomation()

    var id: String?
    var firstPassword: String?
    var secondPassword: String?
    var profileImage: UIImage?
    var introducingText: String?
    var phoneNumber: String?
    var date: Date?
}
```

이 상황에서 외부에서 해당 클래스의 인스턴스를 만들 수 있다는 가능성이 존재한다. 그렇기 때문에 생성자에 접근제어를 private로 걸어 외부에서 사용불가하도록 한다.

```swift
class UserInfomation {
    static let shared: UserInfomation = UserInfomation()

    private init() {}

    var id: String?
    var firstPassword: String?
    var secondPassword: String?
    var profileImage: UIImage?
    var introducingText: String?
    var phoneNumber: String?
    var date: Date?
}
```


# 여러 값의 nil 여부 확인

여러개의 값이 모두 입력되었는지 확인할 필요가 때때로 있다. 이런 경우, swift에는 optional이 있어 여간 귀찮은 것이 아니다. ~~~그런데 지금 생각해보니, 파이썬이었으면 당연히 이렇게 짰을텐데..~~~ 여튼 결론을 보자.

```swift
func checkFirstSignUpState() -> Bool{
    if (self.id != nil &&
        self.firstPassword != nil &&
        self.secondPassword != nil &&
        self.profileImage != nil &&
        self.introducingText != nil) {
            if self.checkPassword() == true {
                return true
            } else {
                return false
            }
    }
    return false
```

일단 이렇게 모두 값이 들어왔는지 확인하고 들어온 경우 비밀번호를 확인하고, 그렇지 않은 경우 false를 리턴했다. 굉장히 코드가 눈에도 안들어오고 좋지 못하다.

```swift
if [self.id as Any?, self.firstPassword as Any?, self.secondPassword as Any?, self.profileImage as Any?, self.introducingText as Any?].contains { $0 == nil } == true { 
    // nil이 하나라도 있으면
    return false 
    } 
return self.checkPassword()
```

일단 위의 값들이 모두 같은 타입이 아니기 때문에, Any?로 타입을 변환한 뒤에, 해당 배열에 nil이 존재한다면, false, 그렇지 않다면 비밀번호를 검사한 결과를 return 한다.

코드가 매우 깔끔해졌다. 고차함수를 잘 사용하는 것을 연습해야 겠다.


# PR 할 때 조심할 것

* 쓸데 없는 변경 사항 있는지 확인할 것
* 처음에 view controller 만들면 viewDidLoad override 하라하는데, 만약에 추가로 아무것도 작성을 안했어
* 그럼 그 함수 지워도 되는 거야. 모두가 알고 있다.


# Overriding

* super method를 무조건 호출할 것
* 까먹지좀 마
* 그리고 만약 이게 Life Cycle과 관련된 함수라면 더더욱..!!!!!

# modal 해제, dismiss

* dismiss 함수는 뒤에 completion을 적으라하는데, 기본 값이 nil임
* 즉, `self.dismiss(animated: true)` 로 끝낼 수 있음


# 굳이 왜 변수를 만들었니..?

```swift
let dateString = self.dateFormatter.string(from: self.datePicker.date)
self.dateLabel.text = dateString
```

* 디버깅을 하고 싶은데 저렇게 하는 것이 조금 더 편해서 그랬습니다.



