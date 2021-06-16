---
layout: post
title: "01: Greedy"
category: "CS/Algorithm"
comments: true
tags: [알고리즘, "알고리즘 개념잡기"]
feature-img: "assets/img/71.jpg"
feature-title:
use_math: true
series: "Algorithm Concept"
summary: ""
---

# 그래프 용어

* V : vertex
* E : Edge
* path
* 연결 그래프 : 어떤 두 정점 사이에도 경로가 존재하는 그래프
* 부분 그래프
* 가중치 포함 그래프 : Edge에 가중치가 달려있음
* 순환 경로
* 순환 그래프, 비순환 그래프
* 트리 - 비순환, 비방향그래프
* 신장 트리 : 연결된, 비방향성 그래프에서 순환경로를 제거하면서 연결된 부분 그래프가 되도록 하는 트리
  * 신장 트리의 개수는 Cayley's formula에 따른 개수를 가짐


# 최소비용신장트리

* 신장 트리가 되는 부분 그래프 중에서 가중치가 최소가되는 부분 그래프
* 무조건 트리로 나온다. 왜냐하면 순환 경로가 없어야 하기 때문
* 브루트 포스
  * n에 대해 신장트리의 개수는 $n^{n-2}$개
  * 안된다.

## Prim 알고리즘

![image](https://user-images.githubusercontent.com/37871541/122215172-e0d7be00-cee5-11eb-9df4-21e86a9c29b7.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/122215361-18466a80-cee6-11eb-806a-7fbec0e031a2.png){: .center}
![image](https://user-images.githubusercontent.com/37871541/122217052-0239a980-cee8-11eb-9307-eaf184bbf6be.png){: .center}_prim algorithm_


* 인접 행렬
  * 연결 안되어 있으면 무한대
  * 연결되면 가중치
  * 나라면 0
  * 방향 그래프가 아니기 때문에 인접행렬은 대칭이다.
* 핵심은 이미 방문한 것에 대해서는 간선을 가지 않는것.
* 가지 않은 것들중 최소를 선택하여 선택한 집합에 넣는것
* 이것을 가능하게 하기 위해서는 현재 선택된 집합으로부터 선택되지 않은 위치로의 최소거리를 계속해서 업데이트 해야한다.
* 알고리즘을 보게되면, Y집합에 넣기 위해 n-1번의 반복, 그리고 각각의 단계에서 가장 짧은 길이를 찾는 과정이 있기 때문에 O(n^2)이다.


## Kruskal 알고리즘


![image](https://user-images.githubusercontent.com/37871541/122215751-8db23b00-cee6-11eb-9c9f-95687b1e6b8d.png){: .center}

![image](https://user-images.githubusercontent.com/37871541/122215766-91de5880-cee6-11eb-8ff8-a87abd8ad0a5.png){: .center}

![image](https://user-images.githubusercontent.com/37871541/122216100-f6011c80-cee6-11eb-94f7-826729c234a3.png){: .center}_kruskal algorithm_


1. 두개의 서로소 집합을 만든다.
2. 그 두개의 노드가 가지는 가중치별로 정렬한다.
3. 해당 연결의 시작 노드와 끝 노드를 가져온다.
4. 각각의 노드 집합을 가져온다.
5. 두 집합이 같은 집합이 아니라면 두 집합을 합친다.


* 해당 알고리즘의 핵심은 최소신장트리를 만족하기 위해서는 최소로 연결된 집합을 만들어야 한다는 것이다.
* 그러기 위해서는 가중치가 작은 노드들끼리 먼저 연결하는 것이 맞다.
* 그리고 연결되었다면, 서로 다른 서로소 집합에 대해 이를 비교할 필요가 있다.
* 이 때 union find 방법을 사용하여 disjoint 집합을 알아내어 이를 비교한다.
* 다르다면 연결하는 것이 맞다. 왜냐하면 가중치별로 낮은 값부터 정렬을 해두었기 때문
* 최악의 경우에는 O(n^2logn)이다.


# 단일 출발점 최단 경로 문제 : 다익스트라

1. 가장 짧은 노드를 편입시킨다.
2. 노드가 편입된 상태에서 선택되지 않은 노드들에 대한 최소 거리를 갱신한다.
3. 반복한다.



# 0-1 Knapsack 문제


![image](https://user-images.githubusercontent.com/37871541/122218570-8b051500-cee9-11eb-910c-bc98285412c3.png){: .center-small}_0-1 가방 채우기_


* 물건의 무게, 가치가 정해져 있고, 가방에 담을 수 있는 무게가 정해져있다고 했을 때,
* 가방의 무게를 넘지 않는 상황에서 가방에 넣은 가치가 최대가 되도록 하는 문제
* 부르트 포스 : 2^n
* 가장 비싼 물건 부터 채운다? x
* 무게가 덜나가는 물건 부터 채운다? x
* 무게당 가치가 높은 물건부터 채운다? x

그럼 빈틈없이 채우는 경우는 할 수 있을까?

* 배낭 빈틈없이 채우기 문제
  * 이건 그리디로 풀면된다.
  * 생각해보면 무게당 가치가 높은 것을 다 채우고, 무게가 안되는 것은 그다음 물건에 대해
  * 잘라서 넣어버리면 끝.


## 동적 계획법 시도



음.. 그럼 이 정의를 만족하려면

```python
P[i][w] = 무게가 w를 넘지 않고, i번째 물건까지의 항목 중에서 얻어진 최고 이익

P[i][w] = max(P[i-1][w]. p[i-1][w-wi]+pi) # 만약 현재 무게가 지금까지 넣은 것의 무게를 넘지 않으면
P[i][w] = p[i-1][w] # 넘어버리면 i번째를 넣지 않아야 함, 이전거 그대로 사용
```

결국 동적 계획법 아이디어는, 변하는 변수를 체크하는 것으로부터 시작하는 것 같다.

![image](https://user-images.githubusercontent.com/37871541/122219726-b1778000-ceea-11eb-9948-8ccb6b1687ba.png){: .center-small}_의사 코드_


![image](https://user-images.githubusercontent.com/37871541/122220031-eedc0d80-ceea-11eb-898d-bc71108816c1.png){: .center-small}_문제점_

하지만 이렇게 될 경우 문제가 발생하는데, n과 W는 독립적이기 때문에, W가 엄청나게 값이 크다면 효율이 굉장히 좋지 않아진다. 그래서 이를 개선해야 하는데, 잘 생각해보면, 모든 무게에 대해 판단할 필요가 없고, 지금 현재 판단하고 싶은 무게를 넣었을 경우, 그렇지 않을 경우만 비교하면 된다.


![image](https://user-images.githubusercontent.com/37871541/122220269-22b73300-ceeb-11eb-9ce2-ce4dcec2235c.png){: .center-small}_해결 방법_

이런식으로 특정 아이템을 넣었을 때를 판별하고 싶다면, 넣었을 경우와 그렇지 않을 경우만 판단하면 된다.  

그런데 이렇게 했을 경우에 시간복잡도는?

![image](https://user-images.githubusercontent.com/37871541/122220655-7e81bc00-ceeb-11eb-80da-964c6dba4086.png){: .center-small}_시간 복잡도 계산_



* 연산으로 비교하는 경우
  * 맨 마지막값을 구하기 위해서는 2번의 비교가 필요
  * 그 이전의 값 역시 2번
  * 결국 n개의 아이템에 대해 2번씩 계산이 늘어나게 됨.
  * O(2^n)
* 필요한 엔트리의 숫자로 판단하는 경우
  * 만약 아이템의 무게가 다 1이야
  * 그러면 이제 아래 그림만큼 필요한 거지. 삼각형 넓이만큼


# Union find

* 서로소 집합을 처리할 때 사용한다.
* Linked list
* array
* Tree
  * 단순한 방법
  * 무게 고려방법
  * 경로 압축 방법
* 서로소인 두 집합에 대해서 처리할만한 연산은,
  * 같은가?
  * 합쳐줘!
* 밖에 없다.


## Linked list 사용

![image](https://user-images.githubusercontent.com/37871541/122221215-09fb4d00-ceec-11eb-9480-7a9717812343.png){: .center-small}_linked list_

* 일단 얘를 사용하면 두개의 포인터를 가지고 있게 된다.
* 첫번째는 내 집합을 가리키는 포인터
* 두번째는 내 다음 원소를 가리키는 포인터
* find : O(1)
* union : 만약 왼쪽을 오른쪽에 붙인다고 하면 왼쪽에 있는 원소 모두 오른쪽으로 붙여야 하니 4번의 포인터 변경이 필요하다.


![image](https://user-images.githubusercontent.com/37871541/122221610-652d3f80-ceec-11eb-8570-6eac51175ee4.png){: .center-small}_최악의 순간 시간복잡도 계산_

* 이게 잘보면 문제점이 있는데,
* 예를 들어 n개의 원소가 있을 때, 순차적으로 뒤에 있는 원소의 집합에 합친다고 생각해보자.
* 그러면 앞에 있는 집합은 계속해서 커지는 상황인데 뒤는 자기 가진만을 원소로 가지는 집합이다.
* 그러면 앞에 원소들의 포인터 이동횟수는 linear하게 증가한다.
* n개의 원소가 모두 한집합이 되는데 까지 포인터 이동횟수를 계산하게 되면 $\sum_i^{n-1}{i}$ 이다.
* 즉 O(n^2)이다.
* 좀더 정확하게 m번의 union을 한다고 하면 O(m^2)이다.


![image](https://user-images.githubusercontent.com/37871541/122222156-f4d2ee00-ceec-11eb-85fc-75507d957239.png){: .center-small}_해결 방법_

*  해결 방법은 굉장히 간단한데, 그냥 더 큰 집합에 작은 집합을 합치는 것이다.
*  이럴 경우 시간 복잡도는 O(nlogn)이다. 왜?

![image](https://user-images.githubusercontent.com/37871541/122222375-2a77d700-ceed-11eb-9220-66e724ab5c46.png){: .center-small}

* 쉽게 그림으로 알아보면
* 자, 특정 원소가 위와 같은 상황에서 몇번 포인터가 변경되는지 보자.
* logn번이다. 



* 자 그러면 이번에는 계속해서 작은 집합하고 연결하는 경우를 보자.
* 1번이다. 안바뀌는 거지
* 그럼 결국 뭐야. 하나의 원소의 포인터 이동은 logn, 모든 원소에 대해 nlogn



## Array 사용

![image](https://user-images.githubusercontent.com/37871541/122223034-c6a1de00-ceed-11eb-8973-dea799edd496.png){: .center-small}array 사용_

* 굉장히 직관적이지?
* i번째 index에 있는 원소의 집합 번호를 value로 그냥 달아버린거지.
* find는 당연히 상수시간
* union같은 경우 같은 집합이라고 묶여 있는 녀석들을 y의 집합 번호로 다 업데이트하면 되겠지.
* 일단 이걸 할 수 있으려면 각각의 집합 번호에 있는 원소들에 대해서 알고 있어야 겠지.
* 그리고 시간 복잡도를 높히려면 당연히 집합을 합치는 데 있어서 해당 원소가 속해있는 집합의 크기를 비교해서 처리하는 것이 좋겠지.


## Tree 사용

![image](https://user-images.githubusercontent.com/37871541/122223530-36b06400-ceee-11eb-9d8b-53d6993719bb.png){: .center-small}_Tree 사용_

* 사실 이게 제일 좋은 방법이야.
* 왜냐하면 해당 작업은 각각의 원소에 접근할 필요가 없어
* 그냥 집합만 알고 있으면 땡이야.
* 그러면 왜 굳이 선형 자료구조를 쓰냐
* 당연히 트리구조를 사용하는게 베스트지. 특정 원소가 어디 속해있는지 찾아가는데 있어서 logn이 걸리니까.
* 아 물론 기존의 find 보다 상수시간보다는 오래 걸리지.
* 근데 union에서 엄청난 장점이 있지.
* logn으로 찾고 해당 노드의 포인터를 다른 노드의 집합 원소에 걍 붙여버리면 끝이거든.




![image](https://user-images.githubusercontent.com/37871541/122223990-a32b6300-ceee-11eb-9e4d-bf902bffecff.png){: .center-small}_문제점_

* 아 그런데 여전히 문제가 있어.
* 트리 문제 알지? 잘못하면 그냥 링크드리스트랑 똑같은 거여
* 그러면 결국 합치는데 있어서 만약에 큰집합을 작은 집합에 붙이면 (x1을 x2에 붙여라가 default임)
* 포인터 변경은 1회이지만, 이동이 결국 많이 발생해.
* x1이 해당된 노드를 계속 타고올라가야 하는데 줄줄이 다발이니까 계속 시간이 걸릴거아냐.


![image](https://user-images.githubusercontent.com/37871541/122224461-17fe9d00-ceef-11eb-8900-35a7c11aed6e.png){: .center-small}_해결방법_

* 아니 그러면 이전에 했던 것처럼 큰놈을 작은놈에게 붙이지 말자.
* 큰놈인지 작은놈인지 판단하고 작은놈을 붙여서 해결하자.
* 트리니까 이번에는 아래로 늘어진, 즉 무게를 기반으로 하는 거야
* 이 무게는 결국 트리의 깊이가 되겠지. 깊이가 깊어지면 결국 무거워지잖아. 탐색하기가
* 그러니까 즉, 깊이가 낮은놈을 깊이가 깊은놈 한테 연결해 버려서 이전처럼 중복해서 포인터 이동이 발생하지 않도록 해보자.
* 이런거야.
* 위의 그림보면 결국 왼쪽 같은 경우 깊이가 깊은 놈을 낮은놈한테 연결해버려서 이전보다 1만큼 깊이가 늘어났지.
* 그런데 오른쪽 같은 경우 낮은 놈을 깊은놈한테 열결해서 깊이가 이전보다 줄어들었어
* 결국 깊이가 낮은게 최고 좋다 이거야. 그래야 find 연산이 적게들지.


![image](https://user-images.githubusercontent.com/37871541/122225222-d7535380-ceef-11eb-9d1f-9a070de88fbc.png){: .center-small}_최고 깊이는?_

* 그럼 최고 깊이를 판단해보자. 
* 최고 깊어지도록 한번 해보면, 위와 같이 결국 깊이는 3이야.
* 즉 최대 높이는 n개의 원소에 대해 logn인거지.
* 이걸 m번 union한다고 하면 한번의 union에 대해 logn의 find를 수행
* O(mlogn)

![image](https://user-images.githubusercontent.com/37871541/122227109-8f353080-cef1-11eb-9e7e-ce86ee9f01ad.png){: .center-small}
![image](https://user-images.githubusercontent.com/37871541/122227370-c572b000-cef1-11eb-9800-07fbb68b9d6f.png){: .center-small}_경로 압축_

* 자 그런데, find를 할 때, 경로 압축까지 할 수 있다.
* 찾는 과정은 재귀적으로 수행되는데 이때, 최고 root node를 찾았다면 돌아오면서 찾았던 node를 root의 자식으로 만들어 버리는 것
