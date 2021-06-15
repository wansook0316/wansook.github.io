---
layout: post
title: "15: friend, static, destructor"
category: "DV/C++"
comments: true
tags: [c++, "OOP"]
feature-img: "assets/img/2.jpg"
feature-title:
use_math: true
series: "Object Oriented Programming"
summary: "각종 키워드에 대해서 알아보자."
---

# friend

두 개의 클래스가 있을 때, 서로 만들어진 모든 멤버변수, 멤버함수를 공유하기 위해서 우리는 friend 라는 키워드를 사용할 수 있다.

a 객체가 b 객체를 친구로 선언한다면 b객체는 a객체의 **모든** 변수와 함수값을 갖다가 사용할 수 있다. **Private** 까지 사용가능하다.

```c++
#include <iostream>

using namespace std;

class Point{
private:
    int x;
    int y;



public:
    Point(): x(0), y(0){}
    Point(int _x, int _y): x(_x), y(_y) {}

    void setXY(int _x, int _y){
        this->x = _x;
        this->y = _y;
    }

    int getX() const { return this->x; }
    int getY() const { return this->y; }

    Point operator + (Point& pt){
        Point result(this->x + pt.x, this->y + pt.y);
        return result;
    }

    Point operator - (Point& pt){
        Point result(this->x - pt.x, this->y - pt.y);
        return result;
    }

    Point operator = (Point& pt){
        this->x = pt.x;
        this->y = pt.y;
        return (*this);
    }

    // SpyPoint에 Point 클래스의 모든 정보를 넘겨준다.
    friend class SpyPoint;
};

class SpyPoint{
public:
    void print_all_point_info(Point& pt){
        cout << "SpyPoint에 의해 출력됩니다." << endl;
        cout << "x : " << pt.x << endl;
        cout << "y : " << pt.y << endl;
        cout << "numCreatedObjects: " << pt.getNumCreatedObject() << endl;
    }
};


int main(){
    Point pt1(1, 2), pt2(3, 4);

    SpyPoint spyPt;
    spyPt.print_all_point_info(pt1);
    spyPt.print_all_point_info(pt2);

    return 0;
}
```

```
Output
SpyPoint에 의해 출력됩니다.
x : 1
y : 2
numCreatedObjects: 2
SpyPoint에 의해 출력됩니다.
x : 3
y : 4
numCreatedObjects: 2
Program ended with exit code: 0
```

# static Members

때때로는, 클래스의 객체들이 모두 공유하는 변수를 가지는 것이 용이하다. 전역변수와는 조금 다른 점이 있는데,

- **공통점** : 특정 함수나 클래스가 끝나고 나서 변수가 사라지지 않는다.
- **차이점** : 특정 클래스에 구속되어 있다.

이것을 구현하고 싶으면 **Static** 키워드를 붙여주면 된다. 특이한 점은, 이 변수를 사용하기 전에 초기화는, 클래스 내부에서 하지 않고, **전역변수처럼 main 함수 밖에서 한다.**

```c++
#include <iostream>

using namespace std;

class Point{
private:
    int x;
    int y;
    // 선언!!
    static int numCreatedObjects;

public:
    // 초기화시 개수를 하나씩 늘려줌
    Point(): x(0), y(0){
        numCreatedObjects++;
    }
    Point(int _x, int _y): x(_x), y(_y) {
        numCreatedObjects++;
    }

    // public에서 이 숫자를 접근 할 수 있게 함수를 만들어줌.
    static int getNumCreatedObject(){ return numCreatedObjects; }
};

// 여기서 초기화를 해준다!
int Point::numCreatedObjects = 0;


int main(){
    Point pt1(1, 2);
    cout << pt1.getNumCreatedObject() << endl;

    Point pt2(3, 3);
    cout << pt1.getNumCreatedObject() << endl;
    cout << pt2.getNumCreatedObject() << endl;

    return 0;
}
```

```
1
2
2
```

pt1 과 pt2에 관련없이 생성된 객체의 개수만큼 반환되는 것을 알 수 있다.

# Class vs Structure

구조체는 클래스와 비슷하다! 하지만 구조체는 **Public** 이 기본값이다! 하지만 요즘에는 많은 부분이 차이가 없어졌다. 여전히 그래도 class를 많이 사용한다.

# Destructor

소멸자는 특별한 멤버함수이다. 객체가 생성되고, 소멸될 때 호출된다. 소멸자의 목적은, 컴퓨팅 자원의 절약에 있다. 객체가 생성되고 계속 남아있다면 메모리 자원을 많이 소모하게 된다.

생성자와 마찬가지로 굳이 적어주지 않는다면, 기본적으로 소멸자는 호출되며 만약 내가 적어준다면 객체가 생성되고 소멸할 때마다 호출되어 내가 원하는 작업을 수행한다.

내가 소멸자를 명시적으로 적어준다면 기본적으로 호출된 소멸자는 작동하지 않고, 내가 적어준 녀석만 작동한다.

### Example

- **생성자** : new, file open
- **소멸자** : delete, file close

```c++
class Point{
private:
    int x;
    int y;



public:
    Point(): x(0), y(0){}
    Point(int _x, int _y): x(_x), y(_y) {}

    ~Point(){
        cout << "소멸되었습니다." << endl;
    }
};

int main(){
    Point pt1(1,2);

    return 0;
}

```

```
Output
소멸되었습니다.
```

# 지금까지 짠 소스코드 정리

```c++

#include <iostream>

using namespace std;

class Point{
private:
    int x;
    int y;
    static int numCreatedObjects;

public:
    Point() : x(0), y(0) {
        cout << "Point 객체 생성" << endl;
        cout << "numCreatedObjects 1 증가" << endl;
        numCreatedObjects++;
    }
    Point(int _x, int _y) : x(_x), y(_y) {
        cout << "Point 객체 생성" << endl;
        cout << "numCreatedObjects 1 증가" << endl;
        numCreatedObjects++;
    }

    static int getNumCreatedObjects() {return numCreatedObjects;}

    ~Point(){ cout << "소멸되었습니다." << endl; }

    void setXY(int _x, int _y){
        this->x = _x;
        this->y = _y;
    }

    int getX() const { return x;}
    int getY() const { return y;}

    Point operator + (Point& pt){
        Point result(this->x + pt.x, this->y + pt.y);
        return result;
    }

    Point operator - (Point& pt){
        Point result(this->x - pt.x, this->y - pt.y);
        return result;
    }

    Point operator = (Point& pt){
        this->x = pt.x;
        this->y = pt.y;
        return (*this);
    }

    friend class SpyPoint;
};


class SpyPoint{
public:
    void print_all_point_info(Point& pt){
        cout << "SpyPoint 클래스에 의해 해킹됨" << endl;
        cout << "x : " << pt.x << endl;
        cout << "y : " << pt.y << endl;
        cout << "numCreatedObjects: " << pt.getNumCreatedObjects() << endl << endl;;
    }
};

int Point::numCreatedObjects = 0;

void print(const Point& pt){
    cout << pt.getX() << ", " << pt.getY() << endl;
}

ostream& operator << (ostream& cout, Point& pt){
    cout << pt.getX() << ", " << pt.getY();
    return cout;
}




int main(){
    cout << "%%%%%%%% OUTPUT %%%%%%%%%" << endl<< endl << endl;
    cout << "생성자 확인하기" << endl;
    Point pt1(1, 2);
    cout << endl << endl;

    cout << "print 함수 확인하기" << endl;
    print(pt1);
    cout << endl << endl;

    cout << "setXY 확인하기" << endl;
    pt1.setXY(3, 3);
    print(pt1);
    cout << endl << endl;

    cout << "new, delete, destructor 확인하기" << endl;
    Point* pPt1 = new Point[5];
    delete[] pPt1;
    cout << "동적할당 이후 delete 를 사용하면 중간에 객체를 삭제할 수 있다." << endl;
    cout << endl << endl;

    cout << "연산자 오버로드" << endl;
    Point pt2(2, 3), pt3(3, 4);
    Point pt4 = pt2 + pt3;
    print(pt4);
    cout << endl << endl;

    cout << "Static 변수 확인" << endl;
    cout << pt1.getNumCreatedObjects() << endl;
    cout << pt2.getNumCreatedObjects() << endl;
    cout << pt3.getNumCreatedObjects() << endl;
    cout << endl << endl;

    cout << "SpyPoint friend 확인" << endl;
    SpyPoint spyPt;
    spyPt.print_all_point_info(pt1);
    spyPt.print_all_point_info(pt2);
    cout << endl << endl;

    cout << "객체가 모두 사용이 끝났으므로 소멸자가 호출됨" << endl;

    return 0;
}

```

```
%%%%%%%% OUTPUT %%%%%%%%%


생성자 확인하기
Point 객체 생성
numCreatedObjects 1 증가


print 함수 확인하기
1, 2


setXY 확인하기
3, 3


new, delete, destructor 확인하기
Point 객체 생성
numCreatedObjects 1 증가
Point 객체 생성
numCreatedObjects 1 증가
Point 객체 생성
numCreatedObjects 1 증가
Point 객체 생성
numCreatedObjects 1 증가
Point 객체 생성
numCreatedObjects 1 증가
소멸되었습니다.
소멸되었습니다.
소멸되었습니다.
소멸되었습니다.
소멸되었습니다.
동적할당 이후 delete 를 사용하면 중간에 객체를 삭제할 수 있다.


연산자 오버로드
Point 객체 생성
numCreatedObjects 1 증가
Point 객체 생성
numCreatedObjects 1 증가
Point 객체 생성
numCreatedObjects 1 증가
5, 7


Static 변수 확인
9
9
9


SpyPoint friend 확인
SpyPoint 클래스에 의해 해킹됨
x : 3
y : 3
numCreatedObjects: 9

SpyPoint 클래스에 의해 해킹됨
x : 2
y : 3
numCreatedObjects: 9



객체가 모두 사용이 끝났으므로 소멸자가 호출됨
소멸되었습니다.
소멸되었습니다.
소멸되었습니다.
소멸되었습니다.
Program ended with exit code: 0
```
