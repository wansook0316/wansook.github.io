---
layout: post
title: "08: 패키지 매니저"
category: "DV/iOS"
comments: true
tags: [iOS, "Package Manager"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "Swift에서 사용하는 패키지 매니저의 종류는?"
---

# 스위프트 패키지 관리 도구

- [SPM(Swift Package Manager)](https://swift.org/package-manager/)
    - 애플이 만듦
    - 가장 최근 등장(2019년)
    - Xcode 11부터 사용가능
    - 코드 배포를 관리하기 위한 도구
    - Swift 빌드 시스템과 통합되어 종속성, 컴파일, 링크 프로세스를 자동화
    - 정식 패키지 관리자를 제공하여 라이브러리 배포 방법 공통 표준 정의
    - > 생태계의 성장을 위해 만듦
    - 가장 간단
        - 합격
- [CocoaPods](https://cocoapods.org/)
    - 가장 오래된 패키지 관리자(2011)
    - 가장 오래되어 없는 라이브러리가 없다고 생각하면됨
    - 버전관리가 골치아픔
    - 탈락
- [Carthage](https://github.com/Carthage/Carthage)
    - Swift 세대(2015)에 등장한 라이브러리
    - 오픈 소스 라이브러리를 아예 다운받아서 사용
        - 많은 오픈소스 라이브러리를 한번에 설치할 때 시간이 가장 많이 걸림
    - 대신 한번 다운로드 받은 라이브러리는 공유만 하면 다른 로컬환경에서도 스크립트 실행 없이 실행 가능
    - SPM 등장 이후 지원하지 않는 오픈소스 라이브러리가 늘고 있다.
    - 탈락

