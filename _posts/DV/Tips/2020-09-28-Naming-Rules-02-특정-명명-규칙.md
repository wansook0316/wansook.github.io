---
layout: post
title: "02: 특정한 명명 규칙"
category: "DV/Tips"
comments: true
tags: [Tips, Naming]
feature-img: "assets/img/1.jpg"
feature-title:
use_math: true
series: "Naming Rules"
summary: "일반적인 규칙을 제외하고, 특이한 경우를 알아본다."
---

# 1. get/set은 반드시 속성(attribute)에 직접 접근할 때 사용한다.

C++ 개발 커뮤니티에서 일반적인 용례이며, 자바에서는 거의 표준이 되었다.

```java
employee.getName();
employee.setName(name);
matrix.getElement(2, 4);
matrix.setElement(2, 4, value);
```

# 2. compute는 무언가 계산하는 메서드에서 사용한다.

```java
valueSet->computeAverage();
matrix->computeInverse();
```

이 것은 시간을 소비할 수 있는 연산이라는 것을 즉시 알아챌 수 있는 단서를 제공해 반복해서 사용한다면 결과를 따로 저장해 두는 것을 고려하도록 할 수 있다. 이처럼 용어를 일관되게 사용하면 가독성을 향상시키게 된다.

# 3. find는 무언가를 찾는 메서드에서 사용한다.

```java
vertex.findNearestVertex();
matrix.findMinElement();
```

최소한의 계산이 포함된, 간단한 검색 메서드라는 것을 즉시 알아챌 수 있는 단서를 다른 개발자에게 제공한다.

# 4. initialize는 객체 또는 개념을 만들 때 사용한다.

```java
printer.initializeFontSet();
```

영국어 initialise보다 미국어 initialize를 사용해야 하며, 약어 **init 는 피하도록 한다.**

# 5. GUI 요소(component)를 나타내는 변수는 해당 요소 타입 이름을 접미어로 사용한다.

`mainWindow`, `propertiesDialog`, `widthScale`, `loginText`, `leftScrollbar`, `mainForm`, `fileMenu`, `minLabel`, `exitButton`, `yesToggle`, 등...

해당 변수 타입을 통해 리소스 객체를 즉시 알아챌 수 있는 단서를 사용자에게 제공하므로 가독성을 향상시킨다.

# 6. 복수형은 객체 모음(collection)을 나타내는 이름에 사용해야 한다.

```c++
vector <Point>  point;
int  values[];
```

변수 타입과 더불어 해당 요소에 수행할 수 있는 연산을 즉시 알아챌 수 있는 단서를 사용자에게 제공하므로 가독성을 향상시킨다.

# 7. 접두어 n 은 객체 수를 나타내는 변수에 사용한다.

- `nPoints`
- `nLines`

객체 수를 나타내는 이 관례적인 표기법은 수학에서 가져왔다.

# 8. 접미어 "No"는 독자적인(Entity) 번호를 나타내는 변수에 사용한다.

- `tableNo`
- `employeeNo`

Entity 번호를 나타내는 이 관례적인 표기법은 수학에서 가져왔다.

세련된 다른 방법은 iTable, iEmployee 처럼 접두어 i 를 붙이는 것이며, 이를 통해 효과적으로 그런 변수를 명명된 **반복자**로 만들 수 있다.

# 9. 반복자 변수는 i, j, k 등으로 호출한다.

```c++
for ( int i = 0 ; i < nTables ; i++ )
{
...
}

for ( vector<MyClass>::iterator i = list.begin() ; i != list.end() ; i++ )
{
Element element = *i;
...

}
```

반복자를 나타내는 이 관례적인 표기법은 수학에서 가져왔다. 변수 이름으로 i 를 제외한 j, k 등은 중첩 루프에서만 사용한다. (옮긴이 주: 이 표기법은 되도록 간단한 루프에서만 사용하고 복잡하거나 **긴 루프에서는 의미있는 이름을 사용**하는 게 좋다.)

# 10. 접두어 is는 Boolean 변수와 메서드에서 사용한다.

- `isSet`
- `isVisible`
- `isFinished`
- `isFound`
- `isOpen`

C++ 개발 커뮤니티에서 일반적이며, 자바에서는 일부분에서 강제하는 용례이다. 접두어 is를 사용하면 status나 flag처럼 좋지 못한 불리언 이름을 선택하는 흔한 문제를 해결할 수 있다. 사실 isStatus나 isFlag는 적절하지 못하므로 더 의미있는 이름을 선택해야 한다.

다음은 상황에 따라 접두어 is 보다 더 나은 방법 몇 가지로 `has`, `can` 그리고 `should` 접두어를 사용한다.

```c++
bool hasLicense();
bool canEvaluate();
bool shouldSort();
```

# 11. 반의어는 반드시 대응하는 연산에 대해 사용해야 한다.

|    A    |    B    |     A     |     B     |
| :-----: | :-----: | :-------: | :-------: |
|   get   |   set   |    add    |  remove   |
| create  | destroy |   start   |   stop    |
| insert  | delete  | increment | decrement |
|   old   |   new   |   begin   |    end    |
|  first  |  last   |    up     |   down    |
|   min   |   max   |   next    | previous  |
|  open   |  close  |   show    |   hide    |
| suspend | resume  |     -     |     -     |

대칭 관계를 통해 복잡성을 낮출 수 있다.

# 12. 이름에 약어는 피해야 한다.

약어는 되도록이면 피하고, 명시적으로 작성한다.

|      좋은 예      |  나쁜 예   |
| :---------------: | :--------: |
| computeAverage(); | compAvg(); |

## 12.1 사용하면 안되는 약어

문제가 될 만한 단어들은 약어를 사용하지 않는다.

|     O      |  X   |
| :--------: | :--: |
|  command   | cmd  |
|    copy    |  cp  |
|   point    |  pt  |
|  compute   | comp |
| initialize | init |

## 12.1 약어를 사용하는 것이 좋은 경우

그에 반해 약어/두문자어가 더 자연스런 특정 분야의 관용구는 약어 형태를 유지해야 하며, 절대 다음처럼 쓰지 않는다.

|  O   |            X            |
| :--: | :---------------------: |
| html | HypertextMarkupLanguage |
| cpu  |  CentralProcessingUnit  |
| per  |    PriceEarningRatio    |

# 13. 포인터를 이름에 사용하는 것은 특히 피해야 한다.

|      O       |        X        |
| :----------: | :-------------: |
| Line\* line; |  Line\* pLine;  |
|      -       | Line\* linePtr; |

C/C++ 환경에서 많은 변수가 포인터이므로 이와 같은 관례는 따르기가 거의 불가능하다. 또한 C++ 에서 객체는 흔히, 프로그래머가 특정 구현 내용을 무시할 수 있는 간접 타입이다.

포인터를 이름에 사용할 때는 객체의 실제 타입이 특별히 중요할 때에 한해 해당 타입을 강조하기 위해서이다.

# 14. 부정적인(negated) Boolean 변수 이름은 반드시 피해야 한다.

|       O       |     X      |
| :-----------: | :--------: |
| bool isError; | isNoError  |
| bool isFound; | isNotFound |

문제는 이런 이름을 논리 부정 연산자와 함께 사용할 때 이중 부정을 통해 결과가 만들어지므로 생긴다.
`!isNotFound` 의 의미를 즉시 명확하게 알아차릴 수 없다.

# 15. 열거 상수는 공통 타입 이름을 접두어로 붙인다.

```c++
enum Color {
COLOR_RED,
COLOR_GREEN,
COLOR_BLUE,
};
```

이러한 것은 해당 선언을 어디에서 찾을 수 있는지, 어느 상수가 함께 속한 것인지, 그리고 그 상수가 어떤 개념을 나타내는지 등 추가 정보를 제공한다. 다른 방법은 `Color: : RED, Airline: : AIR_FRANCE` 등과 같이 항상 공통 타입을 통해 해당 상수를 참조하는 것이다.

# 16. 예외 클래스는 Exception 접미어를 붙인다.

```c++
class AccessException
{
...
}
```

예외 클래스는 실제 해당 프로그램의 주된 설계 부분이 아니며(옮긴이 주: 프로그램에서 주된 처리 로직이 아니라는 뜻), 이와 같이 이름을 붙이면 다른 클래스와 상대적으로 구별된다.

# Reference

[프로그램 코딩 시 네이밍 규칙과 들여쓰기](https://viiiin.tistory.com/49)
