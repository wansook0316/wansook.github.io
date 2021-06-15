---
layout: post
title: "08: Design Pattern"
category: "DV/Concept"
comments: true
tags: [Concept, "Development Method"]
feature-img: "assets/img/78.jpg"
feature-title: ""
use_math: true
series: "Development Method"
summary: "어떻게 설계해야 하는가?"
---


* 왜?
* 재사용을 위해서!
* 자주 반복적으로 사용되는 것을 모듈화 한다, 함수화 한다, 클래스화 해서 미래에 내가 다시만들지 않고 그대로 사용
* 결국은 시간이 줄어든다. 생산성이 높아짐
* 그런데 이러한 재사용이 코드 뿐인 건가? 글쎄
* 코딩하는 부분은 20~30%밖에 안됨, TDD도 있고 등등
* 정말 중요한 단계는 소프트웨어 설계단계라 할 수 있음.
* 비슷한 소프트웨어를 만든 사람의 설계를 재사용

# 디자인 패턴

* 소프트웨어를 디자인할 때 반복적으로 사용하는 일반적인 솔루션
* 소스가 직접적으로 나오는 것이 아님
* 100% 이 디자인을 쓴다는 것이 아님, 결국 바꿔써야 함.
* 접근 방법만 따고, 내 요구사항에 맞춰 적용하는 것
* Formalized Best Practice
* 프로그래밍 패러다임과 구체적인 알고리즘 사이에 존재하는 접근 방법


# 객체지향 디자인 패턴

* 클래스
  * 데이터
  * 함수
* 상수
* 동적 바인딩
* 상속
* 디자인 패턴이 완전히 프로그래밍과 떼낼 수는 없음
* 즉 얘는 객체지향 패러다임을 가지지 않는 언어인 경우 아예 불가능하기 때문에 같이 생각을 해야하는 부분임
* 혹은 이런 디자인을 했는데, 해당언어는 이미 만족해. 그럼 시간낭비한 것


## Adapter Pattern

* 두개의 소프트웨어가 있다.
* 하나는 이미 사용해온 클래스
* 클라이언트는 이걸 사용하려함. 그런데 서로가 원하는 인터페이스가 달라서, 사용이 불가함
* 예를 들어 클라이언트가 원하는 함수는 정수2개에 정수output, 쓰던 거는 double 3개에 double output
* 이러면 함수가 맞지가 않음
* 안짜고 얘를 사용할 수 있게 해야함. 양쪽다 안고치고 사용하기
* 혹은 2종 언어간에 연동을 해야함
* 이 때 사용하는 것임 220V -> 5V로 변환해주는 Adapter처럼
* 답 : Adapter 소프트웨어를 만들어서 Adapt하면 됨.

![image](https://user-images.githubusercontent.com/37871541/121999729-a63c2b80-cde8-11eb-9b59-8bbd17bbf217.png){: .center-small}_Adapter pattern_

* Target에 Request를 받으면
* Adapter가 받아서 adaptee에한테 보냄
* 그럼 어떻게 짤거야?
* 아래 왼쪽을 먼저 보자.
  * Adapter 는 Target class를 상속받음
  * 상속받기 때문에 Adapter는 여러개가 나올 수 있음
  * 보통 그래서 Target class는 추상클래스임
  * 그 adapter가 adaptee를 콜하는 방식
  * 어떤 언어에서 이런 것이 가능한가?
    * 서브 클래스가 상속받는 것이 하나의 클래스인 경우, 즉 부모 클래스가 하나인 경우는 가능하다.
* 오른쪽을 보자.
  * 오른쪽은 Adaptee도 상속받았다.
  * 아 이얘기군. 
  * 최근 언어에서는 오른쪽과 같은 방식 사용하지 않음(C++이 이러함)
* 맨 오른쪽을 보자.
  * 이건 진짜 단순한 것
  * Adapter를 콜하게하고, 그 Adapter가 adaptee를 호출하는 방식
  * 왠만한 곳에서 사용가능

```python
"""
Adapter pattern example.
"""
from abc import ABCMeta, abstractmethod

NOT_IMPLEMENTED = "You should implement this."

RECHARGE = ["Recharge started.", "Recharge finished."]

POWER_ADAPTERS = {"Android": "MicroUSB", "iPhone": "Lightning"}

CONNECTED = "{} connected."
CONNECT_FIRST = "Connect {} first."

class RechargeTemplate:
    __metaclass__ = ABCMeta

    @abstractmethod
    def recharge(self):
        raise NotImplementedError(NOT_IMPLEMENTED)

class FormatIPhone(RechargeTemplate):
    @abstractmethod
    def use_lightning(self):
        raise NotImplementedError(NOT_IMPLEMENTED)

class FormatAndroid(RechargeTemplate):
    @abstractmethod
    def use_micro_usb(self):
        raise NotImplementedError(NOT_IMPLEMENTED)

class IPhone(FormatIPhone):
    __name__ = "iPhone"

    def __init__(self):
        self.connector = False

    def use_lightning(self):
        self.connector = True
        print(CONNECTED.format(POWER_ADAPTERS[self.__name__]))

    def recharge(self):
        if self.connector:
            for state in RECHARGE:
                print(state)
        else:
            print(CONNECT_FIRST.format(POWER_ADAPTERS[self.__name__]))

class Android(FormatAndroid):
    __name__ = "Android"

    def __init__(self):
        self.connector = False

    def use_micro_usb(self):
        self.connector = True
        print(CONNECTED.format(POWER_ADAPTERS[self.__name__]))

    def recharge(self):
        if self.connector:
            for state in RECHARGE:
                print(state)
        else:
            print(CONNECT_FIRST.format(POWER_ADAPTERS[self.__name__]))

class IPhoneAdapter(FormatAndroid):
    def __init__(self, mobile):
        self.mobile = mobile

    def recharge(self):
        self.mobile.recharge()

    def use_micro_usb(self):
        print(CONNECTED.format(POWER_ADAPTERS["Android"]))
        self.mobile.use_lightning()

class AndroidRecharger:
    def __init__(self):
        self.phone = Android()
        self.phone.use_micro_usb()
        self.phone.recharge()

class IPhoneMicroUSBRecharger:
    def __init__(self):
        self.phone = IPhone()
        self.phone_adapter = IPhoneAdapter(self.phone)
        self.phone_adapter.use_micro_usb()
        self.phone_adapter.recharge()

class IPhoneRecharger:
    def __init__(self):
        self.phone = IPhone()
        self.phone.use_lightning()
        self.phone.recharge()

print("Recharging Android with MicroUSB recharger.")
AndroidRecharger()
print()

print("Recharging iPhone with MicroUSB using adapter pattern.")
IPhoneMicroUSBRecharger()
print()

print("Recharging iPhone with iPhone recharger.")
IPhoneRecharger()
```

어댑터에서 중간에 변경해줌!

### UML (Unified Modeling Language)

![image](https://user-images.githubusercontent.com/37871541/122000537-f36ccd00-cde9-11eb-8f4a-2ccb5f8e4d5e.png){: .center-small}_UML_

* 왼쪽 아래 표가 되게 잘 읽힘
* Aggrefation : 각각의 요소가 그냥 속해 있다는 표현하는 것
* Composition : 각각의 요소 모두가 있어야 슈퍼 클래스가 정의되는 경우
* Association : 관계를 나타낼 때 사용




# Facade Pattern(파사드 패턴)

![마카오]([https://link](https://www.google.com/url?sa=i&url=http%3A%2F%2Fgetabout.hanatour.com%2Farchives%2F279376&psig=AOvVaw0TfURTrCLavqnc41GJgxUo&ust=1623823981836000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMD5m-_9mPECFQAAAAAdAAAAABAD)){: .center-small}_앞에만 남아있음 : 출처 (http://getabout.hanatour.com/archives/279376)_

* 빌딩의 뒤가, 안이 바뀔 수는 있지만 전면부는 절대 바뀌지 않음..!
* 인터페이스는 변하지 않음!
* 클라이언트 쪽에서는 매우 편함
* 사용은 쉬움
* 뒷단은 노출이되지 않도록 함
* 최대한 단순해야 함
* 독립적인 클래스로 만들어서 제공
* 테스트, 이해, 사용에 있어서 강점
* 가독성도 좋음
* 하지만, 잘못 디자인된 API..를 랩핑하는데에도 사용된다.
* 예를 들어 파이썬으로 만들었는데, 너무 느려서 언어를 바꿀거야.
* API는 그대로 두고, 일부를 다른 언어로 바꾸는 방법

![image](https://user-images.githubusercontent.com/37871541/122002666-0634d100-cded-11eb-94a1-84d7b84f10d5.png){: .center}_facade uml_
![image](https://user-images.githubusercontent.com/37871541/122002733-1947a100-cded-11eb-804d-b2a4b3648386.png){: .center}_facade uml_


# Decorator Pattern

![image](https://user-images.githubusercontent.com/37871541/122003103-96731600-cded-11eb-9723-bc90a3e0ed87.png){: .center}_Decorator Pattern_

* 런타임에 동적으로 기능이 추가되던가 제거되어야 하는 경우에 사용됨
* 게임 프로그래밍에서 전통적인 패턴


# 디자인 패턴의 기원

![image](https://user-images.githubusercontent.com/37871541/122003414-04b7d880-cdee-11eb-9b9d-1c12ce7be28a.png){: .center-small}_Bible..?_
![image](https://user-images.githubusercontent.com/37871541/122003458-17caa880-cdee-11eb-9d89-a6587969b566.png){: .center-small}_23 Patterns for mainly Java_

* 1977년에 시작.
* 1987년부터 발전됨, 여전히 노인기
* 1994년 : Design Pattern - Gang of For (GOF)
  * 빅히트


# 디자인 패턴의 단점?

* 언어는 계속 발전한다.
  * Java, C++ -> 이당시 나온 패턴인데, 너무 해준게 없었던거 아니냐?
  * 23개 중 16개는 필요없지 않나?
  * 그런데 사실 발전됨에 따라 또 디자인 패턴은 나옴..
* 언어별로 차이가 크다. 잘못쓰면 엉망이된다.
