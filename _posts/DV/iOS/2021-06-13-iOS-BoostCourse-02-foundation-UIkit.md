---
layout: post
title: "02: Foundation, UIKit"
category: "DV/iOS"
comments: true
tags: [iOS, "Foundation", "UIKit"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "음원 재생기를 제작해보자."
---

# UIButton

* 메서드 연결 방법
  * 일단은 IBAction만 사용해보자
* 버튼의 상태
  * default
  * highlighted
  * focused
  * selected
  * disabled
  * 그리고 이 상태는 조합이 가능하다.
  * 기본은 default
* property
  * 코드 혹은 스토리 보드로


# UISlider

* 용어
  * 최소 : Minimum Image
  * 최대 : Maximum Image
  * 이동하는 버튼 : Thumb
  * 줄 : Track


# AVFoundation

다양한 Apple 플랫폼에서 사운드 및 영상 미디어의 처리, 제어 , 가져오기 및 내보내기 등 관범위한 기능을 제공하는 프레임워크이다.

* 주요 기능
  * 미디어 재생 및 편집
    * QuickTime 동영상, MPEG-4 파일 재생, 생성, 편집
    * HLS 스트림 재생 [재생 가능 파일 목록](https://developer.apple.com/documentation/avfoundation/avfiletype)
    * 디바이스 카메라와 마이크를 이용한 영상 녹화 및 사운드 녹음
    * 시스템 사운드 제어
    * 문자의 음성화 (?)
  * AVAudioPlayer Class
    * 이번엔 이거 사용할 것이다. 파일 및 메모리에 있는 사운드 데이터를 재생해 볼 것
    * 주요 기능
      * 파일 및 메모리에 있는 사운드 재생(네트워크 파일 재생 불가)
      * 파일 재생 시간 길이의 제한 없이 사운드 재생 (?)
      * 여러개 사운드 동시 재생
      * 재생 속도 제어 및 스테레오 포지셔닝
      * 앞으로 감기, 뒤로 감기
      * 현재 재생 정보 데이터 얻기
      * 반복 재생

어차피 자세한 것은 doc 찾아야 한다.


# Timer

일정 시간 간격이 지나면 지정된 메시지를 특정 객체로 전달한다.

* 특징
  * 런 루프에서 작동한다. (?)
    * RunLoop 객체는 소켓, 파일, 키보드 마우스 등의 입력 소스를 처리하는 이벤트 처리 루프로,쓰레드가 일해야 할 때는 일하고, 일이 없으면 쉬도록 하는 목적으로 고안되었다. RunLoop 입장에서 Timer는 입력이 아닌 특수한 유형이지만, Timer의 이벤트 또한 처리한다.
    * 즉 입력 소스에 대한 이벤트 루프라 하는 것 같다. 특이하게 얘는 여기서 처리한다.
    * 심화한 내용은 나중에.. 알아보도록 하자.
  * 반복 여부를 지정할 수 있다.
    * 비 반복 파이머 : 한번 실행된 다음 자동으로 무효화
    * 반복 타이머 : 동일한 런 루프에서 특정 TimeInterval 간격으로 실행
      * 반복 정리하려면 invalidate() 호출


# Cocoa Touch Layer

* iOS 애플리케이션 개발환경 토대
* 여러 프레임워크를 포함하는 최상위 프레임워크 계층
* 코코아 계층은 mac os 개발시 사용
* 코코아 : Objective C 런타임을 기반으로 하고, NSObject를 상속받는 모든 클래스 도는 객체를 가리킬 때 사용
* 코코아 터치, 또는 코코아는 iOS, macOS의 전반적인 기능을 활용해 앱을 제작할 때 사용하는 프레임워크 계층
* 코코아 터치는 `UIKit`, `Foundation`을 포함한다.


![image](https://user-images.githubusercontent.com/37871541/122725507-08e16b80-d2b0-11eb-8408-4f39f260bfc3.png){: .center-small}_cocoa touch framework_



# UIKit

* 화면 구성
* 액션에 대응되는 요소를 포함
* 사용자 인터페이스를 구현하고 이벤트를 관리하는 프레임워크
* 이벤트 처리 : 제스처 처리, 애니메이션, 그림 그리기, 이미지 처리, 텍스트 처리
* 화면 : 테이블 뷰, 슬라이더, 버튼, 텍스트 필드, 알림 창
* UIResponder에서 파생된 클래스나, 인터페이스에 관련된 클래스는 `메인스레드`에서만 사용
* UIKit은 iOS와 tvOS플랫폼에서 사용함


## UIKit 기능별 요소

* 사용자 인터페이스
  * View and Control : 화면에 콘텐츠 표시
  * View Controller : 사용자 인터페이스 관리
  * Animation and Haptics : 애니메이션과 햅틱을 통한 피드백 제공
  * Window and Screen : 뷰계층을 위한 윈도우 제공
* 사용자 액션
  * Touch, Press, Gesture : 제스처 인식기를 통한 이벤트 처리 로직
  * Drag and Drop : 화면 위에서 드래그 앤 드롭 기능
  * Peek and Pop : 3D 터치에 대응한 미리보기 기능
  * Keyboard and Menu : 키보드 입력을 처리, 사용자 정의 메뉴 표시


# Foundation

* iOS 운영체제 서비스와 기본 기능을 포함함
* 원시 데이터 타입 (String, Int, Double)
* 컬렉션 타입(Array, Dictionary, Set)
* 및 운영체제 서비스를 사용해 기본적인 기능을 관리함
  * 데이터 타입
  * 날짜 및 시간 계산
  * 필터 및 정렬
  * 네트워킹

## Foundation 기능별 요소

* 기본
  * Number, Data, String : 원시 데이터 타입
  * Collection : Array, Dictionary, Set 등과 같은 컬렉션 타입
  * Date, Time : 날짜와 시간 계산, 비교
  * Unit and Measurement : 물리적 차원을 숫자로 표현 및 관련 단위간 변환 가능
  * Data Formatting : 숫자, 날짜, 측정값등을 문자열로 변환 또는 반대의 작업 수행
  * Filter and Sorting : 컬렉션의 요소를 검사하거나 정렬
* 애플리케이션 지원
  * resources : 애플리케이션의 Asset과 Bundle data에 접근 지원
  * Notification : 정보를 퍼트리거나 받아들이는 기능 지원
  * App Extension : 확장 애플리케이션과의 상호작용 지원
  * Error and Exceptions : API와의 상호작용에서 발생할 수 있는 문제 상황에 대처하는 기능 지원
* 파일 및 데이터 관리
  * File System : 파일 및 폴더를 생성하고 읽고 쓰는 기능 관리
  * Archives and Serialization : 속성 목록, JSON, 바이너리 파일들을 객체로 변환 또는 반대
  * iCloud : 사용자의 iCloud 계정을 이용하여 데이터를 동기화
* 네트워킹
  * URL Loading System : 표준 인터넷 프로토콜을 통해 URL과 상호작용, 서버와 통신
  * Bonjour : 로컬 네트워크를 위한 작업

추가로 알아야 하는 것들을 정리해 보자.

* UIKit을 import하면 Foundation은 자동으로 import 된다.
* Foundation은 Swift Standard Library를 참조하기 때문에 Swift를 import하지 않아도 된다.