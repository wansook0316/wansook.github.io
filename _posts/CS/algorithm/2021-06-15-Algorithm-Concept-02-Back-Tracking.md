---
layout: post
title: "02: Back Tracking"
category: "CS/Algorithm"
comments: true
tags: [알고리즘, "알고리즘 개념잡기","백트래킹", "DFS", "BFS", "Best First Search", "배낭 채우기 문제", "N queen", "부분집합의 합"]
feature-img: "assets/img/71.jpg"
feature-title:
use_math: true
series: "Algorithm Concept"
summary: ""
---

# 트리 방문

![image](https://user-images.githubusercontent.com/37871541/122227739-21d5cf80-cef2-11eb-9277-460e8dc024b9.png){: .center-small}_트리 방문 방법_

* preorder
  * 자신, 좌측, 우측
  * 용어의 이유는 도저히 알 수가 없다...
  * 아마 방문 전(pre)에 나부터 방문하라는 뜻...?
* inorder
  * 좌측, 자신, 우측
  * 안(in) 부터 방문
* postorder
  * 우측, 자신, 좌측
  * 나중(post) 부터 방문
* level order
  * tree의 깊이 별로 방문


# DFS

* 뿌리 부터 방문해서 해당 마디의 후손을 차례로 방문한다.
* 보통 왼쪽에서 오른쪽으로 방문


# N Queen

![image](https://user-images.githubusercontent.com/37871541/122228398-c3f5b780-cef2-11eb-9c30-799572543170.png){: .center-small}_상태공간을 계층적으로 표현_
![image](https://user-images.githubusercontent.com/37871541/122228591-f69fb000-cef2-11eb-9198-9feee385ffbd.png){: .center-small}_상태 공간 트리_
* 퀸이 서로 겹치지 않도록 nxn 체스판에서 퀸을 놓는 방법을 구하는 문제.
* 퀸 n개를 놓는 공간에 따라 발생하는 상태를 나타낸 것을 상태 공간 이라 한다.
* 위의 구조를 트리 형태로 나타낼 수 있다. 
* 아래로 내려가면서 해당 깊이에서 선택한 값을 저장해두는 것

## 백 트레킹

![image](https://user-images.githubusercontent.com/37871541/122228616-fd2e2780-cef2-11eb-8fcb-1e2a4301db64.png){: .center-small}_백 트레킹_

* 그런데 이런 상태 공간은 n이 4라고 하면 굉장히 많아진다.
* 조금만 생각해보면 모든 노드에 대해 탐색해야 하는 필요성이 있는지 의문이 든다.
* 애초에 안되는 경우는 탐색을 안하는 것이 맞기 때문
* 이걸 가지치기 방법, 백 트레킹이라 한다.

![image](https://user-images.githubusercontent.com/37871541/122229001-572eed00-cef3-11eb-951f-f763e268e6f7.png){: .center-small}_백 트래킹을 사용한 4 queens_


### DFS, Back Tracking


![image](https://user-images.githubusercontent.com/37871541/122229240-8b0a1280-cef3-11eb-9f77-b6906bf444e0.png){: .center-small}_깊이 우선 검색시 검색 마디 개수_

* 그냥 dfs를 하면 답안을 찾는데 까지 155개
* back tracking을 사용하면 27개
* 사실 지금은 구조를 어떻게 짰냐면
  * 특정 마디에 방문
  * 해당 마디가 가능한지 확인
    * 해당 마디에 연결된 것들 시도
* 와 같이 구성이 되어 있다.
* 하지만 실제로는
  * 해당 마디에 방문
  * 마디에 연결된 노드들에 대해서 가능한지 확인
  * 가능하면 넘어감
* 의 구조를 많이 사용한다.
* 그 이유는, 만약 이전의 방법을 사용하게 되면, 애초에 되지 않는 방문하고 그 사실을 알게 된다.
* 하지만 미리 검증하고 넣어준다면, 재귀 호출을 덜하기 때문에 보다 효율적이다.


![image](https://user-images.githubusercontent.com/37871541/122230056-3fa43400-cef4-11eb-8d88-be2e407ad534.png){: .center-small}_수도 코드_

* 이 코드를 이해하려면, 처음에 들어가는 인자가 i번째 퀸이라고 생각하면 된다.
* 그리고 col[i]는 해당 i번째 퀸(row와 동일함)의 column위치를 나타낸다.



# 부분집합의 합 구하기

![image](https://user-images.githubusercontent.com/37871541/122230475-a9244280-cef4-11eb-88e8-fb96b0e714b1.png){: .center-verysmall}


* n개의 item을 사용하여 item의 무게의 합이 W가 되는 부분집합을 구한다.
* 이 문제의 상태공간 트리는 넣고 말고이니, 이진 트리 모양으로 만들어진다.
* 그렇게 되면 시간 복잡도가 너무 많이 발생한다.
* 정렬되지 않은 상태에서 할 경우, 최초에 목표 무게보다 큰 값이 들어갈 경우 문제가 생긴다.
* 무슨 얘기냐면, 결국 상태공간 트리가 크기 때문에 우리는 백트레킹 방법을 시도할 거다.
* 그러면 이를 분간해줄 것이 필요한데, 그것을 넣었을 때, 해당 무게를 넘은 경우 탐색 자체를 하지 않을것이다.
* 그런데 만약 엄청 큰 값이 들어갔다면 튕겨져 나오게 된다.
* 그러니까 일단 넣을 수 있는 걸 작게작게 넣어보면서 판단하는 것이 옳다.


![image](https://user-images.githubusercontent.com/37871541/122231079-28197b00-cef5-11eb-8c5e-1eaad886cc33.png){: .center-small}

* 이 때 분기는, 다음 아이템을 넣었더니 원하는 무게를 넘어갔다 -> 볼 필요 없음
* 이후의 무게를 다 넣어봤는데 W보다 작다. -> 애초에 글렀음 볼필요 없음


![image](https://user-images.githubusercontent.com/37871541/122231411-644cdb80-cef5-11eb-862d-72a80c7880ec.png){: .center-small}_수도 코드_

* 그래서 계속할 떄마다
  * 남은 원소의 총 합 : total
  * 지금까지의 무게 : weight
  * 지금의 원소 번호 : i
* 이렇게 3개를 넣어주어야 한다.
* 결국
  * 지금 돼?
  * OK 다음거 가보자
  * 빼고 가보자
* 이게 다다.




# 그래프 색칠 하기


![image](https://user-images.githubusercontent.com/37871541/122232170-ff45b580-cef5-11eb-9dbf-06759503c7ec.png){: .center-small}
![image](https://user-images.githubusercontent.com/37871541/122232199-0371d300-cef6-11eb-8410-f5d40f235c6d.png){: .center-small}



고등학교 때 어디선가 보았던 문제..

![image](https://user-images.githubusercontent.com/37871541/122232329-1d131a80-cef6-11eb-881c-4473b9896183.png){: .center-small}_평면 그래프_

* 평면 상에서 edge를 그렸는데, 엇갈리지 않게 만들 수 있는 경우.
* 이게 4색 문제는 당연히 이렇게 나올 수 밖에 없음
* 면이 다 붙어있잖아!
* 만약 비행기를 타고 날아가(3차원)
* 이러면 안되지. 그래서 평면? 그래프인가보다


![image](https://user-images.githubusercontent.com/37871541/122232715-69f6f100-cef6-11eb-8237-191895cb7c71.png){: .center-small}_백 트래킹 상태공간 트리_

* 얘도 보면 별거 없다.
* 결국 어느 순간이 아닌지에 대해서 명시적으로 알아내야 한다.
* 인접해 있는데, 같은 색이야 : 기각
* 인접해 있는데, 다른 색이야 : OK
* 인접하지 않았어 : 기각

![image](https://user-images.githubusercontent.com/37871541/122232991-a591bb00-cef6-11eb-8bed-8ae371fbbc77.png){: .center-small}



