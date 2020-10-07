---
layout: post
title: "03: 들여쓰기"
category: "DV/Tips"
comments: true
tags: [Tips, Naming]
feature-img: "assets/img/1.jpg"
feature-title:
use_math: true
series: "Naming Rules"
summary: "코드를 작성할 때의 모양을 결정하는 들여쓰기 규칙을 알아본다."
---

# 1. 들여쓰기 기본

1. TAB 을 사용한다.
2. SPACE를 사용하지 않는다.
3. Tab 사이즈는 4로 정의한다.

# 2. 주석은 코드와 같은 레벨에 있어야 한다.

> 들여쓰기의 레벨을 같이 사용한다.

## 좋은 예

```c++
// Format a message and display
string fullMessage = "Hello " + name;
DateTime currentTime = DateTime.Now;
string message = fullMessage + ", the time is : " + currentTime.ToShortTimeString();
MessageBox.Show ( message );
```

## 좋지 않은 예

```c++
// Format a message and display
string fullMessage = "Hello " + name;
DateTime currentTime = DateTime.Now;
string message = fullMessage + ", the time is : " + currentTime.ToShortTimeString();
MessageBox.Show ( message );
```

# 3. 중괄호는 중괄호 밖에 있는 코드와 같은 레벨에 있어야 한다.

# 4. 논리적인 코드 그룹은 빈 줄 하나로 구분해야 한다.

## 좋은 예

```c++
bool SayHello ( string name )
{
        string fullMessage = "Hello " + name;
        DateTime currentTime = DateTime.Now;
        string message = fullMessage + ", the time is : " + currentTime.ToShortTimeString();
        MessageBox.Show ( message );
        if ( ... )
        {
                // Do something
                // ...

                return false;
        }

        return true;
}
```

## 좋지 않은 예

```c++
bool SayHello (string name)
{
        string fullMessage = "Hello " + name;
        DateTime currentTime = DateTime.Now;
        string message = fullMessage + ", the time is : " + currentTime.ToShortTimeString();
        MessageBox.Show ( message );
        if ( ... )
        {
                // Do something
                // ...
                return false;
        }
        return true;
}
```

# 5. 클래스 내부의 각 메서드 사이에는 단 하나의 빈 줄만 있어야 한다.

# 6. 중괄호는 다른 라인과 분리되어 있어야하며 라인을 같이 쓰면 안된다.

## 좋은 예

```c++
if ( ... )
{
        // Do something
}
```

## 좋지 않은 예

```c++
if ( ... )     {
        // Do something
}
```

# 7. 지시자(operator)와 괄호 앞뒤로는 한 칸의 공간을 남긴다.

## 좋은 예

```c++
if ( showResult == true )
{
    for ( int i = 0; i < 10; i++ )
    {
            //
    }
}
```

## 좋지 않은 예

```c++
if(showResult==true)
{
        for(int    i= 0;i<10;i++)
        {
                //
        }
}
```

# 8. 연관된 코드를 묶을때는 #region을 사용해라.

확장하거나 축소할 수 있는 코드 블록을 지정하자. #region을 사용해서 묶는다면 그 페이지는 훨씬 간략해질 것이다.

# 9. private 멤버 변수, 속성, 그리고 메소드는 파일의 하단에 그리고 public 멤버들을 파일의 하단에 위치하도록 하라.

> switch 문은 다음 형식이어야 한다.

```c++
switch (condition) {
    case ABC :
        statements;
        // 지나감
    case DEF :
        statements;
        break;

    case XYZ :
        statements;
        break;

    default :
        statements;
        break;
}
```

각 case 키워드를 전체 switch 문에 대해 들여쓰기한다는 점에 주의한다. 이를 통해 전체 switch 문을 두드러지게 한다. 또한 ":" 문자 앞에 있는 여분의 빈칸에 주의한다. case 문에 break 문이 없으면 항상 명시적으로 '지나감'이라고 주석을 달아야 한다. break 문이 없는 것은 일반적인 오류이므로, 사용하지 않을 때는 **의도적이라는 것을 명확히** 해야 한다.

> do-while 문은 다음 형식이어야 한다.

```c++
do {
    statements;
} while (condition);
```

이 형식은 위에서 제시한 일반 구역 규칙을 따른다.

> while 문은 다음 형식이어야 한다.

```c++
while (condition) {
    statements;
}
```

이 형식은 위에서 제시한 일반 구역 규칙을 따른다.

> 부동소수점 상수는 항상 소수점과 함께 써야 한다.

```c++
double total = 0.0;          // 아님: double total = 0;
double speed = 3.0e8;    // 아님: double speed = 3e8;
double sum;
    :
sum = (a + b) * 10.0;
```

이는 정수와 부동소수점 수의 본질적인 차이를 강조한다. 수학적으로 두 모델은 완전히 다르며 호환되지 않는 개념이다. 또한 위의 마지막 예제처럼 코드의 어떤 지점에서 명확하지 않을 수 있는 대입되는 변수(sum)의 타입을 강조한다.

> 부동소수점 상수는 항상 소수점 앞에 숫자를 써야 한다.

```c++
double total = 0.5;    // 아님: double total = .5;
```

C++ 에서 숫자와 표현식 시스템은 수학에서 빌려왔으므로 가능한 구문에 대한 수학적 관례를 따라야 한다. 또한 .5보다 0.5가 휠씬 읽기 쉬우며 정수 5와 헷갈리지 않는다.

> 루프 변수는 해당 루프 바로 앞에서 초기화해야 한다.

```c++
isDone = false;        // 아님: bool isDone = false;
while ( !isDone ) {
     ...
}
```

# 10. do-while 루프는 피한다.

do-while 루프는 해당 루프의 가장 아래에 조건이 있기 때문에 일반적인 while 루프와 for 루프보다 가독성이 떨어진다. 해당 루프의 사용 범위를 이해하려면 반드시 전체 루프를 살펴봐야 한다. 게다가 do-while 루프는 while 루프나 for 루프로 쉽게 바꿔 쓸 수 있으므로 필요하지 않다. 이 구조의 사용을 줄여 가독성을 향상시킨다.

# 11. 루프에서 break와 continue 사용을 피해야 한다.

이 문장은 구조적인 대체 코드보다 가독성을 더 높일 수 있을 때만 사용해야 한다.

# 12. 무한 루프는 "while (true)" 형식을 사용한다.

```c++
while (true) {
    :
}
for (;;) {       // 좋지 않음
    :
}

while (1) {    // 좋지 않음
    :
}
```

1에 대해 시험하는 것은 필요하지도 의미적이지도 않다. for (;;) 형식은 가독성이 매우 나쁘며 실제 무한 루프인지 명확하지 않다.

# 13. 파일 내용은 반드시 80 열(column) 내로 유지해야 한다.

80 열은 편집기, 터미널 에뮬레이터, 프린터와 디버거의 공통적인 치수이며 여러 사람이 공유하는 파일은 이런 제한을 지켜야 한다. 이를 통해 프로그래머 사이에 파일을 전달할 때 의도하지 않은 줄바꿈을 피할 수 있어 가독성을 향상시킨다.

# 14. 객체 이름이 암시되어 있으면 메서드 이름에서 반복 사용하지 말아야 한다.

|         O         |           X           |
| :---------------: | :-------------------: |
| line.getLength(); | line.getLineLength(); |

클래스 선언에서 두 번째가 자연스러운 것처럼 보이지만 불필요하게 사용한 예이다.

# Reference

[프로그램 코딩 시 네이밍 규칙과 들여쓰기](https://viiiin.tistory.com/49)
