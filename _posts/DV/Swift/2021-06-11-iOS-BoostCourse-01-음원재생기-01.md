---
layout: post
title: "01: 음원 재생기 - 01"
category: "DV/Swift"
comments: true
tags: [iOS, "단축키", "Asset", "App thinning"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "음원 재생기를 제작해보자."
---

![image](https://user-images.githubusercontent.com/37871541/121643239-8e089b80-cacc-11eb-922e-1b16fd4663b4.png){: .center}_project sample_


# 배울 내용

* Xcode 사용법
  * 프로젝트 생성 및 코드작성
  * 인터페이스 빌더를 활용한 UI 구성
  * 유용한 단축키
* UIKit 요소
  * UILabel
  * UIButton
  * UISlider
* 프레임워크
  * UIKit
  * AVFoundation
* 기술요소
  * Auto Layout
* Design Pattern
  * Model-View-Controller Pattern
* 기타 개념
  * IBOutlet, IBAction
  * Assets
  * Bundle
* Timer


# 단축키

* command + 0 : 네비게이터 영역 접기
* option + command + 0 : 유틸리티 영역 접기
* command 1~9 : 네이게이터 바의 영역 이동
* option click : 도움말
* command + shift + o : 빠르게 파일 찾아서 열기
* option 키 누르고 선택 : 새창 열기


# Target

![image](https://user-images.githubusercontent.com/37871541/121644954-9d88e400-cace-11eb-95e3-77743eb9d872.png){: .center}_하나의 프로젝트에 다수의 타겟이 있을 수 있다._

여기서 대상(Target)이란 iOS, macOS, tvOS, watchOS를 위한 애플리케이션과 같이 빌드할 제품을 말한다.




# Scheme

앱을 구동하기 전에, 어떤 타겟에 대한 환경을 설정할 것인지 정해줘야 한다. 위에서 말했듯 하나의 프롲게트에는 여러개의 Target이 존재할 수 있기 때문에, 각각의 target은 다른 환경 설정을 가질 수 있다. 그렇기 때문에 실제 앱이 구동되는 것을 보기 위해서는 내가 원하는 타겟과, 그에 맞는 설정파일(Scheme)을 선택해주어야 한다.

![image](https://user-images.githubusercontent.com/37871541/121645245-ee004180-cace-11eb-901b-0ae4b542c511.png){: .center-verysmall}
![image](https://user-images.githubusercontent.com/37871541/121645530-433c5300-cacf-11eb-86f9-43131bec6fc6.png){: .center-verysmall}_Scheme과 Target simulator_

이렇게 실행할 기기를 선택할 수 있다. 시뮬레이터를 사용하면 무료이지만, 기기에서 테스트를 무료로 하려면 일주일에 한번 빌드해줘야 한다. 유료는 그런 걱정이 없다.

WatchOS를 사용했다면 동시에 뜨는 시뮬레이터를 실행시킬 수 있다.

![image](https://user-images.githubusercontent.com/37871541/121645930-b8a82380-cacf-11eb-87d8-3e6747a78c60.png){: .center-small}



# 에셋 카탈로그


![image](https://user-images.githubusercontent.com/37871541/121771979-971d6980-cbad-11eb-90bd-965ff52ef280.png){: .center}_Assets description_


용어를 잘 알아두도록 하자. 카탈로그라는 말이 어색하다.



![image](https://user-images.githubusercontent.com/37871541/121772301-866df300-cbaf-11eb-8428-f129cec9d87e.png){: .center}_Asset variations_

위에서 App icon을 눌렀을 떄 나오는 화면이다. 각각의 device간에 들어갈 asset이 달라진다.

![image](https://user-images.githubusercontent.com/37871541/121797497-85929b00-cc5b-11eb-8091-20a1b1ac6807.png){: .center}_Asset 카탈로그의 컨텐츠_

에셋 카탈로그의 **콘텐츠**는 3가지 타입이다.

* Folders : 에셋 카탈로그 폴더아래에 그룹 폴더나 에셋 폴더를 가질 수 있다. 보통은 확장자가 폴더에 붙지 않지만 에셋 카탈로그 폴더의 경우 위와 같이 특정 에셋 타입의 확장자가 자동으로 붙는다.
* Json files : 속성에 대한 정보를 갖는다.
* contents files : 콘텐츠 파일은 리소스 파일을 말한다.

아직 이해가 어려우니 나중에 실습을 하면서 이해하자.

![image](https://user-images.githubusercontent.com/37871541/121797574-005bb600-cc5c-11eb-8f7f-6aa17f129599.png){: .center}_에셋 카탈로그의 구조_

구조는 다음과 같다.

* 에셋 카탈로그 폴더 : 에셋 카탈로그 폴더 안에 모든 폴더와 파일을 가지고 있다.
* 그룹 폴더 : 그룹 폴더는 다른 그룹 폴더나 에셋 폴더를 갖고 있다.
* 에셋 폴더 : 리소스 파일을 가지고 있다.


### 에셋 카탈로그의 타입

|폴더 타입 | 확장자 | 설명
|:-:|:-:|:-:|
|App Icon Type|.appiconset|애플리케이션의 아이콘 입니다.|
|Catalog Type|.xcassets|에셋 카탈로그의 최상위 폴더입니다.|
|Image Set Type|.imageset|객체들이 사용하는 이미지입니다.|
|Data Set Type|.dataset|애플리케이션에서 사용되는 데이터 파일입니다.|
|Launch Image Type|.launchimage|애플리케이션의 실행화면 이미지입니다.|



# App Thinning

* 애플리케이션이 디바이스에 설치될 때, 앱스토어와 운영체제가 그 디바이스의 특성에 맞게 설치하도록 하는 설치 최적화 기술을 의미한다.
* 설치 용량 최소화, 다운로드 속도 향상
* 이 기술의 구성 요소는 슬라이싱, 비트코드, On demand resource가 있다.

# Slicing

![image](https://user-images.githubusercontent.com/37871541/121797722-043c0800-cc5d-11eb-96fb-2a4c04fbf195.png){: .center}_slicing 매커니즘_

* 애플리케이션이 지원하는 다양한 디바이스에 대한 여러 조각의 애플리케이션 번들을 생성하고, 디바이스에 알맞는 조각을 전달하는 기술이다.
* 개발자가 애플리케이션 전체 버전을 ITunes Connect에 업로드하면, 앱스토어에서 각 디바이스 특성에 맞는 다양한 버전의 조각들을 생성한다.
* 사용자가 이제 애플리케이션을 설치할 때, 이 슬라이싱 된 조각들중 디바이스에 가장 적합한 조각을 다운로드한다.




# IBOutlet 변수 이름 바꾸기

1. 해당 변수 클릭
2. 오른쪽 클릭
3. Refactor
4. Rename



# IBAction 이해

* UIKit
  * UIControl
    * UIButton
    * UISwitch
    * UIStepper
    * etc

이렇게 다양한 UIControl 객체를 상속받은 클래스들이 있다. 이 컨트롤 객체에서 발생한 이벤트를 내가 정의한 함수를 콜하게 할 수 있다. 즉 컨트롤 객체에서 이벤트가 발생할 경우, 내가 지정해둔 액션을 호출할 수 있게 할 수 있다는 것.

## 이벤트의 종류

외울 수는 없지만 한번씩 읽어보자. 나중에 찾아보고.

* touchDown  
* 컨트롤을 터치했을 때 발생하는 이벤트
* UIControl.Event.touchDown* 

* touchDownRepeat
* 컨트롤을 연속 터치 할 때 발생하는 이벤트
* UIControl.Event.touchDownRepeat* 

* touchDragInside
* 컨트롤 범위 내에서 터치한 영역을 드래그 할 때 발생하는 이벤트
* UIControl.Event.touchDragInside* 

* touchDragOutside
* 터치 영역이 컨트롤의 바깥쪽에서 드래그 할 때 발생하는 이벤트
* UIControl.Event.touchDragOutside* 

* touchDragEnter
* 터치 영역이 컨트롤의 일정 영역 바깥쪽으로 나갔다가 다시 들어왔을 때 발생하는 이벤트
* UIControl.Event.touchDragEnter* 

* touchDragExit
* 터치 영역이 컨트롤의 일정 영역 바깥쪽으로 나갔을 때 발생하는 이벤트
* UIControl.Event.touchDragExit* 

* touchUpInside
* 컨트롤 영역 안쪽에서 터치 후 뗐을때 발생하는 이벤트
* UIControl.Event.touchUpInside* 

* touchUpOutside
* 컨트롤 영역 안쪽에서 터치 후 컨트롤 밖에서 뗐을때 이벤트
* UIControl.Event.touchUpOutside* 

* touchCancel
* 터치를 취소하는 이벤트 (touchUp 이벤트가 발생되지 않음)
* UIControl.Event.touchCancel* 

* valueChanged
* 터치를 드래그 및 다른 방법으로 조작하여 값이 변경되었을때 발생하는 이벤트
* UIControl.Event.valueChanged* 

* primaryActionTriggered
* 버튼이 눌릴때 발생하는 이벤트 (iOS보다는 tvOS에서 사용)
* UIControl.Event.primaryActionTriggered* 

* editingDidBegin
* UITextField에서 편집이 시작될 때 호출되는 이벤트
* UIControl.Event.editingDidBegin* 

* editingChanged
* UITextField에서 값이 바뀔 때마다 호출되는 이벤트
* UIControl.Event.editingChanged* 

* editingDidEnd
* UITextField에서 외부객체와의 상호작용으로 인해 편집이 종료되었을 때 발생하는 이벤트
* UIControl.Event.editingDidEnd* 

* editingDidEndOnExit
* UITextField의 편집상태에서 키보드의 return 키를 터치했을 때 발생하는 이벤트
* UIControl.Event.editingDidEndOnExit* 

* allTouchEvents
* 모든 터치 이벤트
* UIControl.Event.allTouchEvents* 

* allEditingEvents
* UITextField에서 편집작업의 이벤트
* UIControl.Event.allEditingEvents* 

* applicationReserved
* 각각의 애플리케이션에서 프로그래머가 임의로 지정할 수 있는 이벤트 값의 범위
* UIControl.Event.applicationReserved* 

* systemReserved
* 프레임워크 내에서 사용하는 예약된 이벤트 값의 범위
* UIControl.Event.systemReserved* 

* allEvents
* 시스템 이벤트를 포함한 모든 이벤트
* UIControl.Event.allEvents