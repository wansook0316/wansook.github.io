---
layout: post
title: "03: re module"
category: "DV/Concept"
comments: true
tags: [Concept, 정규표현식]
feature-img: "assets/img/19.jpg"
feature-title: ""
use_math: true
series: "Regular Expression"
summary: "파이썬에서 정규 표현식을 지원하는 re 모듈에 대해 공부하자."
---

정규 표현식은 다양한 언어에서 사용이 가능하다. 이 글에서는 파이썬을 기반으로 정규 표현식을 확인해 보도록 하자.

```python
import re
p = re.compile('ab*')
```

re.compile을 사용하여 정규 표현식(위 예에서는 ab\*)을 컴파일한다. re.compile의 결과로 돌려주는 객체 p(컴파일된 패턴 객체)를 사용하여 그 이후의 작업을 수행할 것이다.

- 정규식을 컴파일할 때 특정 옵션을 주는 것도 가능한데, 이에 대해서는 뒤에서 자세히 살펴본다.
- 패턴이란 정규식을 컴파일한 결과이다.

# Method

|   Method   |                                    목적                                     |
| :--------: | :-------------------------------------------------------------------------: |
|  match()   |             문자열의 **처음부터** 정규식과 매치되는지 조사한다.             |
|  search()  |          문자열 **전체를 검색**하여 정규식과 매치되는지 조사한다.           |
| findall()  |      정규식과 **매치되는 모든 문자열(substring)을 리스트로** 돌려준다.      |
| finditer() | 정규식과 매치되는 모든 문자열(substring)을 **반복 가능한 객체로** 돌려준다. |

match, search는 정규식과 매치될 때는 match 객체를 돌려주고, 매치되지 않을 때는 None을 돌려준다. 각각의 예를 진행하기 전의 아래의 코드를 먼저 수행하자.

```python
import re
p = re.compile('[a-z]+')
```

## Match

> 문자열의 처음부터 정규식과 매치되는지 조사한다.

```python
>>> m = p.match("python")
>>> print(m)
<_sre.SRE_Match object at 0x01F3F9F8>Z
```

"python" 문자열은 `[a-z]+` 정규식에 부합되므로 match 객체를 돌려준다.

```python
>>> m = p.match("3 python")
>>> print(m)
None
```

"3 python" 문자열은 처음에 나오는 문자 3이 정규식 `[a-z]+`에 부합되지 않으므로 None을 돌려준다. match의 결과로 match 객체 또는 None을 돌려주기 때문에 파이썬 정규식 프로그램은 보통 다음과 같은 흐름으로 작성한다.

```python
p = re.compile(정규표현식)
m = p.match( 'string goes here' )
if m:
    print('Match found: ', m.group())
else:
    print('No match')
```

검색되지 않은 경우 작업을 수행하지 않는다.

## search

> 문자열 전체를 검색하여 정규식과 매치되는지 조사한다.

```python
>>> m = p.search("python")
>>> print(m)
<_sre.SRE_Match object at 0x01F3FA68>
```

match와 동일한 결과이다. 하지만 아래의 예는 결과가 다르다.

```python
>>> m = p.search("3 python")
>>> print(m)
<_sre.SRE_Match object at 0x01F3FA30>
```

"3 python" 문자열의 첫 번째 문자는 "3"이지만 search는 문자열의 처음부터 검색하는 것이 아니라 문자열 전체를 검색하기 때문에 "3 " 이후의 "python" 문자열과 매치된다. 이렇듯 match 메서드와 search 메서드는 문자열의 처음부터 검색할지의 여부에 따라 **다르게 사용**해야 한다.

# findall

> 정규식과 매치되는 모든 문자열(substring)을 리스트로 돌려준다.

```python
>>> result = p.findall("life is too short")
>>> print(result)
['life', 'is', 'too', 'short']
```

"life is too short" 문자열의 'life', 'is', 'too', 'short' 단어를 각각 `[a-z]+` 정규식과 매치해서 리스트로 돌려준다.

# finditer

> 정규식과 매치되는 모든 문자열(substring)을 반복 가능한 객체로 돌려준다.

findall과 마찬가지로 문자열에 해당하는 단어를 돌려준다. 하지만 우리가 이 정규 표현식을 사용하는 경우 중에서, 하나의 문자열에 존재하는 다양한 단어들에 대해 다시한번 검색을 진행하고 싶을 수 있다. 이런 경우 findall은 리스트를 결과값으로 뱉기 때문에 이러한 작업을 진행하기 어렵다. 이러한 필요성에서 finditer method는 굉장히 유용하다.

```python
>>> result = p.finditer("life is too short")
>>> print(result)
<callable_iterator object at 0x01F5E390>
>>> for r in result: print(r)
...
<_sre.SRE_Match object at 0x01F3F9F8>
<_sre.SRE_Match object at 0x01F3FAD8>
<_sre.SRE_Match object at 0x01F3FAA0>
<_sre.SRE_Match object at 0x01F3F9F8>
```

match 객체를 리턴하기 때문에 우리는 이를 기반으로 다른 검색을 진행할 수 있다.

# Reference

[07-2 정규 표현식 시작하기](https://wikidocs.net/4308)
