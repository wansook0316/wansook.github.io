---
layout: post
title: "HTTP Structure"
category: "DV/Concept"
comments: true
tags: ["Concept", "Server"]
feature-img: "assets/img/45.jpg"
feature-title: ""
use_math: true
series: "Backend Concept"
summary: "프록시란 무엇인가?"
---

# HTTP

> HyperText Transfer Protocol

하이퍼 텍스트(HTML) 문서를 교환하기 위해 만들어진 protocol(통신 규약)을 의미한다. 즉, 웹 상에서 네트워크로 서버끼리 통신할 때 어떻게 통신할래? 에 대한 답이다. 프론트 서버와 클라이언트 간의 통신에 사용되고, 프론트와 백 서버간의 통신에서도 사용된다. **TCP/IP** 기반으로 되어 있다.

# 핵심 특징

1. Request/Responce 구조로 되어 있다.
   * 클라이언트가 http request를 보내면, 서버는 http responce를 보낸다.
2. Stateless이다.
   * 상태를 저장하지 않는다. 이게 무슨말 일까?
   * 즉, 요청이 오면 그에 응답을 할 뿐, 여러 요청/응답 끼리 연결되어 있지 않다. 즉, 각각의 요청과 응답은 독립적이다.
   * 예를 들어보면, 클라이언트가 요청을 하고, 응답을 받았다. 그 다음에 다시 요청을 보냈다고 해서 그 전에 보낸 요청/응답에 대해 알 수 없다.
   * 이런 과정이 만약 필요하다면 **쿠키, 세션**등을 사용해야 한다.

# HTTP 구조

## Request Structure

![image](https://user-images.githubusercontent.com/37871541/102958407-1f388580-4520-11eb-9136-a194b53623e2.png){: .center width="30%"}


```
GET /search HTTP/1.1
Accept: */*
Accept-Encoding: gzip, deflate
Connection: keep-alive
Content-Type: application/json
Content-Length: 257
Host: google.com
User-Agent: HTTPie/0.9.3

{
    "imp_uid": "imp_1234567890",
    "merchant_uid": "order_id_8237352",
    "status": "paid"
}
```

### 요청 라인

```
GET /search HTTP/1.1
```

가장 먼저 나오는 문구이다. 예시 요청 메시지에서 `GET / HTTP/1.1`이 요청 라인이다. 요청 라인에는 세개의 필드가 있다. 다음과 같은 구조로 되어 있다. `Method URL Version`

#### Method

어떠한 Method를 사용하여 정보를 요청하느냐에 대한 정보이다. 즉, 요청 방식이다. `GET`, `POST`, `DELETE`, `UPDATE`, `PUT` 등이 있다.

#### URL

요청하는 리소스의 위치를 나타낸다. 현재는 `/`로, 즉 루트 경로를 나타내고 있다.

#### Version

HTTP 버전을 의미한다. 대부분의 version 명명법과 같이 맨 앞 숫자 1은 Major 업데이트를 의미하고, 그 뒤는 Minor 업데이트를 말한다.


### Header

해당 request에 대한 추가 정보(addtional information)를 담고 있는 부분이다. 예를 들어, request 메세지 body의 총 길이 (Content-Length) 등. Key:Value 값으로 되어있다. Headers도 크게 3부분으로 나뉘지만(general headers, request headers, entity headers) 너무 자세한 부분이므로, 3부분 으로 구성되어 있다는 것만 알고 있어도 괜찮다.

```
Accept: application/json
Accept-Encoding: gzip, deflate
Connection: keep-alive
Content-Length: 83
Content-Type: application/json
Host: intropython.com
User-Agent: HTTPie/0.9.3
```



자주 사용되는 header 정보에는 이런 것들이 있다.

* Host
    * 요청이 전송되는 target의 host url: 예를 들어, google.com
* User-Agent
    * 요청을 보내는 클라이언트의 대한 정보: 예를 들어, 웹브라우저에 대한 정보.
* Accept
    * 해당 요청이 받을 수 있는 응답(response) 타입.
Connection
    * 해당 요청이 끝난 후에 클라이언트와 서버가 계속해서 네트워크 컨넥션을 유지 할 것인지 아니면 끊을 것인지에 대해 지시하는 부분.
* Content-Type
    * 해당 요청이 보내는 메세지 body의 타입. 예를 들어, JSON을 보내면 `application/json`.
* Content-Length:
    * 메세지 body의 길이.


### Body

해당 Request의 실제 메시지, 내용을 말한다. Body가 없는 요청도 많다. GET 과 같은 method를 사용하는 경우 보통 정보를 받기 위한 것이 많으므로 Body는 비워져 있다. 반대로 어떠한 정보를 가져오면서 요청하는 경우에는 이 body는 채워져 있다. 예를 들어 POST를 사용하여 로그인을 하려는 경우, 값을 함께 들고온다.

```
{
    "imp_uid": "imp_1234567890",
    "merchant_uid": "order_id_8237352",
    "status": "paid"
}
```

## Responce 구조

![image](https://user-images.githubusercontent.com/37871541/102958423-2790c080-4520-11eb-8b23-30f2f3da92b9.png){: .center width="30%"}

```
HTTP/1.1 404 Not Found

Connection: close
Content-Length: 1573
Content-Type: text/html; charset=UTF-8
Date: Mon, 20 Aug 2018 07:59:05 GMT

<!DOCTYPE html>
<html lang=en>
  <meta charset=utf-8>
  <meta name=viewport content="initial-scale=1, minimum-scale=1, width=device-width">
  <title>Error 404 (Not Found)!!1</title>
  <style>
    *{margin:0;padding:0}html,code{font:15px/22px arial,sans-serif}html{background:#fff;color:#222;padding:15px}body{margin:7% auto 0;max-width:390px;min-height:180px;padding:30px 0 15px}* > body{background:url(//www.google.com/images/errors/robot.png) 100% 5px no-repeat;padding-right:205px}p{margin:11px 0 22px;overflow:hidden}ins{color:#777;text-decoration:none}a img{border:0}@media screen and (max-width:772px){body{background:none;margin-top:0;max-width:none;padding-right:0}}#logo{background:url(//www.google.com/images/branding/googlelogo/1x/googlelogo_color_150x54dp.png) no-repeat;margin-left:-5px}@media only screen and (min-resolution:192dpi){#logo{background:url(//www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png) no-repeat 0% 0%/100% 100%;-moz-border-image:url(//www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png) 0}}@media only screen and (-webkit-min-device-pixel-ratio:2){#logo{background:url(//www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png) no-repeat;-webkit-background-size:100% 100%}}#logo{display:inline-block;height:54px;width:150px}
  </style>
  <a href=//www.google.com/><span id=logo aria-label=Google></span></a>
  <p><b>404.</b> <ins>That’s an error.</ins>
  <p>The requested URL <code>/payment-sync</code> was not found on this server.  <ins>That’s all we know.</ins>
```

### Status Line

```
HTTP/1.1 404 Not Found
```

응답의 상태를 간략하게 나타내는 부분이다. Version, Status Code, Status Text로 구성되어 있다.


### Headers

```
Connection: close
Content-Length: 1573
Content-Type: text/html; charset=UTF-8
Date: Mon, 20 Aug 2018 07:59:05 GMT
```

Request의 headers와 동일하다. 하지만 응답시에만 사용하는 header가 있는데, User-Agent 대신 Server 헤더가 사용된다.


### Body

```
<!DOCTYPE html>
<html lang=en>
  <meta charset=utf-8>
  <meta name=viewport content="initial-scale=1, minimum-scale=1, width=device-width">
  <title>Error 404 (Not Found)!!1</title>
  <style>
    *{margin:0;padding:0}html,code{font:15px/22px arial,sans-serif}html{background:#fff;color:#222;padding:15px}body{margin:7% auto 0;max-width:390px;min-height:180px;padding:30px 0 15px}* > body{background:url(//www.google.com/images/errors/robot.png) 100% 5px no-repeat;padding-right:205px}p{margin:11px 0 22px;overflow:hidden}ins{color:#777;text-decoration:none}a img{border:0}@media screen and (max-width:772px){body{background:none;margin-top:0;max-width:none;padding-right:0}}#logo{background:url(//www.google.com/images/branding/googlelogo/1x/googlelogo_color_150x54dp.png) no-repeat;margin-left:-5px}@media only screen and (min-resolution:192dpi){#logo{background:url(//www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png) no-repeat 0% 0%/100% 100%;-moz-border-image:url(//www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png) 0}}@media only screen and (-webkit-min-device-pixel-ratio:2){#logo{background:url(//www.google.com/images/branding/googlelogo/2x/googlelogo_color_150x54dp.png) no-repeat;-webkit-background-size:100% 100%}}#logo{display:inline-block;height:54px;width:150px}
  </style>
  <a href=//www.google.com/><span id=logo aria-label=Google></span></a>
  <p><b>404.</b> <ins>That’s an error.</ins>
  <p>The requested URL <code>/payment-sync</code> was not found on this server.  <ins>That’s all we know.</ins>
```

Request의 body와 대부분 동일하다. 하지만 항상 있을 필요는 없다. 경우에 따라 Body가 없는 Responce도 있다.


# HTTP Method

## GET
이름 그대로 어떠한 데이터를 서버로 부터 받아(GET)올때 주로 사용하는 Method. 데이터 생성/수정/삭제 없이 받아오기만 할때 사용된다. 가장 간단하고 많이 사용되는 HTTP Method이다. 언급한대로 주로 데이터를 받아올때 사용되기 때문에 request에 body를 안 보내는 경우가 많다.

## POST
데이터를 생성/수정/삭제 할때 주로 사용되는 Method. 데이터를 생성 및 수정 할때 많이 사용하기 때문에 대부분의 경우 request body가 포함되서 보내진다.

## OPTIONS
주로 요청 URI에서 사용할 수 있는 Method를 받아올때  사용된다. 예를 들어, `/update uri`에서 어떤 method를 요청 가능한가(GET? POST?)를 알고 싶으면 먼저 OPTIONS 요청을 사용해서 확인하게 된다.

* Request 하기
```
http -v OPTIONS http://example.org
```

* Request Message
```
OPTIONS / HTTP/1.1
Accept: */*
Accept-Encoding: gzip, deflate
Connection: keep-alive
Content-Length: 0
Host: example.org
User-Agent: HTTPie/0.9.3
```

* Responce Message
```
HTTP/1.1 200 OK
Allow: OPTIONS, GET, HEAD, POST
Cache-Control: max-age=604800
Content-Length: 0
Date: Mon, 20 Aug 2018 08:37:45 GMT
Expires: Mon, 27 Aug 2018 08:37:45 GMT
Server: EOS (vny006/0450)
```

## PUT
POST와 비슷하다. 데이터를 생성 할때 사용되는 Method. POST와 겹치기 때문에 PUT을 사용하는 곳도 있고 POST로 통일해서 사용하는 곳도 있는데, 최근 몇년 사이에 POST에 밀려서 잘 사용 안되는 추세.

## DELETE
특정 데이터를 서버에서 삭제 요청을 보낼때 쓰이는 Method. PUT과 마찬가지로 POST에 밀려서 잘 사용안되는 추세.


## HTTP Status Code

### 200 OK
* 가장 자주 보게 되는 status code.
* 문제없이 다 잘 실행 되었을때 보내는 코드.

### 301 Moved Permanently
해당 URI가 다른 주소로 바뀌었을때 보내는 코드.
```
HTTP/1.1 301 Moved Permanently
Location: http://www.example.org/index.asp
```

### 400 Bad Request
* 해당 요청이 잘못된 요청일때 보내는 코드.
* 주로 요청에 포함된 input 값들이 잘못된 값들이 보내졌을때 사용되는 코드.
* 예를 들어, 전화번호를 보내야 되는데 text가 보내졌을때 등등.

## 401 Unauthorized
유저가 해당 요청을 진행 할려면 먼저 로그인을 하거나 회원 가입을 하거나 등등이 필요하다는 것을 나타내려 할때 쓰이는 코드.

## 403 Forbidden
* 유저가 해당 요청에 대한 권한이 없다는 뜻.
* 예를 들어, 오직 과금을 한 유저만 볼 수 있는 데이터를 요청 했을때 등.

## 404 Not Found
* 요청된 uri가 존재 하지 않는다는 뜻.
```
http -v google.com/no-such-uri

GET /no-such-uri HTTP/1.1
Accept: */*
Accept-Encoding: gzip, deflate
Connection: keep-alive
Host: google.com
User-Agent: HTTPie/0.9.3

HTTP/1.1 404 Not Found
Content-Length: 1572
Content-Type: text/html; charset=UTF-8
Date: Mon, 20 Aug 2018 08:46:48 GMT
Referrer-Policy: no-referrer
```

## 500 Internal Server Error
* 서버에서 에러가 났을때 사용되는 코드.
* API 개발을 하는 백앤드 개발자들이 싫어하는 코드.