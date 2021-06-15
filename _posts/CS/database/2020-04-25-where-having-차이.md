---
layout: post
title: "where와 having의 차이"
category: "CS/Database"
comments: true
tags: ["database", SQL, having, where]
feature-img: "assets/img/48.jpg"
feature-title:
series: "SQL"
use_math: true
---

sql에서 조건문을 담당하는 쿼리인 having과 where의 차이를 알아본다.

# Where

> select \* from 테이블명 where 조건절

위와 같은 방법으로 where 조건절을 사용한다. **항상 from뒤에 위치**하고 조건에는 다양한 비교연산자들이 사용되어 구체적인 조건을 줄 수 있다.

# having

> select \* from 테이블명 group by 필드명 having 조건절

> 위와 같은 방법으로 having 조건절을 사용한다. **항상 group by뒤에 위치**하고 where 조건절과 마찬가지로 조건에는 다양한 비교연산자들이 사용되어 구체적인 조건을 줄 수 있다.

# 차이점

where은 기본적인 조건절로서 **우선적으로 모든 필드를 조건에 둘 수 있다.**  
하지만 having은 group by 된 이후 특정한 필드로 **그룹화 되어진 새로운 테이블에 조건을 줄 수 있다.**

즉, 전체 테이블 자체에서 쿼리를 수행하고 싶다면 where를, 전체 테이블을 그룹화 한뒤, 그 해당 그룹에서 어떠한 조건을 걸어 가져오고 싶다면 having을 사용한다.

# 예제

[group by - having 문제](https://programmers.co.kr/learn/courses/30/lessons/59041)

위의 문제에서 답은 다음과 같이 나올 수 있다.

```sql
SELECT NAME, COUNT(NAME) AS "Count" FROM ANIMAL_INS
    GROUP BY NAME
    HAVING COUNT(NAME) > 1;
```

현재 문제는, 내가 갖고 있는 table을 name이라는 키워드로 분리한 다음, 그 분리한 각각의 set의 크기가 1보다 클 경우에 대해 쿼리를 수행해야 한다. 코드를 잘 읽어보면 이해할 수 있다.
