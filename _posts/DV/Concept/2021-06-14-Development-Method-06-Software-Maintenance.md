---
layout: post
title: "06: Software Maintenance"
category: "DV/Concept"
comments: true
tags: [Concept, "Development Method"]
feature-img: "assets/img/78.jpg"
feature-title: ""
use_math: true
series: "Development Method"
summary: "소프트웨어 유지보수 방법을 알아보자."
---

# Version Control
* revision Control
* source Control
* 비교 기능
* 복원 기능
* 병합 기능

* 마일스톤 별로 관리가 되어야 한다.

![image](https://user-images.githubusercontent.com/37871541/121829328-28e7bc80-ccfd-11eb-92e5-dae8afc142d7.png){: .center}_중앙집중형, 분산형_

* 중앙집중형
  * 장점
  * 단점
    * 내가 필요할 때 모든 파일을 가져와야 한다.
    * 변화를 일으키면 중앙집중에 영향을 준다.
* 분산형
  * 각가따로 버전을 가지고 있는데 필요할 때 영향을 줄 수 있음
  * 고립형으로 할 수도 있음
  * 중앙서버는 저장용으로 관리

![image](https://user-images.githubusercontent.com/37871541/121829592-f7232580-ccfd-11eb-97c2-c6acca443a06.png){: .center-small}_version control_

![image](https://user-images.githubusercontent.com/37871541/121840888-30688f00-cd18-11eb-8f66-616ff2f6766d.png){: .center-verysmall}_example_

* master
  * 중간에 가다가 tag를 닮. 의미가 있을 때 단다.
* develop
  * 개발용 브랜치
* feature
  * 시험용으로 기능을 따서 개발하다가 괜찮으면 develop에 merge
* release branches
  * 안정화 중심으로 작업 후 master에 포함

![image](https://user-images.githubusercontent.com/37871541/121841048-82111980-cd18-11eb-9b3c-2687d65602b9.png){: .center-verysmall}_example2_


* feature branches
* develop
* release branches
* hotfixes
* master

[Version Control Wikipedia](https://en.wikipedia.org/wiki/Version_control)

* branch(분기)
* change
* checkout
  * 브랜치 탈출하는 방법

1. 코드 작업
2. Commit 만들기
3. 원격 저장소에 푸시
4. 동료 개발자는 해당 레포를 클론
5. 변경 사항이 있다면 fetch로 확인후 pull
6. branch를 따서 내가할 부분을 수정
7. merge 한다.
   1. 자 근데 여기서 그냥 merge하기 찝집하다.
   2. Pull request

아무나 Push가능? X 
Fork를 떠야함

1. Fork를 뜬다.
2. clone 해서 로컬로 가져온다.

# Concurrent Version System(CVS)

* 2008년에 멈춤
* C 사용
* Unixlike
* 클라이언트 서버
* 중앙 집중형 방식



# Apache Subversion(SVN)

* Git과 양대산맥
* 아파치 웹서버, GCC 컴파일러
* Centerized 방식





# Git

* 분산화 시스템
* 작고 빠르다. 부하가 없다.
* [Pro git book](https://git-scm.com/book/ko/v2)
* 왜 유명한가?
  * 리누스 토발즈가 만들었다.
  * 리눅스 만들기 위해 만들었다.
* 모든 소스코드를 풀세트로 가지고 있다.
* 백업도 다되어 있다.
* Distributed revision control systems(DVCS)

* 중앙 처리 시스템
  * 일단 Central Repository를 갖는다.
  * local로 모두 가져온다.
  * 작업이 끝나면 main에 넣는다. 이 때 project maintainer가 확인하고 넣는다.
  * 다른 사람이 작업하고 중앙에 동기화 시킨다.
* 분산 처리 방식
  * Pull Requests
    * 당겨가줬으면 좋겠습니다.
    * Maintainer에게 부탁하는 것
    * 허락, 거절
    * PR에는 리뷰를 거침
    * 요즘에는 자동화도 발생함

# GitHub



![image](https://user-images.githubusercontent.com/37871541/121855986-ef2fa980-cd2e-11eb-893b-3210348971f3.png){. :center}_github workflow_

![image](https://user-images.githubusercontent.com/37871541/121856830-e8556680-cd2f-11eb-9aa8-d423890f6522.png){: .center}_github summary_

* Git repo hosting service
* 2008
* 4000만명
* ruby
* web based
* Source code Management