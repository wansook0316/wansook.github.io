---
layout: post
title: "16: 코드리뷰 Part 4"
category: "DV/iOS"
comments: true
tags: [iOS, "코드리뷰"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "코드리뷰를 통해 배운점 정리"
---

# 코드리뷰

* 내부의 속성을 변경하는 작업의 경우, 메서드를 만들게 되면 능동적인 모델로 변경할 수 있다.
  * 코드도 지저분해지지 않는다.
* property의 경우 위에, computed property의 경우 아래에 적는 방법도 있다.
* 개체 수를 관리하는 것을 Factory에서 처리하는 것이 좋을 수 있다.
* extension에도 접근 제어를 걸 수 있다.
* 이미지는 URL만 가지고 있다가 보여지는 시점에 이를 로딩하는 것이 더 좋다.
  * 즉 보여지는 시점에 그리도록 하는 것이 자원을 적게 먹는다. image는 자원이 높다.
* 특정 로직 자체를 활용하는 방법 자체가 달라질 수 있는 경우라면 UseCase라는 객체를 만들어 사용하는 것이 모듈화 측면에서 좋다.
* 프로토콜을 동작(메서드) 측면에서 나눈 뒤에, 이를 기반으로 활용한다면 좋다.
  1. 상속이외에 다른 특징(형용사)으로 Group화가 가능하다.
  2. 해당 객체를 사용하는 쪽에서 역시 명시적으로 해당 객체 타입을 선언하지 않고 프로토콜을 타입으로 사용하여 interface로 사용하여 결합도를 낮출 수 있다.


![0001](https://user-images.githubusercontent.com/37871541/133929087-d6842649-8710-4452-acae-06355228e56b.jpg){: .center}
![0002](https://user-images.githubusercontent.com/37871541/133929091-d44d31dc-d597-4370-aa90-d5ac195b7b90.jpg){: .center}
![0003](https://user-images.githubusercontent.com/37871541/133929094-fbb6be5f-d87f-4ac5-b712-ce8ec756449e.jpg){: .center}
