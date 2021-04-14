---
layout: post
title: "03: 데이터 수집 및 저장 계획"
category: "DS/ML"
comments: true
tags: [Data Science, "Machine Learning", "빅데이터분석기사"]
feature-img: "assets/img/77.jpg"
feature-title: ""
use_math: true
summary: "데이터 수집, 변환, 저장과 같은 방법을 알아본다."
series: "빅데이터분석기사 - 필기"
---

![image](https://user-images.githubusercontent.com/37871541/114716586-27d2f700-9d6f-11eb-9222-51b8f43f12b5.png){: .center-small}


# 데이터 수집 방식 및 기술


* 데이터 웨어하우스
  * 오지게 저장하는 공간
* 데이터 마트
  * 웨어하우스로 부터 팀단위, 조직 단위로 뽑아서 사용함

* 정형 데이터
  * ETL(Extract Transform Load) - 추출, 변환, 저장
  * FTP(File Transfer Protocol)
  * API
  * Sqoop
    * 벌크 임포트 지원 - 전체를 한번에 전송
    * 데이터 전송 병렬화
    * 직접 입력
    * 프로그래밍 방식의 데이터 상호작용 - 클래스
* 비정형 데이터
  * 크롤링
  * RSS
  * Open API
  * Scrapy - 웹 사이트 크롤링
  * 아파치 카프카 - 대용량 실시간 로그처리
* 반정형 데이터
  * 센싱
  * 스트리밍
  * Flume - 로그 데이터 수집
  * Scribe - 로그 데이터 수집
  * Chukwa - 비정형, 반정형 모두 사용

# 데이터 유형

![image](https://user-images.githubusercontent.com/37871541/114696744-f864c000-9d57-11eb-9cfd-74eae0b117af.png){: .center-small}

* 구조적
  * 정형
    * RDBMS
    * spread sheet
  * 비정형
    * SNS
    * 웹 게시판
    * 텍스트/오디오/비디오/이미지
  * 반정형
    * XML
    * HTML
    * JSON
    * RSS
    * 로그
    * 센서 데이터

# 데이터 속성
* 범주형(질적 변수)
  * 연산 의미 없음
  * 순서형
    * 단순히 의미론적으로 숫자를 달아놓은 경우
  * 명목형
    * 평점, 상태점수
* 수치형(양적 변수)
  * 사칙연산 가능
  * 연속형
  * 이산형

# 데이터 속성에 따른 측정 척도

데이터 속성에 따라 어떤 척도를 기준으로 측정할지가 달라진다.

* 명목 척도
  * 단순히 구분을 위해 군집에 숫자를 매핑하는 경우
  * `=`, `!=`
  * 이메일 주소, 인터넷 계정, 옷 색깔, 성별
* 서열/순위 척도
  * 순위가 필요할 때.
  * `<`, `>`
  * 직급, 영화 평점, 선호도
* 등간/간격/거리 척도
  * 동일 간격으로 나누어서 비교할 수 있게 만든 척도
  * `+`, `-`
  * 온도, 지능지수
* 비율 척도
  * 절대 0점
  * 순서 & 간격 의미 있음
  * `x`, `/`
  * 질량, 나이, 개수, 길이

# 데이터 변환

* 전처리
  * 저장소에 적재하기위한 작업
  * 데이터 필터링, 유형 변환, 정제
* 후처리
  * 분석이 용이하도록 가공하는 작업
  * 변환, 통합, 축소

## 데이터 변환 기술

* 평활화
  * 들쭉날쭉한 녀석들을 군집화, 구간화를 통해 매끄럽게 만듦
* 집계
  * 데이터를 요약하는 방법
* 일반화
* 정규화
  * 데이터를 정해진 구간 내에 들어가도록 하는 방법
  * 최소-최대 정규화 - 최소값 0 최댓값 1
  * z 스코어 정규화
  * 소수 스케일링
* 속성 생성
  * 새로운 feature를 활용



# 데이터 적재

* 적재 소프트웨어 종류
  * Fluentd
  * Flume
  * Scribe
  * Logstash


# 데이터 저장

* 분산 파일 시스템
  * GFS
  * HDFS
  * Lustre
* 데이터베이스 클러스터 - 하나의 데이터베이스를 여러 개의 서버상에 구축(가상화, RDBMS)
* NoSQL (Not only SQL)
  * 테이블 스키마 X, join X
  * 빅테이블
  * HBase
  * SimpleDB - Amazon
  * SSDS - MS
  * Cloudata
  * Cassandra
* 병렬 DBMS
* 네트워크 구성 저장 시스템
* 클라우드 파일 저장 시스템
  * Amazon S3

## GFS(Google File System)
![image](https://user-images.githubusercontent.com/37871541/114718463-f824ee80-9d70-11eb-9acd-f60a0677cb60.png){: .center-small}

* 구글의 대규모 클러스터 서비스 플랫폼 기반 파일 시스템
* 64m의 청크로 나누고 복제본을 청크서버에 분산하여 저장


* 구성 요소
  * Client
    * 파일 읽기/쓰기 요청 애플리케이션
  * Master
    * 매핑 정보, 저장 서버 위치 정보를 메모리상에서 관리
    * 청크 서버의 하트비트 메시지를 통해 상태관리
  * 청크 서버
    * 로컬 디스크에 청크 저장




## HDFS

![image](https://user-images.githubusercontent.com/37871541/114718791-50f48700-9d71-11eb-98e4-c6271d7ef783.png){: .center-small}

* 구성 요소
  * 네임 노드
    * 모든 메타데이터 관리
    * 마스터 역할
    * 블록 상태 체크
  * 보조 네임 노드
    * 상태 모니터링 보조
    * 파일 시스템 이미지 스냅샷으로 생성
  * 데이터 노드
    * 슬레이브 역할
    * 데이터 입출력 요청 처리
    * 3중 복제 저장


