---
layout: post
title: "09: Hyper Parameter Tuning"
category: "DS/ML"
comments: true
tags: [DS, "kaggle", "ML", "titanic", "hyper parameter"]
feature-img: "assets/img/36.jpg"
feature-title: ""
use_math: true
series: "Titanic"
---

Kaggle에 있는 Titanic Prediction 문제의 모델 파라미터를 튜닝한다.  


# Hyper Parameter Tuning

지금까지 돌린 모델은, default setting을 가지고 수행했다. 이제 해당 모델의 세팅값을 변경하면서 결과를 도출해볼 것이다. 그런데, 문제가 있다. 기기를 다루기 위해서는 그 기기에 대해서 이해해야 한다는 것이다. 위에서 handmade 모델을 간단하게 구현해 본 이유가 그것이다. 추후에, 다양한 알고리즘의 세팅값을 변경하고 싶다면 알고리즘에 대해 어느정도 공부해야 한다. 이번에는 아까 구현한 decision tree 기법을 토대로, 해당 알고리즘에 대해 알아본다.

## Decision Trees

> 계속 되는 분기를 설정하여 예측을 하는 방법

### 장점
1. 이해하고 해석하기 편리하다. 시각화 할 수 있다.
2. 데이터 준비가 거의 필요없다. 정규화 X, Dummy화 X. 하지만 결측치(NULL)을 지원하지 않는다.
3. 트리를 학습하기 위한 Cost는 log(# of data) 이다.
4. 수치 및 범주형 데이터를 모두 처리 가능하다. 일반적으로는 한가지 유형의 변수에 대해 분석을 수행한다.
5. multi-output 문제를 다룰 수 있다.
6. white box 모델이다. 즉, 결과에 대해 쉽게 설명이 가능하다.
7. 통계적 검증을 test를 통해 검증이 가능하다. 모델의 설명력을 측정할 수 있다.

### 단점
1. 지나치게 깊은 트리를 사용하여 일반화를 놓치는 모델을 만들 수 있다. 즉 오버피팅이다. 최대 트리의 깊이나, 잎의 수와 같은 제약을 거는 것이 좋다.
2. 결정 트리는 상당히 불안정하다. 데이터에서 약간의 변동이 생긴다면 즉각 적용이 되어 다른 트리가 생성되기 때문이다. 이러한 부분은 여러개의 트리를 앙상블하여 완화시킬 수 있다.
3. 최적의 결정 트리를 학습하는 문제는 NP 문제이다. 따라서 트리를 만드는데 있어서는 Greedy 알고리즘을 사용한다. 그렇기 때문에 만들어진 트리는 최적의 결과라고 보장할 수 없다. 마찬가지로 앙상블을 통해 완화할 수 있다.
4. 결정 트리로는 배타적 논리합이나 패리티, 멀티플렉서와 같은 문제를 학습하기 어렵다. 
5. 각각 서로 다른 수의 단계로 분류가 가능한 변수를 포함하는 데이터에 대하여 더 많은 단계를 가지는 속성 쪽으로 정보 획득량이 편향되는 문제가 있다. 데이터의 균형을 맞추는 것이 좋다. 하지만 이 문제는 조건부 추론을 통해 해결이 가능하다.


### sklearn parameters
```python
class sklearn.tree.DecisionTreeClassifier(criterion=’gini’, splitter=’best’, max_depth=None, min_samples_split=2, min_samples_leaf=1, min_weight_fraction_leaf=0.0, max_features=None, random_state=None, max_leaf_nodes=None, min_impurity_decrease=0.0, min_impurity_split=None, class_weight=None, presort=False)
```

우리는 여기서 [ParameterGrid](http://scikit-learn.org/stable/modules/generated/sklearn.model_selection.ParameterGrid.html#sklearn.model_selection.ParameterGrid), [GridSearchCV](http://scikit-learn.org/stable/modules/generated/sklearn.model_selection.GridSearchCV.html#sklearn.model_selection.GridSearchCV), 그리고 [sklearn scoring](http://scikit-learn.org/stable/modules/model_evaluation.html)을 사용할 것이다. 

추가적으로 [ROC_AUC scores](http://www.dataschool.io/roc-curves-and-auc-explained/)에 대해서 배우고 오자. [Click here to learn more about ROC_AUC scores](http://www.dataschool.io/roc-curves-and-auc-explained/). 다음으로는 [graphviz](http://scikit-learn.org/stable/modules/generated/sklearn.tree.export_graphviz.html#sklearn.tree.export_graphviz)을 사용하여 결정 트리를 시각화할 것이다.



### Grid search

```python
#base model
dtree = tree.DecisionTreeClassifier(random_state = 0)
base_results = model_selection.cross_validate(dtree, data1[data1_x_bin], data1[Target], cv = cv_split)
dtree.fit(data1[data1_x_bin], data1[Target])

print('BEFORE DT Parameters: ', dtree.get_params())
print("BEFORE DT Training w/bin score mean: {:.2f}". format(base_results['train_score'].mean()*100)) 
print("BEFORE DT Test w/bin score mean: {:.2f}". format(base_results['test_score'].mean()*100))
print("BEFORE DT Test w/bin score 3*std: +/- {:.2f}". format(base_results['test_score'].std()*100*3))
#print("BEFORE DT Test w/bin set score min: {:.2f}". format(base_results['test_score'].min()*100))
print('-'*10)


#tune hyper-parameters: http://scikit-learn.org/stable/modules/generated/sklearn.tree.DecisionTreeClassifier.html#sklearn.tree.DecisionTreeClassifier
param_grid = {'criterion': ['gini', 'entropy'],  #scoring methodology; two supported formulas for calculating information gain - default is gini
              #'splitter': ['best', 'random'], #splitting methodology; two supported strategies - default is best
              'max_depth': [2,4,6,8,10,None], #max depth tree can grow; default is none
              #'min_samples_split': [2,5,10,.03,.05], #minimum subset size BEFORE new split (fraction is % of total); default is 2
              #'min_samples_leaf': [1,5,10,.03,.05], #minimum subset size AFTER new split split (fraction is % of total); default is 1
              #'max_features': [None, 'auto'], #max features to consider when performing split; default none or all
              'random_state': [0] #seed or control random number generator: https://www.quora.com/What-is-seed-in-random-number-generation
             }

#print(list(model_selection.ParameterGrid(param_grid)))

#choose best model with grid_search: #http://scikit-learn.org/stable/modules/grid_search.html#grid-search
#http://scikit-learn.org/stable/auto_examples/model_selection/plot_grid_search_digits.html
tune_model = model_selection.GridSearchCV(tree.DecisionTreeClassifier(), param_grid=param_grid, scoring = 'roc_auc', cv = cv_split)
tune_model.fit(data1[data1_x_bin], data1[Target])

#print(tune_model.cv_results_.keys())
#print(tune_model.cv_results_['params'])
print('AFTER DT Parameters: ', tune_model.best_params_)
#print(tune_model.cv_results_['mean_train_score'])
print("AFTER DT Training w/bin score mean: {:.2f}". format(tune_model.cv_results_['mean_train_score'][tune_model.best_index_]*100)) 
#print(tune_model.cv_results_['mean_test_score'])
print("AFTER DT Test w/bin score mean: {:.2f}". format(tune_model.cv_results_['mean_test_score'][tune_model.best_index_]*100))
print("AFTER DT Test w/bin score 3*std: +/- {:.2f}". format(tune_model.cv_results_['std_test_score'][tune_model.best_index_]*100*3))
print('-'*10)


#duplicates gridsearchcv
#tune_results = model_selection.cross_validate(tune_model, data1[data1_x_bin], data1[Target], cv  = cv_split)

#print('AFTER DT Parameters: ', tune_model.best_params_)
#print("AFTER DT Training w/bin set score mean: {:.2f}". format(tune_results['train_score'].mean()*100)) 
#print("AFTER DT Test w/bin set score mean: {:.2f}". format(tune_results['test_score'].mean()*100))
#print("AFTER DT Test w/bin set score min: {:.2f}". format(tune_results['test_score'].min()*100))
#print('-'*10)

```

```
BEFORE DT Parameters:  {'class_weight': None, 'criterion': 'gini', 'max_depth': None, 'max_features': None, 'max_leaf_nodes': None, 'min_impurity_decrease': 0.0, 'min_impurity_split': None, 'min_samples_leaf': 1, 'min_samples_split': 2, 'min_weight_fraction_leaf': 0.0, 'presort': False, 'random_state': 0, 'splitter': 'best'}
BEFORE DT Training w/bin score mean: 89.51
BEFORE DT Test w/bin score mean: 82.09
BEFORE DT Test w/bin score 3*std: +/- 5.57
----------
AFTER DT Parameters:  {'criterion': 'gini', 'max_depth': 4, 'random_state': 0}
AFTER DT Training w/bin score mean: 89.35
AFTER DT Test w/bin score mean: 87.40
AFTER DT Test w/bin score 3*std: +/- 5.00
----------
```

grid search를 통해 최적의 파라미터를 찾았다. 


### Feature Selection

모든 변수를 찾는 것이 좋은 모델을 찾는 것으로 이어지지 않는다고 얘기했었다. 따라서 이번에는 많은 feature중 어떤 것을 선택했을 때 가장 좋은 성능을 가지는지 알아본다. sklearn에는 다양한 선택지가 있다. 그 중에서  [recursive feature elimination (RFE) with cross validation (CV)](http://scikit-learn.org/stable/modules/generated/sklearn.feature_selection.RFECV.html#sklearn.feature_selection.RFECV)를 사용할 것이다.

```python
#base model
print('BEFORE DT RFE Training Shape Old: ', data1[data1_x_bin].shape) 
print('BEFORE DT RFE Training Columns Old: ', data1[data1_x_bin].columns.values)

print("BEFORE DT RFE Training w/bin score mean: {:.2f}". format(base_results['train_score'].mean()*100)) 
print("BEFORE DT RFE Test w/bin score mean: {:.2f}". format(base_results['test_score'].mean()*100))
print("BEFORE DT RFE Test w/bin score 3*std: +/- {:.2f}". format(base_results['test_score'].std()*100*3))
print('-'*10)



#feature selection
dtree_rfe = feature_selection.RFECV(dtree, step = 1, scoring = 'accuracy', cv = cv_split)
dtree_rfe.fit(data1[data1_x_bin], data1[Target])

#transform x&y to reduced features and fit new model
#alternative: can use pipeline to reduce fit and transform steps: http://scikit-learn.org/stable/modules/generated/sklearn.pipeline.Pipeline.html
X_rfe = data1[data1_x_bin].columns.values[dtree_rfe.get_support()] # get_support()는 feature에서 사용한 것만 t/f로 표현해준다.
rfe_results = model_selection.cross_validate(dtree, data1[X_rfe], data1[Target], cv  = cv_split)

#print(dtree_rfe.grid_scores_)
print('AFTER DT RFE Training Shape New: ', data1[X_rfe].shape) 
print('AFTER DT RFE Training Columns New: ', X_rfe)

print("AFTER DT RFE Training w/bin score mean: {:.2f}". format(rfe_results['train_score'].mean()*100)) 
print("AFTER DT RFE Test w/bin score mean: {:.2f}". format(rfe_results['test_score'].mean()*100))
print("AFTER DT RFE Test w/bin score 3*std: +/- {:.2f}". format(rfe_results['test_score'].std()*100*3))
print('-'*10)

# feature selection을 기본 모델로 평가하고, 그 모델로 부터 나온 feature를 가지고 모델의 입력으로 넣어
# 다시 파라미터 튜닝을 한다.
#tune rfe model
rfe_tune_model = model_selection.GridSearchCV(tree.DecisionTreeClassifier(), param_grid=param_grid, scoring = 'roc_auc', cv = cv_split)
rfe_tune_model.fit(data1[X_rfe], data1[Target])

#print(rfe_tune_model.cv_results_.keys()) # 어떤 메소드가 있는지 확인
#print(rfe_tune_model.cv_results_['params']) # 파라미터 확인
print('AFTER DT RFE Tuned Parameters: ', rfe_tune_model.best_params_)
#print(rfe_tune_model.cv_results_['mean_train_score'])
print("AFTER DT RFE Tuned Training w/bin score mean: {:.2f}". format(rfe_tune_model.cv_results_['mean_train_score'][tune_model.best_index_]*100)) 
#print(rfe_tune_model.cv_results_['mean_test_score'])
print("AFTER DT RFE Tuned Test w/bin score mean: {:.2f}". format(rfe_tune_model.cv_results_['mean_test_score'][tune_model.best_index_]*100))
print("AFTER DT RFE Tuned Test w/bin score 3*std: +/- {:.2f}". format(rfe_tune_model.cv_results_['std_test_score'][tune_model.best_index_]*100*3))
print('-'*10)
```

```
BEFORE DT RFE Training Shape Old:  (891, 7)
BEFORE DT RFE Training Columns Old:  ['Sex_Code' 'Pclass' 'Embarked_Code' 'Title_Code' 'FamilySize'
 'AgeBin_Code' 'FareBin_Code']
BEFORE DT RFE Training w/bin score mean: 89.51
BEFORE DT RFE Test w/bin score mean: 82.09
BEFORE DT RFE Test w/bin score 3*std: +/- 5.57
----------
AFTER DT RFE Training Shape New:  (891, 6)
AFTER DT RFE Training Columns New:  ['Sex_Code' 'Pclass' 'Title_Code' 'FamilySize' 'AgeBin_Code' 'FareBin_Code']
AFTER DT RFE Training w/bin score mean: 88.16
AFTER DT RFE Test w/bin score mean: 83.06
AFTER DT RFE Test w/bin score 3*std: +/- 6.22
----------
AFTER DT RFE Tuned Parameters:  {'criterion': 'gini', 'max_depth': 4, 'random_state': 0}
AFTER DT RFE Tuned Training w/bin score mean: 89.39
AFTER DT RFE Tuned Test w/bin score mean: 87.34
AFTER DT RFE Tuned Test w/bin score 3*std: +/- 6.21
----------
```

`FareBin`feature가 삭제된 후, 성능이 올라갔다.

### Graph 그리기
```python
#Graph MLA version of Decision Tree: http://scikit-learn.org/stable/modules/generated/sklearn.tree.export_graphviz.html
import graphviz 
dot_data = tree.export_graphviz(dtree, out_file=None, 
                                feature_names = data1_x_bin, class_names = True,
                                filled = True, rounded = True)
graph = graphviz.Source(dot_data) 
graph
```



![image](https://user-images.githubusercontent.com/37871541/81384752-12138580-914d-11ea-8412-7eeb50729d82.png){: .center}





### Reference
[kaggle Notebook](https://www.kaggle.com/ldfreeman3/a-data-science-framework-to-achieve-99-accuracy#)  