---
layout: post
title: "15: TableView"
category: "DV/Swift"
comments: true
tags: [iOS, "TableView"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "테이블 뷰에 대해서 알아보자."
---

# TableView

* 스크롤 가능
* 리스트 형태
* 많은 정보를 보여줄 수 있음


## 기본 형태

* 하나의 열
* 여러 줄의 행
* 수직 스크롤
* 하나의 행은 하나의 Cell에 대응
* Section을 통해 행을 시각적으로 나눌 수 있음
* header, footer에 이미지, 텍스트를 추가하여 추가적인 정보를 보여줄 수 있음

![image](https://user-images.githubusercontent.com/37871541/124417936-3d1b5880-dd95-11eb-8414-cf0831b2acac.png){: .center}_Table View의 기본 형태_

## 테이블 뷰 스타일

* 일반
  * 연속적인 행의 리스트 형태
  * 나뉘지 않고 쭉 간다.
  * 섹션을 나뉠 수 있지만 중간에 빈칸으로 구분은 되지 않는다.
  * 각 섹션은 헤더, 또는 푸터를 옵션으로 가질 수 있음
* 그룹
  * 섹션을 기준으로 그룹화 되어 있음
  * 정보를 특정 기준에 따라 <mark style='background-color: #fff5b1'> 개념적 </mark>으로 구분할 때 적합

![image](https://user-images.githubusercontent.com/37871541/124418100-a56a3a00-dd95-11eb-9999-da6677bf9677.png){: .center}_일반 뷰와 그룹뷰_


## 테이블 뷰 생성

* UITableViewController 클래스의 객체 사용
* 테이블 뷰의 특성을 지정할 수 있음
  * 동적 프로토 타입
    * 셀 하나를 디자인하여 이를 다른 셀의 템플릿으로 사용
    * UITableViewDataSource인스턴스에 의해 콘텐츠를 관리
    * 셀의 개수가 상황에 따라 변하는 경우(ex 데이터를 받아오는 경우)에 사용
  * 정적 셀
    * 고유의 레이아웃과 고정된 수의 행을 가지는 테이블 뷰에 사용
    * 환경설정 등이 있을 수 있겠다.
    * 셀의 개수가 변하지 않는다.


# TableViewCell

* UITableView 클래스 상속
* 기본적인 구조는 셀 콘텐츠, 액세서리뷰로 나뉜다.
  * 셀 콘텐츠
    * 문자열, 이미지, 고유 식별자(id)
  * 액세서리뷰
    * 상세보기, 재정렬, 스위치와 같은 컨트롤 객체 위치

![image](https://user-images.githubusercontent.com/37871541/124418501-8cae5400-dd96-11eb-86ea-f18cc2c9ac22.png){: .center-small}

![image](https://user-images.githubusercontent.com/37871541/124418551-b36c8a80-dd96-11eb-9bb2-da7199918703.png){: .center-small}_TableViewCell_


* 편집 모드
  * 편집 컨트롤
    * 삭제, 추가 중 하나
  * 재정렬 컨트롤이 가능하면 등장. (리스트 위치 변경하는 것)


![image](https://user-images.githubusercontent.com/37871541/124418659-f169ae80-dd96-11eb-9e16-4c267eb0bb9b.png){: .center-small}
![image](https://user-images.githubusercontent.com/37871541/124418667-f4fd3580-dd96-11eb-81e4-d3be5a8a1496.png){: .center-small}

## 기본 기능

* 기본적인 표준 스타일은
  * 이미지
  * 한개 이상의 문자열
* 을 가지고 있다. 이미지가 오른쪽으로 확장되면 문자열이 오른쪽으로 밀려남

![image](https://user-images.githubusercontent.com/37871541/124418865-5f15da80-dd97-11eb-817b-3733ae26d57b.png){: .center-small}
![image](https://user-images.githubusercontent.com/37871541/124418882-6341f800-dd97-11eb-92cd-9c189d7bb31a.png){: .center-small}


## 커스텀 테이블 뷰 셀

* 셀의 콘텐츠 뷰에 서브뷰 추가 (StotyBoard)
* UITableViewCell의 커스텀 서브클래스 만들기 (Code)
  * 이 경우, imageView, textLabel과 같이 기본 변수명을 사용하게 되면, 충돌이 날 수도 있다.
  * 기본 Property의 이름이 저것이라 그렇다. 조심할 것


# DataSource, Delegate

* UITableView는 자기 혼자 작동할 수 없다.
* 잘 생각해보면, 얘는 보여주는 역할이 다임
* 그렇기 때문에, 어떤 객체가 이녀석에게, 추가적인 정보를 조달해주어야 한다.
* 즉, 예를 들면, 
  * DataSource
    * 섹션의 개수는 몇개야?
    * 그럼 첫번째 섹션의 행의 개수는 몇개야?
    * 그럼 첫번째 섹션의 2번째 행에 들어갈 데이터는 뭐야?
  * Delegate
    * 행의 높이는 얼마야?
    * 선택이 되면 무엇을 해야해?
* 이런 식이다. 즉 View는 Controller에게 요청을 한다. 자기가 필요한 정보를
* 그럼 Controller에서는 이것을 처리하여준다.
* 이런 요청을 하는데 있어 DataSource는 MVC의 Model과 관련이 있고
* Delegate는 테이블 뷰의 모양과 동작을 관리하기 때문에 Controller의 역할에 가깝다.
* 그리고 Tableview는 View겠지.

![image](https://user-images.githubusercontent.com/37871541/124419523-9df86000-dd98-11eb-9f32-0230b0b154ee.png){: .center}_Delegate와 Datasource_

## DataSource

* UITableViewDataSource 프로토콜 채택
* 데이터 소스는 테이블 뷰를 생성하고 수정하는데 필요한 정보를 테이블 뷰 객체에 전달
* TableView의 시각적 모양에 대한 최소한의 정보 제공
* 스위프트의 Protocol은 선택적 구현이 가능하다 했다. 아래 메서드중 required는 필수, optional은 선택이다.

```swift
@required 
 // 특정 위치에 표시할 셀을 요청하는 메서드
 func tableView(UITableView, cellForRowAt: IndexPath) 
 
 // 각 섹션에 표시할 행의 개수를 묻는 메서드
 func tableView(UITableView, numberOfRowsInSection: Int)
 
 @optional
 // 테이블뷰의 총 섹션 개수를 묻는 메서드
 func numberOfSections(in: UITableView)
 
 // 특정 섹션의 헤더 혹은 푸터 타이틀을 묻는 메서드
 func tableView(UITableView, titleForHeaderInSection: Int)
 func tableView(UITableView, titleForFooterInSection: Int)
 
 // 특정 위치의 행을 삭제 또는 추가 요청하는 메서드
 func tableView(UITableView, commit: UITableViewCellEditingStyle, forRowAt: IndexPath)
 
 // 특정 위치의 행이 편집 가능한지 묻는 메서드
 func tableView(UITableView, canEditRowAt: IndexPath)

 // 특정 위치의 행을 재정렬 할 수 있는지 묻는 메서드
 func tableView(UITableView, canMoveRowAt: IndexPath)
 
 // 특정 위치의 행을 다른 위치로 옮기는 메서드
 func tableView(UITableView, moveRowAt: IndexPath, to: IndexPath)

```

## Delegate

* UITableViewDelegate
* 테이블 뷰의 시각적인 부분 수정
* 행의 선택관리
* 액세서리뷰 지원
* 개별 행 편집

```swift
// 특정 위치 행의 높이를 묻는 메서드
 func tableView(UITableView, heightForRowAt: IndexPath)
 // 특정 위치 행의 들여쓰기 수준을 묻는 메서드
 func tableView(UITableView, indentationLevelForRowAt: IndexPath)

 // 지정된 행이 선택되었음을 알리는 메서드
 func tableView(UITableView, didSelectRowAt: IndexPath)

 // 지정된 행의 선택이 해제되었음을 알리는 메서드
 func tableView(UITableView, didDeselectRowAt: IndexPath)

 // 특정 섹션의 헤더뷰 또는 푸터뷰를 요청하는 메서드
 func tableView(UITableView, viewForHeaderInSection: Int)
 func tableView(UITableView, viewForFooterInSection: Int)

 // 특정 섹션의 헤더뷰 또는 푸터뷰의 높이를 물어보는 메서드
 func tableView(UITableView, heightForHeaderInSection: Int)
 func tableView(UITableView, heightForFooterInSection: Int)

 // 테이블뷰가 편집모드에 들어갔음을 알리는 메서드
 func tableView(UITableView, willBeginEditingRowAt: IndexPath)

 // 테이블뷰가 편집모드에서 빠져나왔음을 알리는 메서드
 func tableView(UITableView, didEndEditingRowAt: IndexPath?)
```

# 뷰의 재사용

* 테이블 뷰를 보여주는데 있어서 새롭게 보여주어야 하는 데이터가 있을 때마다 인스턴스를 생성한다면 어떨까?
* 아마 메모리가 굉장히 많이 낭비될 것이다.
* 이러한 부분에 대해 화면에 보이는 뷰의 개수 근방의 뷰만을 사용하여 메모리를 절약하고 성능을 향상시킬 수 있다.
* 대표적으로 `UITableViewCell`, `UICollectionViewCell` 등이 있다.

## 원리


![image](https://user-images.githubusercontent.com/37871541/124462901-1547e700-ddcd-11eb-8ace-12c7f29b8e3d.png){: .center-small}_Reuse Queue_

1. 테이블 뷰 및 컬렉션 뷰에서 셀을 표시하기 위해 데이터 소스에 뷰 인스턴스를 요청한다.
2. 데이터 소스는 요청마다 재사용 큐에서 재사용을 위해 대기하고 있는 셀을 확인한다.
   * 있다면 해당 셀에 새로운 데이터를 설정한다.
   * 없다면 새로운 셀을 생성한다.
3. 테이블 뷰 및 컬렉션 뷰는 데이터 소스가 셀을 반환하면 화면에 표시한다.
4. 사용자가 스크롤을 하게 되면, 일부 셀들이 화면 밖으로 사라지면서 다시 재사용 큐에 들어간다.
5. 이를 반복한다.



# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/20638/?isDesc=false)
* [TableViews](https://developer.apple.com/documentation/uikit/views_and_controls/table_views)
* [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
* [H.I.G tables](https://developer.apple.com/design/human-interface-guidelines/ios/views/tables/)

