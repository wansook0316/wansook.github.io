---
layout: post
title: "01: Nginx"
category: "DS/Server"
comments: true
tags: [DS, "python", "nginx"]
feature-img: "assets/img/30.jpg"
feature-title: ""
use_math: true
series: "배포"
---

Nginx에 대해서 알아본다.

# nginx란?

> 트래픽이 많은 웹사이트를 위해 설계한 비동기 이벤트 기반 구조의 웹서버 소프트웨어

러시아의 프로그래머,이고르 시쇼브가 Apache의 C10K Problem(하나의 웹서버에 10,000개의 클라이언트의 접속을 동시에 다룰 수 있는 기술적인 문제)를 해결하기 위해 만든 Event-driven구조의 HTTP, Reverser Proxy, IMAP/POP PROXY server를 제공하는오픈소스 서버 프로그램이다.

# Apache vs nginx

> Apache

- 쓰레드 / 프로세스 기반 구조로 요청 하나당 쓰레드 하나가 처리하는 구조
- 사용자가 많으면 많은 쓰레드 생성, 메모리 및 CPU 낭비가 심함
- 하나의 쓰레드 : 하나의 클라이언트 라는 구조

> nginx

- 비동기 Event-Driven 기반 구조.
- 다수의 연결을 효과적으로 처리가능.
- 대부분의 코어 모듈이 Apache보다 적은 리소스로 더 빠르게 동작가능
- 더 작은 쓰레드로 클라이언트의 요청들을 처리가능

# thread와 Event-driven 방식

![thread 방식](https://mblogthumb-phinf.pstatic.net/MjAxNzAzMjZfMTI2/MDAxNDkwNDk1NjMxNzU4.wrfzv-j7_pzF4GorDTt52dZPzLcUPwnu6JJkgvD53r0g.2xqzw_4Z557pZPaKMbg5pCF3CfvyQtpBqnZrA1p9qjYg.GIF.jhc9639/mighttpd_e01.gif.gif?type=w800){: .center}

![Event-driven 방식](https://mblogthumb-phinf.pstatic.net/MjAxNzAzMjZfMTM3/MDAxNDkwNDk1NjMxNzgy.OHZ33nerX_6Hc92Mg_xjr51acwwi1P_mq3SIl7Cuhisg.niRsQQVM5CwGpXKcdOxl3bkNsmfBkqGV1ajcBpV6CvQg.GIF.jhc9639/mighttpd_e02.gif.gif?type=w800){: .center}

그림만 봐도 딱 알겠지만, Event-driven 방식은 java-script에서와 같이 비동기 이벤트를 처리하는 방식으로 구동된다. 그렇기 때문에 자원을 효율적으로 사용한다.

그렇지 않아도 `node.js`의 창시자 라이언 달은 nginx를 프록시 서버로 앞단에 두고, node.js를 뒤쪽에 놓는게 버퍼 오버플로우 공격을 방지할 수 있다고 하였다.

## 버퍼 오버플로우

버퍼는 보통 데이타가 저장되는 메모리 공간을 뜻한다. 이 때, 메모리 공간을 벗어나는 경우 오버플로우가 되고 이 때 사용되지 않아야 할 영역에 데이터가 덮어씌워져 주소, 값을 바꾸는 공격이다.

​

### 버퍼 오버플로우로 인한 큰 이슈 : 하트블리드사태

즉, 실제포트를 숨기고 nginx의 80포트를 통해서 프록시하면 보안적으로 막을 수 있다는 것인데 이것 말고도 정적자료에 대한 gzip압축, 그리고 앞단에서의 로그를 저장할 수 있다.
