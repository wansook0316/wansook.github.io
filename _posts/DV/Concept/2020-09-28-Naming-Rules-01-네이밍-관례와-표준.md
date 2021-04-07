---
layout: post
title: "01: 네이밍 관례와 표준"
category: "DV/Concept"
comments: true
tags: [Concept, Naming]
feature-img: "assets/img/1.jpg"
feature-title:
use_math: true
series: "Naming Rules"
summary: "뒤죽박죽인 내 소스코드에 깔끔함을 선물해보자."
---

가장 중요한 두 가지의 표기법을 알고 읽으면 수월하다.

- 파스칼 표기법
  - 모든 단어에서 첫번째 문자가 대문자이며 나머지는 소문자이다
  - `BackColor`
- 카멜 표기법
  - 최초에 사용된 단어를 제외한 첫번째 문자가 대문자이며 나머지는 소문자이다
  - `backColor`

# 1. 클래스 명에는 파스칼 표기법을 사용한다.

```java
public class HelloWorld
{
...
}
```

# 2. 함수(Method) 명에는 파스칼 표기법을 사용한다.

```java
void SayHello(string name)
{
...
}
```

# 3. 변수와 함수 파라미터에는 카멜 표기법을 사용한다.

```java
int totalCount = 0;
void SayHello(string name)
{
string fullMessage = "Hello " + name;
...
}
```

# 4. 인터페이스에는 접두사 "I"가 포함된 파스칼 표기법을 따른다.

- `IEntity`

# 5. 변수명에 헝가리안 표기법을 사용하지 않는다.

이전에는 많은 프로그래머들이 변수명에 데이터 타입에 해당하는 접두사를 첨가하였다. 즉, 멤버변수에는 아래와 같이 `m_` 을 접두사로 사용하는 것과 같은 헝가리안 표기법을 사용했었다.

```java
string m_sName;
int nAge;
```

그러나 닷넷 코딩 표준에서 헝가리안 표기법은 추천하지 않는다. 데이터 타입을 사용하는 것과 멤버 변수를 표현하기 위한 m* 은 사용해서는 안된다. 모든 변수는 카멜 표기법을 사용해야 한다. 몇몇 프로그래머들은 아직 m* 을 붙이거나 데이터 타입을 표시하는 것을 더 좋아하겠지만, 이제 이것들은 멤버 변수를 확인하기 위한 쉬운 방법이 아니다.

# 6. 변수에 모든 의미를 충분히 담아라(약어를 사용하지 말 것).

|     좋은 예      |   나쁜 예    |
| :--------------: | :----------: |
| string `address` | tring `addr` |
|   int `salary`   |  int `sal`   |

# 7. 한 글자로 된 이름을 사용하지 말 것.

`i`, `n`, `s` 보다는 `index`, `temp` 와 같은 이름을 사용한다.

한 가지 예외가 있다면 루프에서 반복을 의미하는 변수를 하용하는 경우이다.

```java
for ( int i = 0; i < count; i++ )
{
...
}
```

만일 변수가 단지 반복을 위한 카운터로만 사용 된다면, 그리고 그것이 루프 안에 있는 다른 어떤 곳에서도 사용되지 않는다면, 많은 사람들은 아직까지 다른 적합한 단어를 만들어서 사용하는 것보다 `i` 를 사용하는 것을 선호한다.

# 8. 지역변수와 멤버변수는 변수명 앞에 밑줄(`_`)을 사용하여 구별한다.

지역변수에는 변수명 앞에 밑줄을 사용하지 않는다.
멤버변수에는 `m_` 과 같은 헝가리안 표기법을 사용하는 대신 밑줄을 사용하여 지역변수와 구별한다.

# 9. 키워드와 비슷한 이름을 하용하지 말것.

# 10. boolean 이 들어가는 변수, 속성, 함수(method)등은 "is" 또는 유사한 접두사를 사용한다.

- private bool `_isFinished`

# 11. 네임스페이스 명은 표준 패턴을 따라야 한다.

- <회사명>.<제품명>.<최상위모듈>.<하위모듈>
- org.apache.common.lang.StringUtils;

# 12. UI 구성요소를 위해 적당한 접두사를 사용한다.

UI 구성요소를 적당한 접두사를 사용하여 다른 변수들과 구분할 수 있어야 한다.
여기서 추천하는 서로 다른 두 가지 방식이 있다.

## 12.1. 모든 UI 구성요소를 위하여 공통적인 접두사(ui\_)를 사용한다.

이것은 모든 UI 구성요소를 묶는데 도움을 줄 것이고, 쉽게 이해하고 접근할 수 있도록 도와 줄 것이다.

## 12.2. 각각의 UI 구성요소마다 접두사를 적용한다.

간단한 목록이 아래에 있다. 닷넷은 다양한 컨트롤들이 제공되므로 더 많은 컨트롤(써드파티 컨트롤을 포함한)에 대한 표준을 정의해야 한다.

|   Control    | Prefix |     Control     | Prefix |
| :----------: | :----: | :-------------: | :----: |
|    Label     |  lbl   |     ListBox     |  lst   |
|   TextBox    |  txt   |    DataList     |  dtl   |
|   DataGrid   |  dtg   |    Repeater     |  rep   |
|    Button    |  btn   |    CheckBox     |  chk   |
| ImageButton  |  imb   |  CheckBoxList   |  cbl   |
|  Hyperlink   |  hlk   |   RadioButton   |  rdo   |
| DropDownList |  ddl   | RadioButtonList |  rbl   |
|    Image     |  img   |   PlaceHolder   |  phd   |
|    Panel     |  pnl   |      Table      |  tbl   |
|  Validators  |  val   |        -        |   -    |
|      -       |   -    |        -        |   -    |

# 13. 파일 명은 클래스 명과 같아야 한다.

예를 들어, 클래스 명이 "`HelloWorld`" 라면 파일명은 "`HelloWorld.cs`" 이어야 한다.

# 14. 파일 명은 파스칼 표기법을 사용한다.

메서드나 함수 이름은 반드시 동사이면서 소문자로 시작해 대소문자를 섞어 써야 한다.

- `getName()`
- `computeTotalWidth()`

C++ 개발 커뮤니티에서 일반적인 용례이다. 이 형식은 변수 이름과 같지만 C++ 에서 함수는 형식상 변수와 이미 구별된다. 약어와 동의어를 이름으로 사용할 때는 반드시 대문자가 아니어야 한다.

|       좋은 예       |       나쁜 예       |
| :-----------------: | :-----------------: |
| exportHtmlSource(); | exportHTMLSource(); |
|  openDvdPlayer();   |  openDVDPlayer();   |

기본 이름에 대해 모두 대문자를 사용하면 위에서 제시한 명명 규칙과 충돌한다. 이런 종류의 변수는 dVD, hTML 등으로 이름 지어야 하나 분명 가독성이 매우 나쁘다. 위의 예에서 보여준 다른 문제는 이런 이름을 다른 것과 붙여 사용할 때 가독성이 심각하게 나빠진다는 점이다. 즉, 약어 다음에 오는 단어가 원하는 만큼 돋보이지 않게 된다.

# Reference

[프로그램 코딩 시 네이밍 규칙과 들여쓰기](https://viiiin.tistory.com/49)
