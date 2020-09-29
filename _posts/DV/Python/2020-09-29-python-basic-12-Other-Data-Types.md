---
layout: post
title: "12: Other Data Types"
category: "DS/Python"
comments: true
tags: [python]
feature-img: "assets/img/3.jpg"
feature-title: ""
use_math: true
series: "Python Basic"
summary: "다른 데이터 타입을 알아보자."
---

지금까지 배운 데이터 타입은 정수, 실수, boolean, 문자열, list 였다. 그런데 정수, 실수는 단순한 데이터 타입이므로, 결국 여러 정보를 넣을 수 있는 것은 String, List이다. 그런데 String은 입력할 때에 숫자와 문자를 섞어 넣을 수 있지만, 요소에 접근해 수정할 수 없으므로 우리가 여러 정보를 넣어 처리할 수 있는 것은 리스트가 전부다. 파이썬은 이런 목적에 맞는 다양한 데이터 타입을 제공한다.

# Summary

| Collection | Mutable | Ordered | Duplication | Notation |              Description               | Empty Collection |
| :--------: | :-----: | :-----: | :---------: | :------: | :------------------------------------: | :--------------: |
|   string   |   no    |   yes   |     yes     |   [ ]    |            "simple string"             | s = '' or s = "" |
|    list    |   yes   |   yes   |     yes     |   [ ]    | [ ["item0_0", 12 ], ["item1_0", 22 ] ] |      l = []      |
|   tuple    |   no    |   yes   |     yes     |   ( )    | ( ["item0_0", 12 ], ["item1_0", 22 ] ) |      t = ()      |
|    set     |   yes   |   no    |     no      |   { }    |           { 1, 2, 3, 4, 5 }            |    S = set()     |
| dictionary |   yes   |   no    |     no      |   { }    | { 'one' : 1, 'two' : 2, 'three' : 3 }  |      d = {}      |

# Set

`set`은 정렬되지 않은 수학의 `집합`과 동일한 개념의 데이터 타입으로서, 중복된 값을 가질 수 없다. 아래의 예제에서 exSet1은 set의 규칙에 제대로 부합하는 경우 이지만, exSet2는 중복된 아이템('p')이 섞여 있는 것을 볼 수 있다. 따라서 실제 아래의 코드를 실행해 보면, exSet2에는 Python이 알아서 중복된 값을 하나 제거한 것을 알 수 있다.

## Example 1

```python
exSet1 = { 1, 2, 3, 4, 5 }
print(exSet1)

exSet2 = { 'a', 'p', 'p', 'l', 'e' }
print(exSet2)
```

```
{1, 2, 3, 4, 5}
{'l', 'p', 'a', 'e'}
```

## Example 2

```python
# 빈 집합 만들기
aSet = set()
print("(a)", aSet)

# List를 input으로 넣었을 때
bSet = set([1,2,3,4,5])
print("(b)", bSet)

# 집합을 input으로 넣었을 때
cSet = set({1,3,5,7,9})
print("(c)", cSet)

# range 함수를 넣었을 때
dSet = set(range(5))
print("(d)", dSet)

# tuple을 넣었을 때
eSet = set((2,4,6,8,10))
print("(e)", eSet)
```

```
(a) set()
(b) {1, 2, 3, 4, 5}
(c) {1, 3, 5, 7, 9}
(d) {1, 2, 3, 4, 5}
(e) {2, 4, 6, 8, 10}
```

## 집합 연산

집합을 정의했다면 당연히 연산도 가능할 것이다.

|        연산자        |    수학 기호    |         Python 문법          |
| :------------------: | :-------------: | :--------------------------: |
|    합집합(union)     |   $A \cup B$    |     A.union(B) 혹은 A \$     | \$ B |
| 교집합(intersection) |   $A \cap B$    | A.intersection(B) 혹은 A & B |
|  차집합(difference)  |     $A - B$     |  A.difference(B) 혹은 A - B  |
|  상위집합(superset)  | $A \supseteq B$ | A.issuperset(B) 혹은 A >= B  |
|   부분집합(subset)   | $A \subseteq B$ |  A.issubset(B) 혹은 A <= B   |

```python
aSet = {1,2,3,4,5}
bSet = {1,2,4,8,16}

# 원소 추가
aSet.add(6)
print(aSet)

# 원소 제거
aSet.remove(6)
print(aSet)

# 합, 교, 차
print(aSet | bSet)
print(aSet & bSet)
print(aSet - bSet)

print(aSet.union(bSet))
print(aSet.intersection(bSet))
print(aSet.difference(bSet))

# 상위, 하위
print(aSet >= bSet)
print(aSet <= bSet)
print(aSet >= (aSet - bSet))
```

```
{1, 2, 3, 4, 5, 6}

{1, 2, 3, 4, 5}

{1, 2, 3, 4, 5, 8, 16}
{1, 2, 4}
{3, 5}

{1, 2, 3, 4, 5, 8, 16}
{1, 2, 4}
{3, 5}

False
False
True
```

# Tuple

`tuple`는 여러 부분 리스트와 매우 유사한데, 가장 큰 차이점은 `tuple`의 아이템은 **변경이 불가(immutable)하다**는 점이다.

```python
tempTuple = (1,2,3,4,5)

print(tempTuple)
type(tempTuple)
```

```
(1, 2, 3, 4, 5)

tuple
```

인덱싱과 슬라이싱은 리스트와 비슷하다. 다만 주의해야 하는 점이 있다.

## 요소가 하나 있는 튜플 만들기

튜플에 선언에 있어 ()를 사용하고 있기 때문에 (8)과 같이 선언을 할경우 파이썬은 괄호를 **연산자** 라 판단한다. 따라서 우리가 하나의 튜플 요소를 선언할 경우 (8,) 다음과 같이 명확히 알려주는 문법을 사용해야 한다.

```python
notTuple = (8)
print("[notTuple]", notTuple, type(notTuple))

minTuple = (8,)
print("[minTuple]", minTuple, type(minTuple))
```

```
[notTuple] 8 <class 'int'>
[minTuple] (8,) <class 'tuple'>
```

## 튜플 안에 리스트

튜플은 기본적으로 수정이 불가하다고 생각하지만, 만약 **튜플 안에 리스트** 가 있다면 리스트 내의 요소를 바꿀 수 있다.

```python
sampleList = (["Python", 'B'], ["C++", 'B'])

# 튜플 안 리스트의 요소를 바꾸고 있으므로 가능하다.
sampleList[0][1] = 'A'

# 튜플의 요소를 바꾸고 있으므로 불가능 하다.
sampleList[0] = ["Python", 'B'] # Erron in this statement

```

# Dictionary

Key - Value 의 형태로 저장되어 있는 자료형이다.

1. **Key 는 변할 수 없다.**
2. **Value는 변할 수 있다.**

## 선언 방법 / Value 접근

```python
# 선언
author = {"python" : "person1", "c++" : "person2"}

# 접근
author["python"]

# 삭제
del author["python"]

# 추가
author["python"] = "person1"

for item in author:
    print(item, "is designed by ", author[item])
```

```
c++ is designed by  person2
python is designed by  person1
```

# 실습

## Example 1

(a) 다음과 같이 list 하나는 프로그래밍 언어를, 다른 list는 언어의 개발자 이름을 갖도록 선언합니다.

```python
language = ["python", "c++", "javascript", "go"]
author = ["Guido van Rossum", "Bjarne Stroustrup", "Brendan Eich", "Robert Griesemer"]
```

(b) 함수 matingPairs()를 만드는데, 입력 파라메타로 위의 두 리스트를 받아서, 결과롤 set 타입을 돌려줍니다.

(c) 함수 matingPairs()는 두 리스트에서 각각 하나의 값을 꺼내서 언어 이름별 저자의 tuple을 만든 후,

(d) 함수 matingPairs() 안의 내부 변수인 set 타입 데이터 타입에 (c)에서 만든 tuple을 아이템으로 추가해 줍니다.

(e) 모든 언어에 대한 저자 매핑과, 이를 set에 넣는 과정을 마치면, 함수 matingPairs()은 결과값으로 set를 돌려줍니다.

(f) 함수 matingPairs()의 결과값을 화면에 출력합니다.

```python
language = ["python", "c++", "javascript", "go"]
author = ["Guido van Rossum", "Bjarne Stroustrup", "Brendan Eich", "Robert Griesemer"]

def matingPairs(array1, array2):
    result_set = set()
    for i in range(len(array1)):
        temp_tuple = (array1[i], array2[i])
        result_set.add(temp_tuple)
    return result_set


matingPairs(language, author)
```

```
{('c++', 'Bjarne Stroustrup'),
 ('go', 'Robert Griesemer'),
 ('javascript', 'Brendan Eich'),
 ('python', 'Guido van Rossum')}
```

## Example 2

다음의 요구 사항에 맞는 프로그램을 개발하여 아래의 입력창을 통해서 실행합니다.

(a) `dictionary`의 `key`는 유일해야 하지만 `value`는 유일하지 않아도 됩니다.

(b) `count_values()` 라는 이름의 함수를 구현합니다.

(c) `count_values()` 함수는 하나의 dictionary를 입력 파라메타로 받아서, 이 dictionary가 포함한 서로 다른 value의 개수를 반환합니다.

(d) 예를 들어, `{'red': 1, 'green': 1, 'blue': 2}`가 입력 파라메타로 전달되면, 2를 반환합니다.

```python
def count_values(dic):
    set_dic = set()
    for item in dic:
        set_dic.add(dic[item])
    return len(set_dic)

dic = {'red' : 1, 'green' : 1, 'blue' : 2}

count_values(dic)
```

```
2
```
