---
layout: post
title: "Char to int"
category: "DV/C++"
comments: true
tags: [c++, "char", "int", "typechange"]
feature-img: "assets/img/2.jpg"
feature-title:
use_math: true
summary: "C++에서 char로 입력을 받을 경우 int로 변환하는 방법을 알아본다."
---

문제를 풀다가 문자를 정수로 바꾸려고 보니 너무 귀찮았다. 그래서 이김에 확실히 해두려고 검색을 시도. 방법은 매우 간단했다. 문자 역시 아스키 코드, 즉 숫자이기 때문에 입력 받은 숫자를 기반으로 `0`문자가 가지는 아스키 코드값을 빼주면 숫자값이 나온다!

```c++
char ch1 = '1';
int num1 = ch1 - '0';
cout << num1;  //1
```

아스키 코드의 순서가 '0' 부터 '9'씩 차례대로 1씩 늘어나므로 위와 같이 작성하면 해당 수의 값을 구할 수 있다.

'1'의 문자의 아스키 코드 값을 보고 싶다면 (int)를 붙여 형 변환을 해준다.

```c++
char ch1 = '1';
int numAscii = (int)ch1;
cout << numAscii;  //49 ('1'의 아스키 코드 값)
```