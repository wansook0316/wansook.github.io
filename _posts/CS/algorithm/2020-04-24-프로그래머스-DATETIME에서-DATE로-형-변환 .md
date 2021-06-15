---
layout: post
title: "09: DATETIME에서 DATE로 형 변환"
category: "CS/Algorithm"
comments: true
tags: [프로그래머스, sql]
feature-img: "assets/img/16.jpg"
feature-title:
use_math: true
series: "Sql Problem"
---

**_level2_** : 제곧내 이다.

# 생각

간단하다. 예시를 보고 외우던가 나중에 찾아보자.

# Code

```sql
SELECT ANIMAL_ID, NAME, DATE_FORMAT(DATETIME, "%Y-%m-%d") AS "날짜"
    FROM ANIMAL_INS;
```

# Reference

[프로그래머스 - DATETIME에서 DATE로 형 변환](https://programmers.co.kr/learn/courses/30/lessons/59414){: target="\_blank"}
