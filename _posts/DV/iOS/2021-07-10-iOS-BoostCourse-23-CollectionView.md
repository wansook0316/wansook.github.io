---
layout: post
title: "23: CollectionView"
category: "DV/iOS"
comments: true
tags: [iOS, "CollectionView", "UICollectionViewDelegateFlowLayout", "UICollectionView", "UICollectionViewCell"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "CollectionView에 대해서 알아보자."
---

# CollectionView

* 유연하고, 변경가능한 레이아웃 사용가능
* 데이터 아이템의 세트를 표시하는 수단
* 일반적으로는 그리드와 같은 형태


![image](https://user-images.githubusercontent.com/37871541/125154505-45103980-e195-11eb-8acf-ee469e0e856f.png){: .center-small}

* Cell
  * 컬렉션 뷰의 주요 컨텐츠 표시
  * Data Source 객체에서 표시할 셀에 대한 정보를 가져온다
* 보충뷰
  * 섹션에 대한 정보 표시
  * 레이아웃 객체가 제어
  * Header, Footer
* 데코레이션 뷰
  * 스크롤되는 컬렉션 뷰에 대한 배경을 꾸밀 때 사용
* 레이아웃 객체
  * 컬렉션 뷰 내의 아이템 배치 및 시각적 스타일 결정
  * 데이터 소스 객체는 뷰와 콘텐츠 제공
  * 레이아웃 객체는 크기, 위치, 레이아웃과 관련된 특성 결정


# CollectionViewCell

* 컬렉션 뷰에서 데이터를 화면에 표시하기 위해 사용됨
* 냉장고 속의 반찬통이다.
* 데이터 아이템을 화면에 표시
* 두 개의 배경을 표시하는 뷰와 하나의 콘텐츠를 표시하는 뷰로 구성되어 있음
  * 두개의 배경인 이유는 선택되었을 때, 다른 화면을 보여주기 위함
* 레이아웃은 컬렉션 뷰의 레이아웃 객체에 의해 관리됨
* 컬렉션 뷰 셀은 뷰의 재사용 메커니즘을 지원함
* <mark style='background-color: #fff5b1'> 컬렉션 뷰의 셀 클래스 인스턴스는 직접 생성하지 않음 </mark>
* 특정 셀의 하위 클래스를 컬렉션 뷰 객체에 등록한 후, dequeue 메서드를 사용
  * 이거 이전 프로젝트에서 실제로 해봄

## 컬렉션뷰 셀 vs 테이블뷰 셀

* 테이블 뷰 셀의 구조는 콘텐츠 영역과 액세서리 뷰 영역으로 나뉨
* 컬렉션 뷰는 배경뷰와 실제 콘텐츠를 나타내는 콘텐츠 뷰로 나뉨
* 테이블뷰 셀은 기존 스타일이 있음
* 컬렉션뷰 셀을 특정 스타일이 없음
* 테이블뷰 셀을 목록형태로만 레이아웃됨
* 컬렉션뷰 셀을 다양한 레이아웃을 지원


# 데이터 소스와 델리게이트

* 데이터 소스 - 데이터를 관리
* 델리게이트 - 셀의 선택과 강조표시 관리

![image](https://user-images.githubusercontent.com/37871541/125155179-054b5100-e199-11eb-8d28-14913362436a.png){: .center-small}_델리게이트와 데이터 소스_



# UICollectionViewFlowLayout

* 컬렉션 뷰의 셀을 원하는 형태로 정렬할 수 있음
* 플로우 레이아웃은 셀을 선형 경로에 배치

![image](https://user-images.githubusercontent.com/37871541/125156415-38451300-e1a0-11eb-8257-0781186cf38e.png){: .center-small}


그렇다면 선형 결로로 배치하는데 방법이 다를 수 있다. 수직 방법과 수평 방법이 있다.

## 플로우 레이아웃 수직 스크롤

![image](https://user-images.githubusercontent.com/37871541/125156447-632f6700-e1a0-11eb-9cf3-e7d3a06f6d3a.png){: .center-small}


여러개의 셀만 이렇게 사용할 수 있는 것이 아니고, 단일 셀에 대해서도 가능하다. 조금 응용하면 다양한 레이아웃이 가능하다.

![image](https://user-images.githubusercontent.com/37871541/125156486-9e319a80-e1a0-11eb-87f5-bd822eb0d551.png){: .center-small}


## 플로우 레이아웃 수평 스크롤

![image](https://user-images.githubusercontent.com/37871541/125156448-675b8480-e1a0-11eb-85d4-b168966466a6.png){: .center-small}


## 플로우 레이아웃 구성 단계

1. 플로우 레이아웃 객체를 작성
2. 해당 컬렉션 뷰의 레이아웃 객체로 지정
3. 셀의 너비와 높이 구성
4. 셀의 간격 조절
5. 섹션 헤더, 푸터 크기 지정
6. 스크롤 방향 설정

 플로우 레이아웃 대부분 프로퍼티 기본값을 가진다. <mark style='background-color: #f1f8ff'> 하지만 셀의 너비와 높이는 모두 0으로 지정되어 있다. 그래서 이건 지정을 해줘야 한다. 안 그러면 화면에 안보일 수도 있다! </mark>


 ## 플로우 레이아웃 속성 변경

 * 셀크기 지정
   * 모두 크기가 같다면 `itemsize` 프로퍼티 사용
   * 아니라면 delegate에서 메서드 활용
     * 셀마다 크기가 다르다면 특정 행에 존재하는 셀의 개수는 당연히 달라질 수 있다.
 * 간격 지정
   * 같은 행의 셀사이 최소 간격과 행사이의 최소 간격을 지정할 수 있음
   * 여기서 지정하는 값은 최소 간격임. 그래야 셀 크기가 다른 경우도 예쁘게 정렬 가능

![image](https://user-images.githubusercontent.com/37871541/125156648-84448780-e1a1-11eb-8909-760bb602338f.png){: .center-small}


## 콘텐츠 여백 수정

* 여기서 콘텐츠는 셀이 담기는 섹션 뷰를 말한다.
* Inset이라는 단어를 사용한다.

![image](https://user-images.githubusercontent.com/37871541/125156690-c1a91500-e1a1-11eb-841e-1832dd5f1d2f.png) {: .center-verysmall}_inset_


```swift
let inset = UIEdgeInsetsMake(top, left, botom, right)
```


## UICollectionViewDelegateFlowLayout

* UICollectionViewFlowLayout 객체와 상호작용하여 레이아웃을 조정할 수 있음
* 이 프로토콜의 메서드는 셀의 크기, 셀 간 사이간격을 정의한다.


# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/16903/?isDesc=false)
* [About CollectionView](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html)
* [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)