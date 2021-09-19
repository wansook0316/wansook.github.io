---
layout: post
title: "04: Design"
category: "DV/Concept"
comments: true
tags: [Concept, "Convention","Design"]
feature-img: "assets/img/82.jpg"
feature-title: ""
use_math: true
series: "Conventions"
summary: "설계할 때 꼭 들어가야 하는 요소를 정리하자."
---

# 작성 흐름

1. 클래스 정의
2. 메서드 작성
3. 테스트 코드 작성
4. 구현

1~4를 반복한다. 이렇게 하는 이유는, 행동을 기준으로 객체를 설계하고, 메서드를 기반으로 동작을 확인하기 위함이다. 만약 computed property가 있는 경우, 마찬가지로 테스트를 진행한다.

# 분리 시점

1. 내부에서 객체를 생성해서 사용하는 것을 지양한다.
   * 즉 의존성 주입 방식을 사용하여 설계하는 것을 생각해본다.


# 철칙

1. 필요없는 인터페이스는 만들지 않는다.
2. 테스트를 위한 함수도 만들지 않는다.
3. 명사형으로 끝나는 경우는 Computed Property를 사용한다.
4. 상위 모듈에서는 하위 모듈에게 일을 시키는 방향으로 코드를 구성한다. (호출 레벨이 동등해야 한다.)
5. 클래스 내부 프로퍼티는 기본이 `private` 이다.
   * IBOutlet, IBAction 역시 마찬가지이다.
6. 해당 기능이 클래스에 종속되지 않거나, 자주 사용될 경우 Util과 같은 곳으로 분리한다. (라이브러리 형식으로 사용)
7. 프로토콜 추상화는 method만 하는 것을 추천한다.
8. 함수하나를 짤 때도, 능동인지 수동인지 생각하면서 짠다.
9. 네이밍은 물흐르듯 읽을 수 있도록 해야 한다.
10. 자료구조를 적극 활용 한다. (Dictionary)
11. **특정 객체의 변경사항을 적용해야 한다고 할 때, 이걸 외부에서 적용해야 하는 것인지, 내부에서 처리해야 하는 것인지 고민한다.**



# Tip

* extension을 잘 활용하면 코드의 길이가 줄어들 수 있다. 중복 코드 제거
  * NSObject extension을 활용해서
  ```swift
  class var className: String {
      String(describing: self)
  }
  ```
  * 이렇게 적어두면 모든 클래스에서 사용이 가능하다.
* 기본타입을 사용하는 것을 지양하고, 통제, 제한 하는 방식으로 구현한다.
* 