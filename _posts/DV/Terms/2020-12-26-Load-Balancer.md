---
layout: post
title: "Load Balancing"
category: "DV/Terms"
comments: true
tags: ["Terms", "Server"]
feature-img: "assets/img/45.jpg"
feature-title: ""
use_math: true
series: "Backend Concept"
summary: "로드 밸런싱이란 무엇인가?"
---

# Load Balancing?
> 증가한 트래픽을 효과적으로 분산하기 위한 기술

현대 시대는 트래픽이 급속도로 증가하였다. 기업은 하나의 서버로 이 트래픽을 감당하기 어려웠고, 이를 해결할 수 있는 기술을 도입하였다. 쏟아지는 트래픽을 여러대의 서버로 분산해주는 기술이다.


<img width="696" alt="스크린샷 2020-12-26 오후 12 24 03" src="https://user-images.githubusercontent.com/37871541/103144947-3f14b700-4775-11eb-90fb-79cadead6c1e.png">{: .center width="80%"}
*로드 밸런서 아키텍처*

로드밸런서는 서버에 가해지는 부하(=로드)를 분산(=밸런싱)해주는 장치 또는 기술을 통칭한다. 클라이언트와 서버풀(Server Pool, 분산 네트워크를 구성하는 서버들의 그룹) 사이에 위치하며, 한 대의 서버로 부하가 집중되지 않도록 트래픽을 관리해 각각의 서버가 최적의 퍼포먼스를 보일 수 있도록 한다.

항상 이런 로드 밸런싱이 필요하지는 않다. 서비스 제공 초기라면 클라이언트 수가 적기 때문에 서버 한 대로 요청에 응답하는 것이 쉽다. 하지만 규모가 확장될 경우, 기존 서버로는 펑펑 터져버리는 것을 경험할 수 있다. 이러한 문제에 대해 해결하는 방법은 크게 두가지 이다.

# Scale-Up & Scale-out

![image](https://user-images.githubusercontent.com/37871541/103144965-9c106d00-4775-11eb-8309-1093fa6cc9f9.png){: .center width="80%"}
*Scale-up & Scale-out*

`Scale-Up`은 서버 자체 성능을 늘리는 것을 말한다. 반대로 `Scale-Out`은 기존 서버의 성능과 비슷하거나 낮은 서버를 두 대 이상으로 증설하는 것을 말한다. 만약 후자의 방법을 선택했다면, 이제 로드 밸런싱을 도입할 차례이다.


# Load Balancing Algorithm

## 라운드로빈
* 서버에 들어온 요청을 순서대로 돌아가며 배정하는 방식
* 서버와의 연결이 오래 지속되지 않는 경우 적합하다.

## 가중 라운드로빈 방식
* 각 서버에 가중치를 매기고 가중치가 높은 서버에 요청을 우선적으로 배정하는 방식
* 서버의 트래픽 처리 능력이 다른 경우 사용한다.

## 최소 연결 방식
* 요청이 들어온 시점에 가장 적은 연결 상태를 보이는 서버에 트래픽을 배정하는 방식.
* 서버에 분배된 트래픽들이 일정하지 않은 경우에 적합하다.

## IP 해시 방식
* 클라이언트의 IP주소를 특정 서버로 매핑하여 요청을 처리하는 방식
* 사용자가 항상 동일한 서버로 연결된다.

## 최소 리스폰타임(Least Response Time Method)

* 서버의 현재 연결 상태와 응답시간을 모두 고려하여 트래픽을 분배하는 방식
* 최소 연결 방식과 가장 짧은 응답시간을 보이는 서버에 우선적으로 로드를 분배한다.

# Type of Load Balancer


![image](https://user-images.githubusercontent.com/37871541/103145051-14c3f900-4777-11eb-9a67-5f34faa89378.png){: .center width="80%"}


## L4 Load balancing
![image](https://user-images.githubusercontent.com/37871541/103145025-c6165f00-4776-11eb-847a-e218560ef7b5.png){: .center width="80%"}

L4 로드밸런서는 네트워크 계층(IP, IPX)이나 트랜스포트 계층(TCP, UDP)의 정보를 바탕으로 로드를 분산한다. IP주소나 포트번호, MAC주소, 전송 프로토콜에 따라 트래픽을 나누는 것이 가능하다.





![image](https://user-images.githubusercontent.com/37871541/103145027-cc0c4000-4776-11eb-88ef-6c00e1178e6a.png){: .center width="80%"}


L7 로드밸런서의 경우 애플리케이션 계층(HTTP, FTP, SMTP)에서 로드를 분산하기 때문에 HTTP 헤더, 쿠키 등과 같은 사용자의 요청을 기준으로 특정 서버에 트래픽을 분산하는 것이 가능하다. 쉽게 말해 패킷의 내용을 확인하고 그 내용에 따라 로드를 특정 서버에 분배하는 것이 가능한 것이다. 위 그림과 같이 URL에 따라 부하를 분산시키거나, HTTP 헤더의 쿠키값에 따라 부하를 분산하는 등 클라이언트의 요청을 보다 **세분화**해 서버에 전달할 수 있다. 또한 L7 로드밸런서의 경우 특정한 패턴을 지닌 바이러스를 감지해 네트워크를 보호할 수 있으며, DoS/DDoS와 같은 비정상적인 트래픽을 필터링할 수 있어 네트워크 보안 분야에서도 활용되고 있다.




# Reference

[로드밸런서(Load Balancer)의 개념과 특징](https://post.naver.com/viewer/postView.nhn?volumeNo=27046347&memberNo=2521903)
