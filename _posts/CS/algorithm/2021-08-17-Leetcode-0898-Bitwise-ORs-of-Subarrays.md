---
layout: post
title: "898: Bitwise ORs of Subarrays"
category: "CS/Algorithm"
comments: true
tags: [Leetcode, 알고리즘, "DP"]
feature-img: "assets/img/57.jpg"
feature-title:
use_math: true
series: "LeetCode"
---

**_Medium_** : DP 문제이다.

# 풀이

가장 나중에 들어오는 원소의 경우 앞쪽에 발생하는 sub array를 기반으로 개수가 산정된다.

이 때, union 연산을 사용하면, 계산에 할당까지 이루어져 비효율적이라 시간초과 난다.

# Code

```python
import Foundation

class Solution {
    func subarrayBitwiseORs(_ arr: [Int]) -> Int {
        var ret = Set<Int>()
        var prev = Set<Int>()
        
        for num in arr {
            var curr = Set<Int>([num])
            for prevNum in prev {
                curr.insert(num | prevNum)
            }
            
            prev = curr
            ret.formUnion(curr) // union이 속도가 오래걸림
        }
        return ret.count
    }
}


let solution = Solution()
print(solution.subarrayBitwiseORs([1,1,2]))

```


# Reference

* [LeetCode - 898. Bitwise ORs of Subarrays](https://leetcode.com/problems/bitwise-ors-of-subarrays/){: target="\_blank"}
