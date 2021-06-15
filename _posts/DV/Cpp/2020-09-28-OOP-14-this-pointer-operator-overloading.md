---
layout: post
title: "14: this, operator overloading"
category: "DV/C++"
comments: true
tags: [c++, "OOP"]
feature-img: "assets/img/2.jpg"
feature-title:
use_math: true
series: "Object Oriented Programming"
summary: "this 포인터, operator 오버로딩에 대해 알아보자."
---

# Pass by Reference

내가 클래스를 만들고, 그 클래스를 바탕으로 객체를 만들었다. 이 때, 이 클래스에 연결되어 있는, 함수를 메서드라 했다. 그렇다면 이 만들어진 객체를 클래스 밖의 함수에서 input으로 받는다면 어떻게 해야할까?

보통 클래스를 함수의 input parameter로 받을 때, reference로 받는다. 그 이유는 클래스가 저장되어 있는 메모리공간의 절약을 위해서이다.

## const

외부 함수에서 내가 만든 객체를 부를 때, callbyreference로 값을 가져왔다면, 함수 내에서 값이 변경될 수 있다. 그렇기 때문에 함수를 만들 때, input 파라미터 앞에 **const** 를 달아준다.

```c++
void print(const Point& pt){
    // 함수내용
}
```

그런데, 이 함수내에서 함수의 메서드를 사용한다면, 클래스를 정의하는데 있어서 추가적인 작업이 필요한데, const로 이 객체가 사용된다면 const라는 표시가 있는 method만 사용할 수 있다.

```c++
// class 정의
class Point {
private:
    int x;
    int y;

public:
    Point(): x(0), y(0) {}
    Point(int _x, int _y): x(_x), y(_y) {}

    // 외부함수에 객체를 const로 넘겼을 때 사용할 수 있는 함수
    int getX() const {return this->x;}
    int getY() const {return this->y;}

// 외부 함수 정의
void print(const Point& pt){
    cout << pt.getX() << ", " << pt.getY() << endl << endl;
}

```

# Pointer to Object

클래스의 객체를 가리킬 때도 역시 포인터 변수를 선언했던 것과 똑같다.

## \*

우리가 예전에 포인터에 대해서 배울때, 해당 주소의 있는 값으로 점프 하라고 했을 때, `*` 를 사용하기로 했었다. 클래스 변수에 대해 이 것을 취하게 되면 클래스 객체 자체를 말하게 되고, 그제서야 우리는 멤버변수에 접근 할 수 있다.

```c++
#include <iostream>

using namespace std;

class Point{
public:
    int x;
    int y;
};

int main(){
    Point pt1;
    Point* ppt1;

    pt1.x = 1;
    pt1.y = 2;

    ppt1 = &pt1;

    cout << (*ppt1).x << ", " << (*ppt1).y << endl;

    return 0;

}
```

```
1, 2
```

## ->

이번에는 포인터에서 멤버변수로 접근하는 다른 방법을 배워보자.

```c++
#include <iostream>

using namespace std;

class Point{
public:
    int x;
    int y;
};

int main(){
    Point pt1;
    Point* ppt1;

    pt1.x = 1;
    pt1.y = 2;

    ppt1 = &pt1;

	cout << ppt1->x << ", " << ppt1->y << endl;

    return 0;

}
```

```
1, 2
```

**_포인터 변수(주소가 담긴) -> 변수_** 이런식으로 적어주게 되면, "해당 포인터 주소로 가서, 변수 x의 값을 읽어!" 라는 뜻이 된다.

## 동적할당 new, delete

동적할당도 역시 할 수 있다. 동적할당은, 한 함수내에서 함수가 종료되기 전에도 값을 메모리 공간에 넣었다가 삭제할 수 있어 효율성을 높일 수 있는 방법이었다.

```c++
#include <iostream>

using namespace std;

class Point{
public:
    int x;
    int y;
};

int main(){
    Point* pt1, pt2;

    pt1 = new Point;
    pt2 = new Point[5];

    pt1.x = 1;
    pt1.y = 2;

    cout << ppt1->x << ", " << ppt1->y << endl;

    delete pt1;
    delete pt2;

    return 0;
}
```

### 주의사항

동적할당을 해제하지 않으면, 함수가 종료된 이후에도 남아있으므로! stream 객체를 사용했을 때와 마찬가지로 꼭! **delete로 할당을 해제** 해주어야 한다!

## this Pointer

> 자기 자신의 주소값을 가져온다.

우리가 class를 만들다보면, 특정 메서드를 사용했을 때, 자기자신을 내뱉어야 하는 경우가 발생한다. 이 것을 위해서 우리는 매서드 안에서 **this** 라는 포인터를 가지고 사용한다.

```c++
#include <iostream>

using namespace std;

class Point{
public:
    int x;
    int y;

    // 메서드를 호출하면 자신의 멤버변수에 값을 할당한다.
    void setXY(int _x, int _y){
        this->x = _x;
        this->y = _y;
    }

    // const 는 다른 함수에서 썼을 때 const로 받는 경우에 사용가능한 함수
    //
    int getX() const {return this->x;}
    int getY() const {return this->y;}
};


```

# Overloading

같은 함수이름, 혹은 연산자를 사용하면서, 하나 이상의 정의가 가능한 방법이다.

## Function Overloading

연산자 오버로딩과 방식이 동일하다. 밑에서 예를 든것을 보고 이해해보자.

## Operator Overloading

```c++
Point operator +(Point& pt){
        Point result(this->x + pt.x, this->y + pt.y);
        return result;
    }
```

```c++
pt1(1, 2);
pt2(3, 4);
pt1 + pt2;
// 여기서 pt1은 + 연산자를 호출했을 때, 기본적으로 들어가는 input parameter가 된다.
// 이녀석이 호출했다고 컴파일러는 처리한다.
// 따라서 이녀석이 호출했기 때문에 + 연산자에 안에서
// 호출한 녀석의 멤버변수를 가지고 쓰기 위해서는 this 포인터로 접근하면 된다.
```

```
4, 6
```

이 연산자는, Point 객체를 리턴하고 '+' operator 에 대해서, 오른쪽에 Point 변수를 reference로 받는다. 받은 Point 객체에 대해, result 라는 Point 객체를 만들고, 초기값에 pt1의 멤버변수 x와 나중에 나온 pt2의 x를 더한값을 result의 멤버변수 x로 할당한다. 같은 원리로 result의 멤버변수 y도 할당한다. 그리고 Point 객체 result를 반환한다.

```c++
Point operator = (Point& pt){
        this->x = pt.x;
        this->y = pt.y;
        return (*this);
    }
// 연산자의 왼쪽에 있는 객체가 호출했다고 생각한다.
// 그때의 그 객체를 나타내는 게 여기서 this 포인터.
// 그래서 호출한 객체의 x에 받은 input의 x를 할당한다.
// 같은 방식으로 y도 수행한다.
```

```c++
pt1(1, 2);
pt2(3, 4);
pt3 = pt1 + pt2;
// 오른쪽에 계산된 값을 왼쪽에 할당한다.
```

### 외부에서 정의한 operator overloading

클래스 내부에서 모든 연산자 오버로딩을 하기 힘들 수 있다. 왜냐하면, 다른 객체를 클래스 내부에서 정의하게 되기 때문이다. 이렇게 될 경우 코드가 지저분해지고, 의존성이 생길 수 있다. 따라서 우리는 클래스 외부에서 함수를 정의하고 이것이 클래스와 연관 되어 있다고 알려주는 방식을 사용한다. 이것은 **friend** 에서 배워보기로 하고 일단은 외부에서 정의하는 방법을 알아보자.

```c++
ostream& operator <<(ostream& cout, Point& pt){
    cout << pt.getX() << ", " << pt.getY();
    return cout;
}
```

기본적으로 operator는 왼쪽과 오른쪽 두개의 파라미터를 받는다. 첫번째 파라미터는, 연산자 왼쪽에 놓인 객체, 두번째 파라미터는, 연산자 오른쪽에 놓인 객체를 말한다. 이 연산자 오버로딩을 말로 설명해보면,

1. 이 연산자는 ostream의 객체를 reference 로 리턴한다.
2. `<<` 연산자를 사용하며,
3. 이 왼쪽에는 ostream 의 객체를 cout이란 이름으로 callbyreference한다.
4. 오른쪽에는 Point 객체를 pt라는 이름으로 callbyreference 한다.
5. 그렇게 했을 때, cout으로 각각을 출력하고,
6. cout 객체를 리턴한다.

여기서, 우리가 cout 객체로 여러번 출력이 가능한 이유는, **cout 객체를 반환** 하기 때문이라는 것을 알 수 있다. 같은 원리로, int, double과 같은 모든 자료형에 대해 **연산자 오버로딩** 의 방식으로 위와 같이 선언되어 있다. 함수 오버로딩도 위와 같은 방식으로 구현되어 있다.

# 여기까지 구현한 전체 코드

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


};

void print(const Point& pt){
    cout << pt.getX() << ", " << pt.getY() << endl << endl;
    // 만약 x, y를 public 으로 선언했다면 다음도 같은 코드
    // cout << pt.x << ", " << pt.y << endl << endl;

}

ostream& operator << (ostream& cout, Point& pt){
    cout << pt.getX() << ", " << pt.getY();
    return cout;
}



int main(){

    // print 사용, const
    Point pt1(1, 2);
    print(pt1);



    // 동적할당, 해제, new, delete
    Point* pPt2 = new Point(10,20);
    print(*pPt2);

        // -> 사용
        cout << pPt2->getX() << ", " << pPt2->getY() << endl << endl;

    delete pPt2;


    // 연산자 오버로딩
    Point pt3(5, 6), pt4(7, 8);
    Point pt5 = pt3 + pt4;
    cout << pt3 << endl;
    cout << pt4 << endl;
    cout << pt5 << endl;


    return 0;
}

```
