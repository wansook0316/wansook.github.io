---
layout: post
title: "06: UITableView에 대해서"
category: "DV/iOS"
comments: true
tags: [iOS, "UItableView", "UITableViewCell", "dequeueReusableCell"]
feature-img: "assets/img/80.jpg"
feature-title: ""
use_math: true
series: "iOS Experience"
summary: "TableView를 어떻게 쓰는 것이 좋을까."
---

# dequeueReusableCell



```swift
let korean: [String] = ["가","나","다","라","마","바","사","아","자","차","카","타","파","하"]
let english: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return korean.count
        case 1:
            return english.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
        
        if indexPath.row == 1 {
            cell.backgroundColor = UIColor.red
        }
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "한글" : "영어"
    }
}
```

* 테이블 뷰에서 가장 중요한 것은 무엇보다 재사용 셀이다.
* 대용량의 데이터를 보여주기 위해 이러한 선택은 필수 불가결하다.
* 실제로 이를 알아보기 위해 indexPath의 row가 1인 경우 빨간색으로 칠하게 해주었다.
* 만약 재사용이 되지 않는다면, 각각의 섹션에서 1번째 row만이 빨간색으로 칠해져야 한다.

<img width="755" alt="스크린샷 2021-07-06 오후 11 39 45" src="https://user-images.githubusercontent.com/37871541/124619262-7518bd80-deb3-11eb-859b-72afcc401190.png">{: .center}_table view cell을 재사용한 경우_



* 결과는 그렇지 않았다. 아래로 스크롤할 수록 빨간 row는 많이 등장했다.
* 다시 위로 스크롤하고 내리면 점점 더 많이 생긴다.
* 이는 기존에 빨간색으로 칠해진 셀이 흰색으로 다시 바뀌지 않았기 때문.


```swift
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return korean.count
        case 1:
            return english.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell: UITableViewCell = UITableViewCell()
        
        let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
        
        if indexPath.row == 1 {
            cell.backgroundColor = UIColor.red
        }
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "한글" : "영어"
    }
}

```

* 이번에는 한번 인스턴스를 요청할 때마다 계속 생성해 보았다.

<img width="730" alt="스크린샷 2021-07-06 오후 11 46 38" src="https://user-images.githubusercontent.com/37871541/124620440-6979c680-deb4-11eb-8206-65260e966f80.png">{: .center}_인스턴스를 생성한 경우_


* 예상한 결과가 도출되었다.





# Empty Cell을 return 해야 하는 경우

* Json을 파싱해서 데이터를 뿌려주고 싶은 상황이다.
* 그런데, 받아온 데이터가 완전하지 못하다.
* 아래와 같은 Json 파일이 있다고 하자.

```
[
      {"korean_name":"한국","asset_name":"kr"},
      {"korean_name":"독일","asset_name":"de"},
      {"korean_name":"중국","asset_name":"cn"},
      {"korean_name":"이탈리아","asset_name":"it"},
      {"korean_name":"미국","asset_name":"us"},
      {"korean_name":"프랑스","asset_name":"fr"},
      {"korean_name":"일본","asset_name":"jp"}
      
]
```

* 이 상황에서, 사진을 함께 보여주어야 하는데, 해당 사진의 이름은 asset_name앞에 flag가 붙은 상태이다.
* 즉, `flag_kr`이 사진의 이름이 되는 것
* 그런데 중국의 사진이 없는 상황이다. 이러한 경우 파싱은 가능하지만, 해당 뷰를 뿌려주기 위한 사진이 없기 때문에 조치가 필요하다.


```swift
// MARK: - TableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView?.dequeueReusableCell(withIdentifier: Constants.mainCellIdentifier, for: indexPath) as? MainTableViewCell else {
            fatalError("ReuseCell 다운 캐스팅 실패")
        }
        let insertCountry = self.countryList[indexPath.row]
        guard let image = UIImage(named: insertCountry.imageAssetName) else {
            fatalError("image 불러오기 실패")
        }
        cell.countryImageView?.image = image
        cell.countryLabel?.text = insertCountry.koreanName
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryList.count
    }
}
```

* 이와 같은 상황을 처리하기 위해, 일단 dequeue로 셀을 가져오긴한다.
* 이 경우, 일단 cell을 customCell로 다운캐스팅해야하는데 실패할 경우 에러를 띄워 이를 해결한다.
* 또한 현재 파싱된 데이터에 대한 이미지가 없을 경우도 에러를 띄운다.
* 이렇게 할경우 개발을 하는 도중에, 어디서 문제가 발생했는지 알 수 있다.
* <mark style='background-color: #fff5b1'> 하지만, 런타임에서 잘못된 데이터가 들어온 경우 크래시가 나버린다. </mark>
* 이는 굉장히 심각한 문제를 야기한다.
* 그렇기 때문에 유효성 검사를 잘하는 것이 중요하다.
* 지금은, 그런 유효성 검사를 통과했음에도 불구하고 해당 문제를 런타임에서 문자가 없도록 하는 방법을 고민해볼 것이다.





```swift
// MARK: - TableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView?.dequeueReusableCell(withIdentifier: Constants.mainCellIdentifier, for: indexPath) as? MainTableViewCell else {
            print("ReuseCell 다운 캐스팅 실패")
            return tableView.emptyCell(at: indexPath)
        }
        let insertCountry = self.countryList[indexPath.row]
        guard let image = UIImage(named: insertCountry.imageAssetName) else {
            print("image 불러오기 실패")
            return tableView.emptyCell(at: indexPath)
        }
        cell.countryImageView?.image = image
        cell.countryLabel?.text = insertCountry.koreanName
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryList.count
    }
}
```

* 위에서는 Error를 던져서 컴파일 타임에 멈추도록 했지만, 이번에는 빈 Cell을 리턴하도록 했다.
* Guard문 같은 경우 조기 종료를 하기 위해 Return을 꼭해야 하는데, 해당 함수의 Return Type이 UITableViewCell이기 때문에 빈 Cell을 던져주는 것으로 문제를 해결.
* 그런데, 가장 위의 예에서도 보았지만, 만약 이러한 잘못된 데이터가 많은 경우 위의 코드는 많은 양의 빈 Cell 인스턴스를 만들수 있다.
* 상당한 메모리 낭비와 부족상태를 야기할 수 있다.
* 그렇기 때문에 이러한 빈 셀 역시도 Dequeue 방법을 사용해야 한다.

```swift
import UIKit

extension UITableView {
    private static let emptyCellIdentifier = "_UITableViewEmptyCell" // 내부에서만 사용한 identifier
    
    /// 빈 tableviewcell(기본)을 ReusableCell에 등록하고 사용한다.
    func emptyCell(at indexPath: IndexPath) -> UITableViewCell {
        self.register(UITableViewCell.self, forCellReuseIdentifier: UITableView.emptyCellIdentifier)
        
        return self.dequeueReusableCell(withIdentifier: UITableView.emptyCellIdentifier, for: indexPath)
    }
}
```

* 방법중의 하나로 이러한 것을 생각해볼 수 있다.
* UITableView를 확장하고, 빈 셀을 리턴할 때마다, Dequeue해서 반환해주는 것.
* 이 때, 기존의 Dequeue 같은 경우는 화면을 벗어날 경우 자동으로 Dequeue로 들어갔지만, 이번에는 이러한 등록과정을 거쳐주어야 한다.
* 새롭게 빈 셀을 요청할 때마다, 해당 Cell을 등록하고, Dequeue하여 넘겨준다.



# 인스턴스 생성후 넘겼을 때 소멸자 호출

* 그러면 실제로 뷰에서 넘어간 경우, 인스턴스가 메모리에 남아있을까?
* 정말 위의 방법대로 해야되는지 궁금했다.

```swift
class CustomUITableViewCell: UITableViewCell {
    
    deinit {
        print("TestTableViewCell deinit")
    }
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell: CustomUITableViewCell = CustomUITableViewCell()
        
        let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
        
        if indexPath.row == 1 {
            cell.backgroundColor = UIColor.red
        }
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "한글" : "영어"
    }
}
```

* 이렇게 기본 UITableview 를 상속하여 소멸자에 print를 추가하고 실행시켜보았다.

```
TestTableViewCell deinit
TestTableViewCell deinit
TestTableViewCell deinit
TestTableViewCell deinit
TestTableViewCell deinit
TestTableViewCell deinit
TestTableViewCell deinit
TestTableViewCell deinit
TestTableViewCell deinit
TestTableViewCell deinit
```

* 스크롤을 함에 따라, 소멸자가 호출되는 것을 알 수 있었다.
* 결국.. 사실 dequeue를 쓰나 안쓰나, 뷰에 보이는 셀에 대해 유한개의 인스턴스만 유지된다는 것을 알 수 있다.
* 하지만 Dequeue를 썼을 때, 해당 인스턴스를 생성하고 소멸하지 않으므로
* 이러한 부하에 있어서 이를 줄일 수 있다.
* 생성자, 소멸자 호출은 Cost가 비싼 작업이기 때문이다.
* Dequeue를 쓰는 경우, 실제로 해당 셀 인스턴스를 초기화하는 작업을 진행하기 때문에 보다 싸다고 할 수 있다.