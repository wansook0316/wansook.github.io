---
layout: post
title: "09: URL Loading System"
category: "DV/iOS"
comments: true
tags: [iOS, "URLSession", "통신", "Https"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "Swift에서 통신 방법을 알아보자."
---


# Swift URL Session 동작 방식 이해


![https://user-images.githubusercontent.com/37871541/126509849-a9c36f01-a02d-4f7f-975c-8db10463867a.png](https://user-images.githubusercontent.com/37871541/126509849-a9c36f01-a02d-4f7f-975c-8db10463867a.png)

- URLSession
    - 서버와 통신하기 위한 API
    - Alamofire, SDWebImage 등의 기반이 되는 API
    - HTTP를 포함한 몇가지 프로토콜 지원
    - 기본적으로 비동기
    - 세션 설정시, Ephemeral 옵션을 주게되면 캐시를 저장하지 않는다.
    - Delegate로 통신 간의 상황을 받아 처리가 가능하다.
    - Request
        - URL 객체를 통해 직접 통신
        - URLRequest  객체를 만들어서 옵션 설정후 통신
    - Response
        - Completion Handler로 처리
        - URLSessionDelegate를 통해 메서드를 호출하여 reponse를 처리
        - 일반적으로는 Completion handler를 사용하나, background 상태에서도 돌아가게 하려면 Delegate 패턴 사용
            - 파일 다운로드
            - 인증, 캐싱을 default로 사용하지 않는 경우(잘 모르겠다.)
- 컨셉
    - Session Configuration을 결정한다.
    - Session을 생성한다.
    - 통신할 URL과 Request 객체를 설정한다.
    - Task를 결정한다.
    - Task 실행
    - Task 완료후 Completion handler 호출
- Session
    - Default : 기본 세션, 디스크 기반 캐싱 지원
    - Ephemeral : 어떠한 데이터도 저장하지 않음, 캐싱 X
    - Background : 백그라운드 **상태** 이후에도 통신이 이뤄지는 것
        - 기본적으로 Session은 백그라운드 스레드에서 동작한다. 앱이 종료되는 하위 프로세스도 죽기 때문에 이 통신은 끊긴다.
        - 해당 옵션이 아마(?) 앱이 백그라운드 상태로 진입했을 때도 동작하게 하려는 것인 것 같다.
        - 앱이 백그라운드 상태로가면 스레드가 보통 죽기 때문이다.
- Request
    - 어떻게 데이터를 캐싱할 것인지?
    - 어떤 HTTP 메소드?
    - 어떤 내용을 전송?과 같은 설정이 가능
- Task
    - URLSessionDataTask
        - 데이터 작업
        - HTTP 메서드를 활용해 서버로 부터 응답 받아 Data 객체를 가져온다.
        - 단순 JSON, XML, HTML 데이터 작업
    - URLSessionUploadTask
        - 웹 서버로 Data 객체 또는 파일데이터를 업로드한다.
        - Post, Put 메서드 이용
        - 용량이 큰 경우
    - URLSessionDownloadTask
        - 대기중이거나 실행중이 아니라면, 백그라운드에서도 다운로드가 가능하다.
        - 용량이 큰 경우


# Reference

* [Apple Developer Documentation](https://developer.apple.com/documentation/foundation/url_loading_system)
* [iOS URLSession 이해하기 ](https://hcn1519.github.io/articles/2017-07/iOS_URLSession)