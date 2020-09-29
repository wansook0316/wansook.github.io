---
layout: post
title: "18: Generic Programming, Template"
category: "DV/C++"
comments: true
tags: [c++, "OOP"]
feature-img: "assets/img/2.jpg"
feature-title:
use_math: true
series: "Object Oriented Programming"
summary: "일반화 프로그래밍, 대표적으로 템플릿에 대해 알아본다."
---

# Generic Programming

`vector` 컨테이너를 보게되면, 다음과 같이 선언하게 되는데,

```c++
vector<int> v(3, 0);
vector<double> v(3, 10.3);
```

자료형을 추가적으로 정해서 벡터 컨테이너를 만들 수 있게 되어있다. 벡터 역시 클래스로 구현이 되어 있을 텐데 이 때, 벡터라는 녀석을 생각해보면 여러개의 자료형에 대해 결국 **같은 행위, 즉, 동적 배열을 할당** 하는 역할을 담당하고 있다는 것을 알 수 있다. 그렇다면 결국은 **함수 오버로딩** 으로 구현이 되어 있다는 소리이다.

```c++
bool less_than(int a, int b){return a < b;}
bool less_than(double a, double b){return a < b;}
```

위와 같이, less_than 함수는, 다른 자료형에 대해 같은 역할을 하는 함수이다. 그렇기 때문에 내가 클래스를 구현할 때, 다른 자료형이 들어오더라도 같은 역할을 하기 위해서는 이렇게 여러개의 자료형에 대해 정의를 일일히 해줘야하는 번거로움이 존재한다. 이렇게 귀찮은 것을 하지 않기 위해 우리가 사용할 수 있는 것이 **template** 이다.

# template

```
template<class T>
```

어떤 클래스를 구현하거나, 또는 함수를 사용하기 이전에 내가 자료형들이 묶여있는 template을 다음과 같이 선언해줄 경우, 우리는 각각의 다른 자료형을 구현할 필요 없이 T 클래스의 인자를 선언하므로써 쉽게 함수 오버로딩을 가능케 할 수 있다.

```
T - > int, double, object...
```

따라서 위에 구현된 함수는 다음과 같이 쓸 수 있다. 만약 들어오는 자료형이 다르다면, 두개의 Template class도 사용할 수 있다.

```c++
template <class T, class V>
```

```C++
bool less_than(const T& a, const T& b){return a < b;}
```

a, b 변수에 들어올 수 있는 것은 간단한 int 자료형 부터, 클래스 객체까지 들어올 수 있기 때문에 우리는 **reference** 를 달아 참조로 가지고 오며, 또한 이 함수 안에서 각각의 변수는 변경하지 않을 것이므로 const를 달아 명시적으로 표현하자.

또, 입력파라미터로 저렇게 템플릿 클래스를 사용해서 적어줬을 경우,. 함수를 호출했을 때, **T클래스는 고정된다.** 따라서 만약에 T 클래스의 value를 찾고 싶다면, **auto** 자료형을 써야한다. 밑의 예제에서 보도록 하자.

## Example 1

int, double, float등 수를 다루는 자료형 전반에 대해 **Sum** 함수를 구현해 보자.

```c++
#include<vector>
#include<iostream>

using namespace std;

template<class T>

T sum(vector<T> v){
    T result = 0;
    for(auto elem : v){
        result += elem;
    }
    return result;
}
```

## Example 2

이전에 구현했던 Point 클래스를 각 자료형을 인자로 받을 수 있도록 template 를 사용해서 구현해보자.

```c++
#include <iostream>

using namespace std;

template <class T>
class Point {
private:
    T x;
    T y;

public:
    Point(T _x, T _y);
    void setXY(T _x, T _y);
    T getX();
    T getY();

    void print();
};

template<class T>
Point<T>::Point(T _x, T _y) : x(_x), y(_y){}

template<class T>
void Point<T>::setXY(T _x, T _y){
    x = _x;
    y = _y;
}
template<class T>
T Point<T>::getX(){return x;}

template<class T>
T Point<T>::getY(){return y;}

template<class T>
void Point<T>::print(){ cout << x << ", " << y << endl;}


int main(){
    Point<int> pt(1,2);
    Point<double> pt2(1.1, 2.2);

    pt.print();
    pt2.print();

    return 0;
}

```

```
Output
1, 2
1.1, 2.2
Program ended with exit code: 0
```

## Example 3

```c++
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

template <class Iter>
int find_max(const Iter& iter_begin,const Iter& iter_end){
    int max_idx = 0;
    int idx = 0;
    auto max = *iter_begin;

    for_each(iter_begin, iter_end,
             [&](int elem){
                 if(elem > max){
                     max = elem;
                     max_idx = idx;
                 }
                 idx++;
             }
             );

    return max_idx;
}



int main(){
    vector<int> v1{1, 3, 5, 4, 7, 6};
    vector<double> v2{1.1, 4.4, 3.3, 5.5, 2.2};
    cout << "argmax(v1) : " << find_max(begin(v1), end(v1)) << endl;
    cout << "argmax(v2) : " << find_max(begin(v2), end(v2)) << endl;

    return 0;
}
```
