---
layout: post
title: "08: Class & Method"
category: "DS/Python"
comments: true
tags: [python]
feature-img: "assets/img/3.jpg"
feature-title: ""
use_math: true
series: "Python Basic"
summary: "클래스와 메소드에 대해 알아본다."
---

프로그램을 개발하다 보면, Python에서 제공하는 연관된 데이터와 함수들을 묶어서 사용하면 좋겠다는 생각을 하게 된다. 모듈처럼 단순하게 하나의 화일에 물리적으로 모아 놓는 개념을 넘어서서, 데이터 값과 함수가 상호 의미적으로 연관되어 있는 의미있는 묶음을 의미한다. 이럴 경우 우리는 Class 라는 개념을 사용하게 된다.

# Method와 Class 개념 이해하기

지금까지 배운 함수의 형태를 정리해보자.

1. Built-in functions : 파이썬 언어에서 기본 제공하는 함수
2. Functions inside modules : 모듈에 포함되어 모듈을 import 한후 사용하는 함수 (예: 모듈명.함수명())
3. Programmer defined functions : 프로그래머가 본인의 프로그램안에서 직접 만들어서 사용하는 함수
4. Method

1~3 까지의 함수들은 우리가 앞에서 이미 배웠던 것들이지만 4번의 개념은 처음 들어본다.

그런데, String을 배우면서 이미 이것을 활용해보았는데,

```python
sentence = 'Mary had a little lamb'
sentence.count('a')

>>> 4
```

이것이 바로 그것이다. 이 함수는 1~3의 어디도 들어가지 않는데, 이런 함수를 Method 라 부른다.

위의 `sentence` 는 `string` 타입이다. 그런데 이 `string` 타입인 `sentence` 안에는 `Mary had a little lamb` 이라는 데이터가 있으며, 이 데이터 안에 글자를 세는 `count()` 와 같은 함수도 묶여있다.

이렇게 데이터와 함수가 묶여있는 타입을 **Class** 라 부르며, Class 안의 함수들을 **Method** 라 한다. 이 Class 타입으로 부터 만들어진 녀석을 **Object** 라 한다.

# 문자열 Class Methods 알아두기

```python
tempString = "String..Method"
print(tempString.capitalize())
print(tempString.upper())
print(tempString.lower())
print(tempString.center(30))
print(tempString.count('.'))


>>> String..method
>>> STRING..METHOD
>>> string..method
>>>        String..Method
>>> 2
```

## format()

```python
print('{0} ate {1} apples {2}'.format('I', '3', 'yesterday'))
print('{0} ate {1} apples {2}'.format('You', '5', 'at 2 pm'))
print('{1} ate {0} apples {2}'.format('5', 'You', 'at 2 pm'))
print('{} ate {} apples {}'.format('I', '3', 'yesterday'))

import math
myPi = math.pi

print('{0} {1:.4f} '.format(2,myPi) )
print('Pi rounded to {0} decimal places is {1:.5f}.'.format(4, myPi))


>>> I ate 3 apples yesterday
>>> You ate 5 apples at 2 pm
>>> You ate 5 apples at 2 pm
>>> I ate 3 apples yesterday
>>> 2 3.1416
>>> Pi rounded to 4 decimal places is 3.14159.
```

문자열.format() 을 사용하면, 결과값의 형태를 규격화 할 수 있다.

# 실습

## 문자열에서 해당 문자 찾기

1. string method인 `find()`를 사용하여 'tomato'단어 안에 첫번째 'o' 의 위치(인덱스)를 찾아내어 출력하시오.
2. string method인 `find()`를 사용하여 'tomato'단어 안에 두번째 'o' 의 위치(인덱스)를 찾아내어 출력하시오.

```python
print("tomato".find('o'))
print("tomato".find('o', "tomato".find('o')+1))
print("tomato".find('z'))

>>> 1
>>> 5
>>> -1
```

`find` 함수의 입력 파라미터로 어디서 부터 조사할지 값을 주어주면 그 부분부터 조사한다. 만약에 없는 문자열을 찾는다면 `-1` 을 출력한다.
