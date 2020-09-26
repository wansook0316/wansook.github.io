---
layout: post
title: "02: EDA"
category: "DS/ML"
comments: true
tags: [Data Science, "Machine Learning", "kaggle"]
feature-img: "assets/img/36.jpg"
feature-title: ""
use_math: true
series: "Kaggle::Santander Transaction"
---

Santander Customer Transaction Prediction 데이터의 EDA를 수행한다.

# EDA

> 탐험적 데이터 탐색을 통해 재료를 알아보자.

## Check the data

```python
# 모양
train_df.shape, test_df.shape
```

```
((200000, 202), (200000, 201))
```

---

```python
train_df.head()
```

![image](https://user-images.githubusercontent.com/37871541/86508006-708c7580-be17-11ea-8d82-7e7f1418249d.png){: .center-text}

```python
test_df.head()
```

![image](https://user-images.githubusercontent.com/37871541/86508017-800bbe80-be17-11ea-8158-60f918129420.png){: .center-text}

```
Train contains:

ID_code (string);
target;
200 numerical variables, named from var_0 to var_199;
Test contains:

ID_code (string);
200 numerical variables, named from var_0 to var_199;
```

---

## Missing Data

```python
def missing_data(data):
    total = data.isnull().sum()
    percent = (data.isnull().sum()/data.isnull().count()*100)
    tt = pd.concat([total, percent], axis=1, keys=['Total', 'Percent'])
    types = []
    for col in data.columns:
        dtype = str(data[col].dtype)
        types.append(dtype)
    tt['Types'] = types
    return(np.transpose(tt))
```

```python
%%time
missing_data(train_df)
```

```
CPU times: user 2.07 s, sys: 134 ms, total: 2.2 s
Wall time: 2.2 s
```

![image](https://user-images.githubusercontent.com/37871541/86508089-3c658480-be18-11ea-9983-6aa6c5fe9aa2.png){: .center-text}

```python
%%time
missing_data(test_df)
```

```
CPU times: user 2.2 s, sys: 132 ms, total: 2.33 s
Wall time: 2.33 s
```

![image](https://user-images.githubusercontent.com/37871541/86508093-438c9280-be18-11ea-9dd8-293aa18d06b5.png){: .center-text}

> 결측치가 없는 것을 확인했다.

# Describe

```python
%%time
train_df.describe()
```

![image](https://user-images.githubusercontent.com/37871541/86508117-746cc780-be18-11ea-9d09-87c17613e435.png)

```python
%time
test_df.describe()
```

![image](https://user-images.githubusercontent.com/37871541/86508121-79ca1200-be18-11ea-8687-ca980dfe9aa1.png)

## 관찰의 결과

1. train, test 모두 표준 편차가 크다.
2. train, test 데이터의 mean, std, min 등의 특성치가 매우 근접하다. 즉, 같은 집합을 대변하는 것처럼 보인다.
3. 각 feature의 평균값은 각기 다르다. 범위가 넓다.
4. train, test의 크기는 같다.

# 변수 상관도

### Reference

[kaggle Notebook](https://www.kaggle.com/gpreda/santander-eda-and-prediction#)
