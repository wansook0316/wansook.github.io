---
layout: post
title: "Functional Programming, Functor, Nonad"
category: "DV/Concept"
comments: true
tags: [Concept, Paradigm, "Functional Programming", "Functor", "Nonad"]
feature-img: "assets/img/78.jpg"
feature-title: ""
use_math: true
series: "Paradigm"
summary: "함수형 프로그래밍의 주요 특징에 대해 알아본다."
---

# 개요

- 함수 중심 프로그래밍
    - 함수의 계산으로 데이터를 처리
    - 상태와 가변 데이터 대신 불변 데이터를 가지고 프로그래밍
        - 요즘은 그래서 클래스도 불변 클래스 이런 것들이 있음
    - 순수 함수 (Locality)
        - 부작용이 없는 함수
            - 해당 함수외에 영향을 주지 않는다.
            - 부가적인 영향이 없고, 딱 해당 함수의 동작에만 영향이 있음
        - 변경 불가능한 데이터
            - 만약 바뀌어야 한다면, 변수를 복사해서 사용한다.
        - 참조 투명성
            - 바깥에 있는 것을 참조하더라도 영향을 주지 않는
    - Lazy Evaluation
        - `print([2-1, 9/4, 3*7, 10+1])`
        - eagar evaluation
            - 함수 호출전에 모든 인자 목록을 계산해놓음
            - 다 계산해두고, 어딘가에 저장해둠
        - lazy evaluation
            - 실제함수 호출시 그 값이 필요할 때까지 계산하지 않는다.
            - 해당 배열에 접근하기 전까지는 계산하지 않는다.
            - 함수형 언어는 새로운 것을 계속 복사해서 사용하기 때문에 계속해서 메모리를 늘릴 수가 없음
            - 이러한 것이 적용이되서, 복사해서 사용한다고 해도, 실제 선언된 부분에 찾아가서 접근할 때 뒤늦게 계산이 됨
            - 혹은 해당 인스턴스의 값이 변경되었다면, 그때 복사를 수행함
            - 이러한 방법을 copy on write라고 함
            - [스위프트 Copy on write]([https://hyerios.tistory.com/25](https://hyerios.tistory.com/25))
    - 익명 함수 vs 클로저
        - 함수는 클로저의 일종
        - 람다 계산식의 구현체
        - 선언된 범위의 변수를 캡쳐해서 저장하고, 닫힘
        - 일단 참조 캡쳐가 기본
        - 그렇기 때문에 기본적으로 함수형 패러다임에서 원하는 방법은 아님.
            - 클로저 안에서 사용하는 변수도 다 불변하게 복사해서 사용해야지!
            - 근데 그게 현실적으로 어려운 부분도 있다는 것
    - 재귀 호출
        - 순수한 함수형 언어에서는 변화하는 값(반복문에서 i가 변화함)을 사용할 수 없기 때문에 재귀적으로 로직을 구현한다.
    - 일급 함수, 고차함수
    - 자동 메모리 관리
        - Copy on write
    - 타입 시스템(타입 추론)
        - 이거 안해주면 컴파일러가 힘든 것
        - 명시적으로 적어주는게 더 나을 수도


# Functor



# Nonad