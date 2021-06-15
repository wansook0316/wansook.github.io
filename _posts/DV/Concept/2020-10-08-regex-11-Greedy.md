---
layout: post
title: "11: Greedy 와 Non-Greedy"
category: "DV/Concept"
comments: true
tags: [Concept, 정규표현식, "greedy"]
feature-img: "assets/img/19.jpg"
feature-title: ""
use_math: true
series: "Regular Expression"
summary: "정규식에서 Greedy는 무엇을 의미할까?"
---

Greedy는 알고리즘 문제를 풀 때 보았던 용어이다. 이 용어는 어떤 의미로 사용이 될까? 무언가 탐욕적으로 한다는 의미일 것이다. 다음과 같은 문자열에서 처음 나오는 tag를 검색하고 싶다 해보자.

```python
>>> s = '<html><head><title>Title</title>'
>>> len(s)
32
>>> print(re.match('<.*>', s).span())
(0, 32)
>>> print(re.match('<.*>', s).group())
<html><head><title>Title</title>
```

`<.*>` 정규식의 매치 결과로 `<html>` 문자열을 돌려주기를 기대했지만 `*` 메타 문자는 매우 **탐욕스러워서** 매치할 수 있는 최대한의 문자열인 `<html><head><title>Title</title>` 문자열을 모두 소비해 버렸다. 어떻게 하면 이 탐욕스러움을 제한하고 `<html>` 문자열까지만 소비하도록 막을 수 있을까?

다음과 같이 `non-greedy` 문자인 `?`를 사용하면 `*`의 탐욕을 제한할 수 있다.

```python
>>> print(re.match('<.*?>', s).group())
<html>
```

non-greedy 문자인 `?`는 `*?`, `+?`, `??`, `{m,n}?`와 같이 사용할 수 있다. 가능한 한 가장 최소한의 반복을 수행하도록 도와주는 역할을 한다.

# Reference

[07-2 정규 표현식 시작하기](https://wikidocs.net/4308)
