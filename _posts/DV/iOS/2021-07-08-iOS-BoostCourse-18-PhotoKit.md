---
layout: post
title: "18: PhotoKit"
category: "DV/iOS"
comments: true
tags: [iOS, "Photos", "PhotoUI"]
feature-img: "assets/img/79.jpg"
feature-title: ""
use_math: true
series: "iOS BoostCourse"
summary: "PhotoKit에 대해서 알아보자."
---

# PhotoKit

* iOS 및 macOS에서 사진 애플리케이션, 사진 확장 기능을 지원
* iOS, tvOS, iCloud 사진 라이브러리를 포함한 사진 및 비디오에 직접 접근 가능
* 편집, 검색, 화면 표시 등이 가능

![image](https://user-images.githubusercontent.com/37871541/124873129-0a759800-e001-11eb-8966-f84b36bce887.png){: .center-small}_PhotoKit_

* 로컬 사진 저장소에 저장되어 있는 정보를 가져오는 데 있어 크게 세가지 기능을 제공한다.

## Asset
![image](https://user-images.githubusercontent.com/37871541/124873492-840d8600-e001-11eb-8e76-17265063dc3b.png){: .center-small}_Asset_

## AssetCollection
![image](https://user-images.githubusercontent.com/37871541/124873507-88d23a00-e001-11eb-94ce-dd8e901f239f.png){: .center-small}_AssetCollection_

## CollectionList
![image](https://user-images.githubusercontent.com/37871541/124873524-8c65c100-e001-11eb-8ad5-07a41058ae4a.png){: .center-small}_CollectionList_

## 가능한 기능

* 객체 가져오기 및 변경 요청
* 변경 관찰 (Observer)
* Asset 요청
  * 지정된 크기의 에셋 요청
  * AVFoundation 객체 요청
* Asset 편집


이하 내용은 사용하면서 Doc 보면서 익히는 것이 좋음.

# Reference

* [iOS 부스트코스](https://www.boostcourse.org/mo326/lecture/16867?isDesc=false)
* [PhotoKit](https://developer.apple.com/documentation/photokit)
