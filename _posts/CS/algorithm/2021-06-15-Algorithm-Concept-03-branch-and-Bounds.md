---
layout: post
title: "03: Branch and Bounds"
category: "CS/Algorithm"
comments: true
tags: [알고리즘, "알고리즘 개념잡기", "분기한정법", "배낭 채우기 문제", "외판원 문제"]
feature-img: "assets/img/71.jpg"
feature-title:
use_math: true
series: "Algorithm Concept"
summary: ""
---

# 분기 한정법

* Branch : 이전 상태 공간 트리에서 다음 가지로 넘어가는 경우를 말함
* Bound : 한계
* 이전의 백 트레킹과 크게 다르지 않다.
* 그 부분 집합의 합을 구하는 문제와 크게 다르지는 않다.
* 결국 특정 노드를 방문했을 때, 이후를 쭉 봤을 때, 이놈이 갈수 있는 최대치? 혹은 최소치가 기대가 되면 가고 애초에 글렀으면 안가는 것
* 이전과 다른점은, 해당 노드의 값을 기준으로 판단하는 것이 아니고
* 더 나아가서 이 값을 기준으로 나머지 값의 한계 Bound를 찾고 이를 기준으로 판단한다는 것이다.
* 결국 포텐셜을 본다는 것(... 에혀)


# 0-1 배낭 채우기 문제

* 자 다시 돌아왔다.
* W의 무게를 담을 수 있는 가방이 있을 때
* 가치 pi, 각각의 무게 wi가 있는 물건 n개가 있다면
* 가장 가치를 높히면서 가방에 담을 때의 물건 리스트는?

![image](https://user-images.githubusercontent.com/37871541/122235894-03bf9d80-cef9-11eb-8cc2-e253e254955d.png){: .center-small}_상태 공간 트리_

* 자 얘를 간단하게 생각해보면 이런 상태공간 트리가 생긴다.
* 물건이 n개라면 2^n개의 말단 노드가 생기는 거지.
* 그리고 거기서 꼭 판단을 해야해
* 이전에는 이런 접근도 했었어.
* 동적 계획법을 사용해서, i번째까지의 물건을 고려했을 때, w의 무게를 넘지 않는 최대 가치라고 정의를 하고
* 그럼 그 상태에서 i번째 물건을 넣었을 때의 가치와 넣지 않았을 때 가치를 비교해서 업데이트를 하는 거지.
* 하지만 이 방법 역시 마지막 값을 구하기 위해 2개의 비교가 필요했고,
* 결국 물건이 n개인 경우 2^n 정도의 시간 복잡도가 발생했지.


## Branch and bounds : DFS
![image](https://user-images.githubusercontent.com/37871541/122236335-65800780-cef9-11eb-814f-5337e12c0937.png){: .center-small}_branch and bound를 사용_

* 자, 그럼 이번에는 이렇게 해보자.
* 내가 특정 노드를 방문했을 때, 이후로 가질 수 있는 최대 가치를 알 수 있다고 생각해보자.
* 그럼 내가 지금까지 얻은 가치보다, 얻을 수 있는 최대 가치가 더 크대,
* 돈 여기다가 투자하면 지금 번거보다 20%더 번대
* 그러면 투자 하잖아.
* 똑같이 그런 경우에는 탐색을 진행하는 거야.
* 그런데 얘가 최대 가치를 계산해봤자 안돼
* 그러면 내가 투자를 왜해.
* 이런 느낌이야.
* 그럼 이걸 어떻게 구할지를 생각해보자.
  * 일단 무게당 가치가 높은게 먼저 오는게 맞아보이니, 이 순서로 정렬해둔 상태로 시작해보자.
  * profit : i번째 노드까지 방문했을 때, 이때까지 넣은 아이템의 가치 합
  * weight : i번째 노드까지 방문했을 때, 이때까지 넣은 아이템의 무게 합
  * bound : 이 이후로 얻을 수 있는 최대 가치 (물건 잘라서 넣을 수 있다고 하자)
  * 이 bound를 구하려면, 몇번째 물건을 넣었을 때 W를 넘는지를 알아야해
  * 예를 들어 6번째 물건까지 넣으니까 W를 넘어가, 그럼 최대 가치를 구하려면 6번째 원소는 빼고
  * 나머지를 다 넣어서 가치를 계산한 다음에 6번째는 잘라서 가치를 계산해서 더해줘야 최대 가치가 나오잖아(이론적)
  * 그 6이라는 숫자를 k라고 해보자. 그러면 i번째 이후부터 k전까지 다 더해줘야겠지?
  * 그러니까
  * bound = profit + $\sum_{j=i+1}^{k-1}p_j$ + (W-totalweight) * pk/wk
  * 여기서 total weight는 k-1번째까지의 무게를 다더한 값이야.
  * 자 그러면 탐색을 하면서, 지금까지 최대 가치를 담을 변수 maxprofit 하나를 잡아주자.
  * maxprofit >= bound이면 탐색할 필요가 없다.
    * 같아도 그러한 이유는 bound는 정말 이론적 최선이기 때문이지.

![image](https://user-images.githubusercontent.com/37871541/122239190-b5f86480-cefb-11eb-924f-026d293cc6a5.png){: .center}_탐색 트리_

* 연습하면서 순차적으로 따라가 보자.







## Branch and bounds : BFS

![image](https://user-images.githubusercontent.com/37871541/122239469-ed671100-cefb-11eb-99bb-685aaa2983d3.png){: .center-small}_BFS_

* 너비 우선 탐색을 진행해보자.
* 탐색 순서만 다르고 모든 것은 같다.

![image](https://user-images.githubusercontent.com/37871541/122239639-0ff92a00-cefc-11eb-92a8-5e259ccdddca.png){: .center-small}_BFS 탐색 순서_



## Branch and bounds : BFS(Best First Search)

* BFS에서 너비 우선 탐색을 수행하기 위해 Queue를 사용해서 구했다.
* 즉 해당 노드에 연결되어 있는 다른 노드를 탐색하는데 있어서
* 연결된 녀석들 먼저 큐에 집어넣고
* 튀어 나온 녀석들에 대해서 같은 작업을 반복함으로써 이를 구현한 것
* 그런데, 이 Queue를 Priority Queue를 사용해서 가장 가능성이 있는 녀석부터
* 탐색한다면 어떨까?

![image](https://user-images.githubusercontent.com/37871541/122240163-839b3700-cefc-11eb-9523-983581b61d52.png){: .center-small}_Best First Search_

* 실제로 해보면 탐색 개수가 많이 줄어들었다.



# 외판원 문제

* 하나의 노드를 출발하여 다른 노드를 한번만 방문하고 처음으로 돌아오는 가장 짧은 경로를 구하는 문제
* 즉 택배 아저씨가 어떻게 하면 최단거리로 다 배달하고 집에와서 쉴까? 의 문제이다.
* 만약에 모든 가지수를 판단한다면 (n-1)!이다.
* 이런 경로가 아예 그래프에 있다.

![image](https://user-images.githubusercontent.com/37871541/122240979-2784e280-cefd-11eb-8695-9e749b8026e7.png){: .center-small}_헤밀토니안 회로_

* 이것을 동적 계획법으로 풀려면 시간 복잡도가 말이 안된다.
* 사실 왜 안되는지는 모르겠다.


![image](https://user-images.githubusercontent.com/37871541/122241481-8c403d00-cefd-11eb-83c0-8f6cf21f97c3.png){: .center-small}_외판원 문제 상태 공간 트리_

* 이렇게 상태공간 트리가 구성된다. 말단 노드는 총 (n-1)!개이다.
* 전략은 분기 한정법으로, 지금까지 방문한 마지막 노드 이후의 모든 노드가 가지는 가중치의 최단 거리를 더해서 Bound를 잡는 것
* 그러니까 무슨 말이냐면..

![image](https://user-images.githubusercontent.com/37871541/122242351-3750f680-cefe-11eb-9909-5fee296c4319.png){: .center-small}
![image](https://user-images.githubusercontent.com/37871541/122242373-3b7d1400-cefe-11eb-8200-7dd230dd3992.png){: .center-small}

* 자 잘보면, 첫번째 v1~v5까지의 최단 거리를 모두 더해서 일주 경로의 bound를 잡았다.
* 생각해보면 이건 잘못됐다. 불가능할지도 모르는 경로인데..
* 그게 포인트이다. 하지만 가능성이 있긴하다. 즉, 정말 기적적으로 운이너무좋아 그래서 얻는 결론을 bound로 잡자는 것
* 아하..
* 그러니까 두번째 세번째 그림을 보면,
* 특정 위치까지 간다음에 안간 노드에 대해서 최단거리만 쏙쏙 빼서 그 경로까지 갔을 때의 Bound로 잡는다.
* 여기서 배울 수 있는 점은, bound는 이론적으로 가장 이상적인 값으로 계산하는것이 맞다는 것.


## 직접 해보기


![image](https://user-images.githubusercontent.com/37871541/122242847-9a428d80-cefe-11eb-8c37-460c9bed45ea.png){: .center-small}
![image](https://user-images.githubusercontent.com/37871541/122242868-9f074180-cefe-11eb-83ec-0636062ec96c.png){: .center-small}
![image](https://user-images.githubusercontent.com/37871541/122242884-a4fd2280-cefe-11eb-8097-fc94a3d88ea1.png){: .center-small}
![image](https://user-images.githubusercontent.com/37871541/122242901-a9294000-cefe-11eb-92bb-6f4e9c547dc0.png){: .center-small}
![image](https://user-images.githubusercontent.com/37871541/122242931-adedf400-cefe-11eb-8206-8e6cc399e4aa.png){: .center-small}
![image](https://user-images.githubusercontent.com/37871541/122242952-b1817b00-cefe-11eb-85a4-2c61bd954747.png){: .center-small}


* 그런데 여전히 시간 복잡도는 거의 지수다 ^^
* 제프딘은 n^2에 풀 수 있다고 한다.
* 여튼 그래서 n=40만 되도 못푼다고 한다.