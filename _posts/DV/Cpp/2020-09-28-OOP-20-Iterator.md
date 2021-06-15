---
layout: post
title: "20: Iterator (반복자)"
category: "DV/C++"
comments: true
tags: [c++, "OOP"]
feature-img: "assets/img/2.jpg"
feature-title:
use_math: true
series: "Object Oriented Programming"
summary: "반복자는 무엇일까?"
---

# Iterator

반복자는 generic 함수이다. 즉, 일반적인 프로그래밍을 가능하게 하기위해 만들어진 전역함수이다. 우리는 배열을 다루기 위해 vector, array, list와 같은 것들을 사용했다.

그런데, 이녀석들을 다루기 위해서는 이 세가지 객체에 어떤 method가 있는지 알아야 한다. 또한, **어떤 인풋이 들어오든간에, 클래스나 함수를 돌아가기 위해서**는 특정 객체에 접근할 수 있는 일반적인 함수가 존재하는 것이 보다 편리하다. 그래서 Iterator 클래스를 만들고, 가장 많이 사용하는 몇개의 함수를 구현해놓았다.

# Method

Iterator 객체에서 사용할 수 있는 메서드는 다음과 같이 7개이다.

1. `*iter`
2. `iter++`
3. `iter--`
4. `iter1 == iter2`
5. `iter1 != iter2`
6. `begin(객체)`
7. `end(객체)`

이것들은 실제로 우리가 사용하는 **연산자** 가 아니다! 클래스 내부에서 함수 오버로딩을 통해 구현해 놓은 녀석들이다. 그러니 iter1 + iter2 와 같은 것은 불가능하다. `begin` , `end` 는 객체를 집어넣게될 경우, 처음 주소와 끝 주소를 가지는 iterator 객체를 리턴하는 함수이다. 포인터와 비슷하게 사용할 수 있다.

# Example

## iterator를 사용하지 않았을 때,

```c++
#include <iostream>
#include <vector>

using namespace std;

int main(){
    int ary[] = {1,2,3,4};
    int *pBegin, *pEnd;
    pBegin = ary;
    pEnd = ary + 4;

    for (int* pIter = pBegin; pIter != pEnd; pIter++){
        cout << *pIter << endl;
    }
    cout << endl;

    return 0;
}
```

## iterator를 사용할 때

```c++
#include <iostream>
#include <vector>

using namespace std;

int main(){

    vector<int> v{10, 20, 30, 40};
    for(auto iter = begin(v); iter != end(v); iter++){
        cout << *iter << '\t';
    }
    cout << endl;

    return 0;
}
```

여기서 auto를 선언해준게 중요한데, begin 함수에 인풋에 따라 반환하는 iterator의 객체 자료형이 다르기 때문에, 자동으로 이 자료형을 인지할 수 있는 auto를 선언해준다. 아마 iterator 클래스는 template 를 사용하여 만들어져 있을 것이다. 따라서 iter 인스턴스가 end(v) 이기 전까지 증가시키며, 해당 주소의 요소를 출력하게 할 수 있다.

# Example2

```c++
#include <iostream>
#include <vector>
#include <list>

using namespace std;

template<class T>
void print(const T& iter_begin,const T& iter_end){
    for(auto iter = iter_begin; iter != iter_end; iter++)
        cout << *iter << '\t';
    cout << endl;
}


template<class T>
void print_reverse1(const T& iter_begin, const T& iter_end){
    auto iter = iter_end;
    while(iter != iter_begin){
        iter--;
        cout << *iter << '\t';
    }
    cout << endl;
}


int main(){
    vector<int> v1{1, 2,3,4};
    list<double> l1{10.1, 10.2, 10.3};
    int ary[] = {100, 200, 300, 400};

    print(begin(v1), end(v1));
    print(begin(l1), end(l1));
    print(begin(ary), end(ary));
    cout << endl;

    print_reverse1(begin(v1), end(v1));
    print_reverse1(begin(l1), end(l1));
    print_reverse1(begin(ary), end(ary));
    cout << endl;

    return 0;
}
```

거꾸로 출력할 때, iter_end를 하나 줄여준 이유는, `end()` 함수가 해당객체의 다음 주소를 리턴하기 때문이다. 따라서 이 값부터 출력을 시도하게 되면, 쓰레기값이 출력되고 객체의 처음 요소는 출력되지 않는다. for문을 사용해서 reverse로 출력하기 위한 예제는 다음과 같다.

```c++
template<class T>
void print_reverse2(T iter_begin,T iter_end){
    iter_end--;
    iter_begin--;
    for(auto iter = iter_end; iter != iter_begin; iter--){
        cout << *iter << '\t';
    }
    cout <<  endl;
}
```

이렇게 될 경우 레퍼런스로 인자를 가지고 올 수 없게 된다. 함수 안에서 iterator 객체의 주소를 줄인 후에 for문을 돌려야 하기 때문에, 우리는 deep copy를 한 이후 이 함수를 돌릴 수 있게 되는 한계를 가진다.
