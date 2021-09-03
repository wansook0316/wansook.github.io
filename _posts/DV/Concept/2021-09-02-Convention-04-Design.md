---
layout: post
title: "03: Design"
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
5. 



