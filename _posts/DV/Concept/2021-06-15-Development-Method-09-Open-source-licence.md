---
layout: post
title: "09: Open Source Licence"
category: "DV/Concept"
comments: true
tags: [Concept, "Development Method"]
feature-img: "assets/img/78.jpg"
feature-title: ""
use_math: true
series: "Development Method"
summary: "Open source, 그리고 licence에 대해 알아보자."
---

* Free?
* Open?
* Law?


# Open source software란?

* Open
  * Freedom to
    * 소스코드 보기
    * 돌려볼 자유
    * 수정할 자유
    * 배포의 자유
  * 소프트웨어 개발 모델의 종류
  * 철학 : 공유, 협동
  * 라이센스 - 먹고 살긴 해야지
* Commercial
  * 돈을 벌고 파는 것
  * object code로 배포함
  * 영업 비밀로 소스코드를 가지고 있음


* 다른 이름
  * Free software (99% 일치)
  * Copy left
    * 저작권을 요구하지 않는 경우
  * Community software(edition)
  * Public Software
    * 공공 소프트웨어

* 오픈 소스의 성장 이유
  * 엔드유저의 증가
  * ISB, IHV 증가
    * ISB
      * Independant Software Vendor
    * IHV
      * Independant Hardware Vendor
  * 정부에서 사용
  * 대학에서 사용

* 누가 만들었지?
  * Hacker : 컴퓨터를 가지고 전문전인 문제를 푸는 사람
  * Cracker : 망가트리는 사람

* 개발되는 방법
  * 부족한 부분을 채우기 위함 (가려운데를 긁는다)
  * 협업
  * 피어 리뷰 - Pair Programming
  * 중앙 집중 결정
  * "눈이 많으면 버그 잡힌다."
  * Forking

* 새로운 아이디어인가?
  * 취미, 과학자들이 서로 공유해왔었음 (50)
  * 인터넷 때문에 공유, 협업이 효율적으로 (70)
  * Netscape가 최초의 웹브라우저 (90)
  * Linux+Apache 웹서버가 인기있어짐 (90 중후반)
  * 생각보다 오래된 문화

* 누가 사용해?
  * 처음에는 해커
  * 지금 : 많은 사람들
    * 인터넷 backbone
    * Linux
    * 각종 회사
    * 상업 비즈니스
    * 정부

* 왜 안쓰는가?
  * PC user
  * 직접 개발이 가능한가? - 개발 역량이 필수적이기 때문
  * IP(지적 재산권)이 무서움.

* 사업적 영역으로서의 오픈소스
  * 커스터마이징에 대해 돈을 받음
  * 하드웨어를 팔고 소프트웨어를 줘버린다
  * 서비스를 파는 방식
  * Dual Version (커뮤니티 에디션, 기업 에디션 - 기능제한)
  * Dual licensing 
  * 추가기능에 대해 돈을 받음
  * 스폰서를 받는다.
  * 광고, T-shirts

* Licensing : 오픈소스 뒤에 있는 압박?
  * Free, open은, 아니다.
    * 누구나 공개되어 있다고 아무나 쓴다는 것은 아니다.
    * shareware, freeware - 그냥 사용만 하게해준 것
  * 분명 제한이 있다.
  * 그리고 책임은 사용하는 사람한테 있다.
  * "free가 되기 위해, Software는 저작권을 가지고 licence를 가져야 한다."


# licence의 종류
* GNU General Public License : 수정한 것도 오픈소스화 해야해
* BSD-style License
* Other
  * Mozila
  * I.B.M...etc
  * Artistic License
  * GNU Lesser GPL
  * CCL (Creative Commons License)

## BSD-style Licence

* unlimited use, modification, distribution
* 책임 안진다.
* 오픈소스 고지유무

## GNU General Public License

* 맘대로 돌리세요
* 맘대로 소스코드 접근하세요
* 맘대로 변종 만드세요
* 근데, 변종을 만들면 반드시 GPL 따라야 합니다. ^^
* License is "Viral" - 바이러스와 같다. 다 열어 ^^
* 돈을 벌라 생각하면 머리아프다..


### SCO litigation (예시)

* 고소해서 소스코드 다 들어냈다.
* 시간의 문제이지 않을까?
* 오픈소스 전담 부서가 있어야 할 것 같은데
* 당장 법률하는 애들은 이게 뭔지 모르겠다
* 개발할 때도 조심해야겠다..
* 사업화 어떤걸로 해야할까?


# 정리

## Apache License
* 아파치 라이센스 소스코드 수정해서 배포하면 아파치 라이센스 버전 2.0을 꼭 포함해야 함
* 그리고 아파치재단 소프트웨어임을 밝혀야 함
* 안드로이드, 하둡


## GNU GPL
* 개빡셈
* Copyleft 조항
* 니가 갖다쓰고 맘대로 하되, 배포할거면 너도 오픈해야해 전부 ^^
* 모질라 파이어폭스, 리눅스 커널, 깃, 마리아DB, 워드프레스

## GNU Lesser GPL(LGPL)

* 약간 약화한 것
* 수정은 안함, 그러면 오픈은 안해도돼

## GNU Affero GPL(AGPL)

* 수정한 소스코드를 서버에서만 사용하는 개발자가 프로그램을 배포하지 않으면 상관 없음
* 근데 그걸로 배포해서 통신을 한다? 그럼 프로그램 열어라
* 몽고 DB

## Berkley Software Distribution(BSD) License
* 공공의 몫으로 돌려주자.
* 가장 자유로움
* Nginx




