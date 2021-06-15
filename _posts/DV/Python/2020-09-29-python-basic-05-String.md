---
layout: post
title: "05: String"
category: "DV/Python"
comments: true
tags: [python]
feature-img: "assets/img/3.jpg"
feature-title: ""
use_math: true
series: "Python Basic"
summary: "String에 대해서 깊게 알아보자."
---

# 문자열 할당

```python
nameVar1 = 'Issac'
nameVar1 = "Issac"
```

# 문자열 기본 연산자, 내장 함수

1. `len()`
   입력 파라미터로 문자열을 전달 받는다.
   길이를 결과값으로 돌려준다.
2. `+`
   두 문자열을 하나로 연결하여 결과값을 돌려준다.
3. `*`
   문자열을 뒤에 곱한 수만큼 반복한 형태의 문자열로 돌려준다.
4. `int()`
   입력 파라미터로 전달받은 문자열이 숫자로만 이루어진 경우 정수타입으로 변경하여 돌려준다.
5. `float()`
   실수 타입으로 바꿔서 돌려준다.

# 문자열 할당 시 ' 을 사용해야 하는 경우

1. `""` 으로 감싼다.
2. `\'` 을 사용한다.

# Print() 함수

```python
print(value, ..., sep=' ', end='\n', file=sys.stdout, flush=False)
```

1. `value,...`
   입력 파라미터를 여러개 줄 수 있다.
2. `sep=' '`
   각각의 입력 파라미터를 출력할 때에 구분하는 문자열은 공백이다.
3. `end='\n'`
   모든 입력 파라미터를 출력한 이후에 마지막에는 개행을 하고 마친다.
4. `file, flush` 추후 설명

# input() 함수

`input()` 함수의 리턴값은 기본이 **문자** 이다.

```python
string = input("문자열을 입력하세요 : ")		# char

num_string = input("숫자를 입력하세요 : ")	# char

num = int(input("숫자를 입력하세요 : "))	# int
```

# 문자열 주의 사항

**_문자열은 한번 입력하면 수정이 불가하다!_**

# 실습

## 문자열 뒤집기 프로그램 만들기

문자열이 들어오면 앞뒤를 뒤집어서 화면에 출력한다.

```python
def reverseString(string):
    result = ""
    for i in range(len(string)-1, -1, -1):
        result += string[i]
    return result
```

## 나이 계산 프로그램 만들기

```python
name = input("이름 입력해!!! : ")
old = int(input("몇 살이니??? : "))
now_year = int(input("올 해 몇년??? :"))
future_year = int(input("궁금한 년수 : "))

def calcAge(old, now_year, future_year):
    result = old + (future_year - now_year)
    return result


print(calcAge(old, now_year, future_year), "살 입니다.")
```

## 나이 출력 프로그램 만들기

- 입력 : 주민등록번호 앞자리를 받는다.
- 출력 : 당신의 생일은 OOOO년 OO월 OO일 입니다.

```python
number = input("주민등록번호 앞자리 6자리를 입력해주세요 : ")

def makeBirthdayString(number):
    #print("당신의 생일은 ", "19"+number[:1]+"년", int(number[2:3],"월", int(number[4:5]),"일 입니다.")
    print("당신의 생일은 ", "19" , number[:2], "년 ", int(number[2:4]), "월 ", int(number[4:]), "일 입니다.", sep = "")

makeBirthdayString(number)
```

## 쇼핑 총액 계산 프로그램 만들기

```python
apple = int(input("how many apple?"))
banana = int(input("how many apple?"))
melon = int(input("how many apple?"))
peach = int(input("how many apple?"))
grape = int(input("how many apple?"))

def calcProductSum(apple, banana, melon, peach, grape):
    a = 3000
    b = 2500
    c = 10000
    d = 5000
    e = 4000
    result = apple * a +banana * b + melon * c + peach * d + grape * e
    return result
```
