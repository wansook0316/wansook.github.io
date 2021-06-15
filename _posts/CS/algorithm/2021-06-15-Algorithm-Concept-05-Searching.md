---
layout: post
title: "05: Searching"
category: "CS/Algorithm"
comments: true
tags: [알고리즘, "알고리즘 개념잡기"]
feature-img: "assets/img/71.jpg"
feature-title:
use_math: true
series: "Algorithm Concept"
summary: ""
---

# 검색 문제

* n개의 키를 가진 배열 S와 키 x가 주어졌을 때, x=S[i]가 되는 첨자 i를 찾는 것
* 없다면 오류로 처리한다.
* 결론 : 이분 검색 알고리즘보다 효율적인 알고리즘은 없다.

![image](https://user-images.githubusercontent.com/37871541/122089259-8c7b0280-ce41-11eb-9469-110ccbbf461e.png){: .center}_이진 검색 상태 공간 트리_
![image](https://user-images.githubusercontent.com/37871541/122089398-ae748500-ce41-11eb-8c21-3376c359827b.png){: .center}_순차 검색은 답이없다._


# 보간 검색

![image](https://user-images.githubusercontent.com/37871541/122090883-3313d300-ce43-11eb-8217-4b30b6ea2425.png){: .center-small}_보간 검색_


* 비교 이외에 다른 추가적인 정보를 이용하여 검색?
* 10개의 정수를 검색하는데, 첫번째 정수는 0-9중 하나,
* 두번째 정수는 10-19중 하나, 이런식으로 되어있다고 하자.
* 이럴 경우 검색키 x와 S[1+x//10]에서 비교
* 즉, 25는 S[1+25//10] = S[3]에서 비교


## Linear Interpolation

![image](https://user-images.githubusercontent.com/37871541/122091059-60608100-ce43-11eb-8931-511012860374.png){: .center-small}_선형 보간_

![image](https://user-images.githubusercontent.com/37871541/122091172-7c642280-ce43-11eb-9c40-190b56b4b350.png){: .center-small}_선형 보간 방법_


![image](https://user-images.githubusercontent.com/37871541/122091722-0f04c180-ce44-11eb-92e2-f05db3df1388.png){: .center-small}_선형 보간의 시간 복잡도_

* 시간 복잡도
  * 최악의 경우 순차검색과 같아짐


# 트리 구조를 사용한 동적 검색

* 정적 검색
  * 데이터가 한꺼번에 저장되어 추후에 추가나 삭제가 이루어지지 않는 경우
* 동적 검색
  * 데이터가 수시로 추가, 삭제되는 유동적인 경우
  * 동적 검색의 경우 배열을 사용하기 어려움. 계속해서 정렬을 해야함


## 이진 검색 트리


![image](https://user-images.githubusercontent.com/37871541/122092055-76bb0c80-ce44-11eb-903a-2ad7f4406ff5.png){: .center-small}_이진 검색 트리_

* 사용하는 이유
  * 일단 inorder 순회 (왼쪽 자신 오른쪽)을 하게 되면 정렬된 순서로 추출 가능
* 평균 검색 시간을 짧게 유지
  * 만약 균형잡힌 트리라면 짧게 유지 가능
  * 하지만 균형을 유지한다는 보장이 없다.
  * 최악의 경우 linked list와 같은 구조가 된다.
  * Random하게 들어갈 경우 평균적으로 효율적인 검색시간을 기대할 수 있음
* 삽입될 때 균형 트리라면 logn으로 가능
* 삭제되는 경우는 사진을 보자.


![image](https://user-images.githubusercontent.com/37871541/122092532-ffd24380-ce44-11eb-9cee-172f6460a109.png){: .center}_두개의 자식 노드가 있는 경우_



![image](https://user-images.githubusercontent.com/37871541/122092691-2ee8b500-ce45-11eb-8e39-aa592a100ffc.png){: .center}_한개의 자식 노드가 있는 경우_

* 삭제 시나리오는 두가지가 있다.
  * 두개의 자식 노드가 있는 경우
    * 해당 노드보다 작은 노드중 가장 큰 노드로 대체
    * 해당 노드보다 큰 노드중 가장 작은 노드로 대체
  * 한개의 자식 노드가 있는 경우
    * 자식 노드를 바로 올려버림


### 이진 검색트리 검색 분석


![image](https://user-images.githubusercontent.com/37871541/122093163-bc2c0980-ce45-11eb-9290-4ebfc1db7fc9.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/122093195-c3ebae00-ce45-11eb-8b7f-4328ed1e4d52.png){: .center-small}

![image](https://user-images.githubusercontent.com/37871541/122093315-eb427b00-ce45-11eb-9baf-cb744008a02f.png){: .center}

* 결국 여전히 최악의 경우 O(n)


## 검색 시간 향상을 위한 트리 구조

* 균형이 중요하다.
* 균형 트리
  * AVL 트리
    * 추가, 삭제, 검색 모두 O(logn)
  * B-트리
    * 잎 마디들의 깊이를 항상 같게 유지
    * 추가, 삭제, 검색 모두 O(logn)
  * Red-Black Tree
    * 추가, 삭제, 검색 모두 O(logn)


