---
layout: post
title: "01: Logistic Regression with a Neural Network mindset v6a"
category: "DS/DL"
comments: true
tags: ["test"]
feature-img: "assets/img/31.jpg"
feature-title: ""
use_math: true
series: "DL Specialization"
summary: "로지스틱 회귀를 기반으로 NN을 이해해보자."
---

# Logistic Regression with a Neural Network mindset

> Logistic regression을 통해 고양이를 분류해보자.

**Instructions:**

- Do not use loops (for/while) in your code, unless the instructions explicitly ask you to do so.

**You will learn to:**

- Build the general architecture of a learning algorithm, including:
  - Initializing parameters
  - Calculating the cost function and its gradient
  - Using an optimization algorithm (gradient descent)
- Gather all three functions above into a main model function, in the right order.

## Updates

This notebook has been updated over the past few months. The prior version was named "v5", and the current versionis now named '6a'

#### If you were working on a previous version:

- You can find your prior work by looking in the file directory for the older files (named by version name).
- To view the file directory, click on the "Coursera" icon in the top left corner of this notebook.
- Please copy your work from the older versions to the new version, in order to submit your work for grading.

#### List of Updates

- Forward propagation formula, indexing now starts at 1 instead of 0.
- Optimization function comment now says "print cost every 100 training iterations" instead of "examples".
- Fixed grammar in the comments.
- Y_prediction_test variable name is used consistently.
- Plot's axis label now says "iterations (hundred)" instead of "iterations".
- When testing the model, the test image is normalized by dividing by 255.

## 1 - Packages

First, let's run the cell below to import all the packages that you will need during this assignment.

- [numpy](www.numpy.org) is the fundamental package for scientific computing with Python.
- [h5py](http://www.h5py.org) is a common package to interact with a dataset that is stored on an H5 file.
- [matplotlib](http://matplotlib.org) is a famous library to plot graphs in Python.
- [PIL](http://www.pythonware.com/products/pil/) and [scipy](https://www.scipy.org/) are used here to test your model with your own picture at the end.

<div class="prompt input_prompt">
In&nbsp;[1]:
</div>

<div class="input_area" markdown="1">

```python
import numpy as np
import matplotlib.pyplot as plt
import h5py
import scipy
from PIL import Image
from scipy import ndimage
from lr_utils import load_dataset

%matplotlib inline
```

</div>

## 2 - Overview of the Problem set

**Problem Statement**:

- train에 있는 이미지 개수 `m_train`
- test에 있는 이미지 개수 `m_test`
- 각각의 이미지는 `num_px, num_px, 3` 이다. 마지막 3은 채널 수(RGB)를 의미한다.

You will build a simple image-recognition algorithm that can correctly classify pictures as cat or non-cat.

Let's get more familiar with the dataset. Load the data by running the following code.

<div class="prompt input_prompt">
In&nbsp;[2]:
</div>

<div class="input_area" markdown="1">

```python
# Loading the data (cat/non-cat)
# Load dataset을 할 경우 아래와 같이 5개의 값이 리턴 되도록 작성하였다.
train_set_x_orig, train_set_y, test_set_x_orig, test_set_y, classes = load_dataset()
```

</div>

We added "\_orig" at the end of image datasets (train and test) because we are going to preprocess them. After preprocessing, we will end up with train_set_x and test_set_x (the labels train_set_y and test_set_y don't need any preprocessing).

Each line of your train_set_x_orig and test_set_x_orig is an array representing an image. You can visualize an example by running the following code. Feel free also to change the `index` value and re-run to see other images.

<div class="prompt input_prompt">
In&nbsp;[3]:
</div>

<div class="input_area" markdown="1">

```python
# Example of a picture
# 해당 index에 해당하는 이미지를 볼 수 있다.
# 이 때, index에 해당하는 label 값(0, 1)을 출력하고, 이를 decoding 하여 의미를 추출하였다.
# squeeze는 n차원 배열을 1차원 배열로 내리는 효과가 있다.
index = 25
plt.imshow(train_set_x_orig[index])
print ("y = " + str(train_set_y[:, index]) + ", it's a '" + classes[np.squeeze(train_set_y[:, index])].decode("utf-8") +  "' picture.")
```

</div>

{: .output_stream}

```
y = [1], it's a 'cat' picture.

```

![png](/assets/img/Logistic_Regression_with_a_Neural_Network_mindset_v6a_files/Logistic_Regression_with_a_Neural_Network_mindset_v6a_7_1.png)

deep learning은 결국 선형 대수를 기반으로 한다. 이 선형 대수에서 계산을 수행하는데 가장 신경써야 하는 것은 벡터와 행렬의 차원이다. 실제로 이런 부분에서 에러가 많이 발생한다. 이 섹션에서는 행렬의 차원을 맞추는 연습을 진행해보자.

**Exercise:**
`train_set_x_orig`는 (`m_train`, `num_px`, `num_px`, 3) 의 모양을 가진 numpy 배열이다. 접근하고 싶다면 `m_train`같은 경우, `train_set_x_orig.shape[0]`로 접근 가능하다.

<div class="prompt input_prompt">
In&nbsp;[4]:
</div>

<div class="input_area" markdown="1">

```python
### START CODE HERE ### (≈ 3 lines of code)
m_train = train_set_y.shape[1]
m_test = test_set_y.shape[1]
num_px = train_set_x_orig.shape[1]
### END CODE HERE ###

print ("Number of training examples: m_train = " + str(m_train))
print ("Number of testing examples: m_test = " + str(m_test))
print ("Height/Width of each image: num_px = " + str(num_px))
print ("Each image is of size: (" + str(num_px) + ", " + str(num_px) + ", 3)")
print ("train_set_x shape: " + str(train_set_x_orig.shape))
print ("train_set_y shape: " + str(train_set_y.shape))
print ("test_set_x shape: " + str(test_set_x_orig.shape))
print ("test_set_y shape: " + str(test_set_y.shape))
```

</div>

{: .output_stream}

```
Number of training examples: m_train = 209
Number of testing examples: m_test = 50
Height/Width of each image: num_px = 64
Each image is of size: (64, 64, 3)
train_set_x shape: (209, 64, 64, 3)
train_set_y shape: (1, 209)
test_set_x shape: (50, 64, 64, 3)
test_set_y shape: (1, 50)

```

**Expected Output for m_train, m_test and num_px**:

<table style="width:55%">
  <tr>
    <td>**m_train**</td>
    <td> 209 </td> 
  </tr>
  
  <tr>
    <td>**m_test**</td>
    <td> 50 </td> 
  </tr>
  
  <tr>
    <td>**num_px**</td>
    <td> 64 </td> 
  </tr>
  
</table>

지금 한장의 사진은 (num_px, num_px, 3)와 같은 형태로 구성되어 있다. 하지만 우리는 이러한 형태로 input을 넣어주지 않을 것이다. 우리는 이를 열 벡터 형태로 바꾼 후에 관리할 생각이다. 즉, (num_px \* num_px \* 3, 1)와 같은 상태로 만들 것이다. 이럴 경우 우리는 이미지에 대한 열 벡터를 얻게 된다. 이 작업은 m\*train, m_test 모두에 적용한다. 결과적으로 우리는 하나의 이미지를 열 벡터의 형태로 만들고, 이 여러개를 붙인 형태를 갖고 있을 것이다. (num_px \* num_px \* 3, `열 벡터의 개수`)

**Exercise:** Reshape the training and test data sets so that images of size (num_px, num_px, 3) are flattened into single vectors of shape (num_px \* num_px \* 3, 1).

A trick when you want to flatten a matrix X of shape (a,b,c,d) to a matrix X_flatten of shape (b\*c\*d, a) is to use:

```python
X_flatten = X.reshape(X.shape[0], -1).T      # X.T is the transpose of X
```

<div class="prompt input_prompt">
In&nbsp;[5]:
</div>

<div class="input_area" markdown="1">

```python
# Reshape the training and test examples

### START CODE HERE ### (≈ 2 lines of code)
train_set_x_flatten = train_set_x_orig.reshape(train_set_x_orig.shape[0], -1).T
test_set_x_flatten = test_set_x_orig.reshape(test_set_x_orig.shape[0], -1).T
### END CODE HERE ###

print ("train_set_x_flatten shape: " + str(train_set_x_flatten.shape))
print ("train_set_y shape: " + str(train_set_y.shape))
print ("test_set_x_flatten shape: " + str(test_set_x_flatten.shape))
print ("test_set_y shape: " + str(test_set_y.shape))
print ("sanity check after reshaping: " + str(train_set_x_flatten[0:5,0]))
```

</div>

{: .output_stream}

```
train_set_x_flatten shape: (12288, 209)
train_set_y shape: (1, 209)
test_set_x_flatten shape: (12288, 50)
test_set_y shape: (1, 50)
sanity check after reshaping: [17 31 56 22 33]

```

**Expected Output**:

<table style="width:55%">
  <tr>
    <td>**train_set_x_flatten shape**</td>
    <td> (12288, 209)</td> 
  </tr>
  <tr>
    <td>**train_set_y shape**</td>
    <td>(1, 209)</td> 
  </tr>
  <tr>
    <td>**test_set_x_flatten shape**</td>
    <td>(12288, 50)</td> 
  </tr>
  <tr>
    <td>**test_set_y shape**</td>
    <td>(1, 50)</td> 
  </tr>
  <tr>
  <td>**sanity check after reshaping**</td>
  <td>[17 31 56 22 33]</td> 
  </tr>
</table>

각각의 이미지 채널은 0에서 255까지의 값을 갖고 있다. 머신 러닝에서 흔한 처리 방법은 데이터 셋을 중앙을 기준으로 표준화 $(X-m)/\sigma$ 하는 것이다. 하지만 이런 이미지 데이터에 대해서는 평균으로 정규화하기 보다, 255로 나누는 것이 보다 편리하다.

<!-- During the training of your model, you're going to multiply weights and add biases to some initial inputs in order to observe neuron activations. Then you backpropogate with the gradients to train the model. But, it is extremely important for each feature to have a similar range such that our gradients don't explode. You will see that more in detail later in the lectures. !-->

Let's standardize our dataset.

<div class="prompt input_prompt">
In&nbsp;[6]:
</div>

<div class="input_area" markdown="1">

```python
train_set_x = train_set_x_flatten/255.
test_set_x = test_set_x_flatten/255.
```

</div>

**What you need to remember:**
Common steps for pre-processing a new dataset are:

- 차원을 파악한다.
- 벡터화 한다.
- 표준화 한다.

## 3 - General Architecture of the learning algorithm

It's time to design a simple algorithm to distinguish cat images from non-cat images.

You will build a Logistic Regression, using a Neural Network mindset. The following Figure explains why **Logistic Regression is actually a very simple Neural Network!**]

<!--<img src="images/LogReg_kiank.png" style="width:650px;height:400px;">-->

<img src="https://user-images.githubusercontent.com/37871541/97973442-6ac89000-1e09-11eb-8536-c1b3d2293479.png" style="width:650px;height:400px;">{: .center}

**Mathematical expression of the algorithm**:

For one example $x^{(i)}$:
$$z^{(i)} = w^T x^{(i)} + b \tag{1}$$
$$\hat{y}^{(i)} = a^{(i)} = sigmoid(z^{(i)})\tag{2}$$
$$ \mathcal{L}(a^{(i)}, y^{(i)}) =  - y^{(i)}  \log(a^{(i)}) - (1-y^{(i)} )  \log(1-a^{(i)})\tag{3}$$

The cost is then computed by summing over all training examples:

$$ J = \frac{1}{m} \sum_{i=1}^m \mathcal{L}(a^{(i)}, y^{(i)})\tag{6}$$

**Key steps**:
In this exercise, you will carry out the following steps:

- 모델 파라미터를 초기화 한다.
- Cost를 최소로 하는 파라미터를 학습한다.
- 예측을 수행한다.
- 결과를 분석하고 끝맺는다.

## 4 - Building the parts of our algorithm

The main steps for building a Neural Network are:

1. 모델 구조를 정의한다.
2. 모델 파라미터를 초기화 한다.
3. 반복문을 수행한다.
   - 현재 손실을 계산한다.
   - 기울기를 계산한다.
   - 파라미터를 업데이트 한다.

이 작업을 수행하는 것을 한번에 통합한 뒤, 이를 `model()`이라고 자주 부르게 될 것이다.

### 4.1 - Helper functions

**Exercise**: `model()`을 만드는데 있어서 도와주는 함수들을 먼저 제작하자. `sigmoid()` 함수를 구현해라.

<div class="prompt input_prompt">
In&nbsp;[7]:
</div>

<div class="input_area" markdown="1">

```python
# GRADED FUNCTION: sigmoid

def sigmoid(z):
    """
    Compute the sigmoid of z

    Arguments:
    z -- A scalar or numpy array of any size.

    Return:
    s -- sigmoid(z)
    """

    ### START CODE HERE ### (≈ 1 line of code)
    s = 1/(1+np.exp(-z))
    ### END CODE HERE ###

    return s
```

</div>

<div class="prompt input_prompt">
In&nbsp;[8]:
</div>

<div class="input_area" markdown="1">

```python
print ("sigmoid([0, 2]) = " + str(sigmoid(np.array([0,2]))))
```

</div>

{: .output_stream}

```
sigmoid([0, 2]) = [ 0.5         0.88079708]

```

**Expected Output**:

<table style="width:55%">
  <tr>
    <td>**sigmoid([0, 2])**</td>
    <td> [ 0.5         0.88079708]</td> 
  </tr>
</table>

### 4.2 - Initializing parameters

**Exercise:** 파라미터 초기화를 구현해라. 0으로 초기화를 먼저 해보자.

<div class="prompt input_prompt">
In&nbsp;[9]:
</div>

<div class="input_area" markdown="1">

```python
# GRADED FUNCTION: initialize_with_zeros

def initialize_with_zeros(dim):
    """
    This function creates a vector of zeros of shape (dim, 1) for w and initializes b to 0.

    Argument:
    dim -- size of the w vector we want (or number of parameters in this case)

    Returns:
    w -- initialized vector of shape (dim, 1)
    b -- initialized scalar (corresponds to the bias)
    """

    ### START CODE HERE ### (≈ 1 line of code)
    w = np.zeros((dim, 1))
    b = 0
    ### END CODE HERE ###

    assert(w.shape == (dim, 1))
    assert(isinstance(b, float) or isinstance(b, int))

    return w, b
```

</div>

<div class="prompt input_prompt">
In&nbsp;[10]:
</div>

<div class="input_area" markdown="1">

```python
dim = 2
w, b = initialize_with_zeros(dim)
print ("w = " + str(w))
print ("b = " + str(b))
```

</div>

{: .output_stream}

```
w = [[ 0.]
 [ 0.]]
b = 0

```

**Expected Output**:

<table style="width:55%">
    <tr>
        <td>  ** w **  </td>
        <td> [[ 0.]
 [ 0.]] </td>
    </tr>
    <tr>
        <td>  ** b **  </td>
        <td> 0 </td>
    </tr>
</table>

For image inputs, w will be of shape (num_px $\times$ num_px $\times$ 3, 1).

### 4.3 - Forward and Backward propagation

Now that your parameters are initialized, you can do the "forward" and "backward" propagation steps for learning the parameters.

파라미터를 초기화 했으니 Forward, backward propagation을 구현해보자.

**Exercise:** Implement a function `propagate()` that computes the cost function and its gradient.

**Exercise:** 손실 함수와 이에 대한 기울기를 계산하는 `propagate()` 함수를 구현해보자.

**Hints**:

Forward Propagation:

- You get X
- You compute $A = \sigma(w^T X + b) = (a^{(1)}, a^{(2)}, ..., a^{(m-1)}, a^{(m)})$
- You calculate the cost function: $J = -\frac{1}{m}\sum_{i=1}^{m}y^{(i)}\log(a^{(i)})+(1-y^{(i)})\log(1-a^{(i)})$

Here are the two formulas you will be using:

$$ \frac{\partial J}{\partial w} = \frac{1}{m}X(A-Y)^T\tag{7}$$
$$ \frac{\partial J}{\partial b} = \frac{1}{m} \sum_{i=1}^m (a^{(i)}-y^{(i)})\tag{8}$$

<div class="prompt input_prompt">
In&nbsp;[11]:
</div>

<div class="input_area" markdown="1">

```python
# GRADED FUNCTION: propagate

def propagate(w, b, X, Y):
    """
    Implement the cost function and its gradient for the propagation explained above

    Arguments:
    w -- weights, a numpy array of size (num_px * num_px * 3, 1)
    b -- bias, a scalar
    X -- data of size (num_px * num_px * 3, number of examples)
    Y -- true "label" vector (containing 0 if non-cat, 1 if cat) of size (1, number of examples)

    Return:
    cost -- negative log-likelihood cost for logistic regression
    dw -- gradient of the loss with respect to w, thus same shape as w
    db -- gradient of the loss with respect to b, thus same shape as b

    Tips:
    - Write your code step by step for the propagation. np.log(), np.dot()
    """

    m = X.shape[1]

    # FORWARD PROPAGATION (FROM X TO COST)
    ### START CODE HERE ### (≈ 2 lines of code)
    A = sigmoid(np.dot(w.T,X)+b)           # (1,2)(2, 3) = (1, 3)                 # compute activation
    cost = -(1/m)*np.sum(Y*np.log(A) + (1-Y)*np.log(1-A), axis=1)                                 # compute cost
    ### END CODE HERE ###

    # BACKWARD PROPAGATION (TO FIND GRAD)
    ### START CODE HERE ### (≈ 2 lines of code)
    dw = (1/m)*np.dot(X,(A-Y).T)
    db = (1/m)*np.sum(A-Y, axis=1)
    ### END CODE HERE ###

    assert(dw.shape == w.shape)
    assert(db.dtype == float)
    cost = np.squeeze(cost)
    assert(cost.shape == ())

    grads = {"dw": dw,
             "db": db}

    return grads, cost
```

</div>

<div class="prompt input_prompt">
In&nbsp;[12]:
</div>

<div class="input_area" markdown="1">

```python
w, b, X, Y = np.array([[1.],[2.]]), 2., np.array([[1.,2.,-1.],[3.,4.,-3.2]]), np.array([[1,0,1]])
grads, cost = propagate(w, b, X, Y)
print ("dw = " + str(grads["dw"]))
print ("db = " + str(grads["db"]))
print ("cost = " + str(cost))
```

</div>

{: .output_stream}

```
dw = [[ 0.99845601]
 [ 2.39507239]]
db = [ 0.00145558]
cost = 5.801545319394553

```

**Expected Output**:

<table style="width:50%">
    <tr>
        <td>  ** dw **  </td>
      <td> [[ 0.99845601]
     [ 2.39507239]]</td>
    </tr>
    <tr>
        <td>  ** db **  </td>
        <td> 0.00145557813678 </td>
    </tr>
    <tr>
        <td>  ** cost **  </td>
        <td> 5.801545319394553 </td>
    </tr>

</table>

### 4.4 - Optimization

- 파라미터를 초기화 했다.
- 또한 손실함수와 기울기를 계산할 수 있다.
- 이제, 파라미터를 업데이트 해보자.

**Exercise:** 최적화 함수를 적는다. 목표는 가중치 손실 함수 $J$를 최소화 하는 $w$와 $b$를 학습하는 것이다. 파라미터를 $\theta$ 라고 했을 때, 업데이트 규칙은 $ \theta = \theta - \alpha \text{ } d\theta$이다. $\alpha$는 학습률이다.

<div class="prompt input_prompt">
In&nbsp;[13]:
</div>

<div class="input_area" markdown="1">

```python
# GRADED FUNCTION: optimize

def optimize(w, b, X, Y, num_iterations, learning_rate, print_cost = False):
    """
    This function optimizes w and b by running a gradient descent algorithm

    Arguments:
    w -- weights, a numpy array of size (num_px * num_px * 3, 1)
    b -- bias, a scalar
    X -- data of shape (num_px * num_px * 3, number of examples)
    Y -- true "label" vector (containing 0 if non-cat, 1 if cat), of shape (1, number of examples)
    num_iterations -- number of iterations of the optimization loop
    learning_rate -- learning rate of the gradient descent update rule
    print_cost -- True to print the loss every 100 steps

    Returns:
    params -- dictionary containing the weights w and bias b
    grads -- dictionary containing the gradients of the weights and bias with respect to the cost function
    costs -- list of all the costs computed during the optimization, this will be used to plot the learning curve.

    Tips:
    You basically need to write down two steps and iterate through them:
        1) Calculate the cost and the gradient for the current parameters. Use propagate().
        2) Update the parameters using gradient descent rule for w and b.
    """

    costs = []

    for i in range(num_iterations):


        # Cost and gradient calculation (≈ 1-4 lines of code)
        ### START CODE HERE ###
        grads, cost = propagate(w, b, X, Y)
        ### END CODE HERE ###

        # Retrieve derivatives from grads
        dw = grads["dw"]
        db = grads["db"]

        # update rule (≈ 2 lines of code)
        ### START CODE HERE ###
        w = w - learning_rate*dw
        b = b - learning_rate*db
        ### END CODE HERE ###

        # Record the costs
        if i % 100 == 0:
            costs.append(cost)

        # Print the cost every 100 training iterations
        if print_cost and i % 100 == 0:
            print ("Cost after iteration %i: %f" %(i, cost))

    params = {"w": w,
              "b": b}

    grads = {"dw": dw,
             "db": db}

    return params, grads, costs
```

</div>

<div class="prompt input_prompt">
In&nbsp;[14]:
</div>

<div class="input_area" markdown="1">

```python
params, grads, costs = optimize(w, b, X, Y, num_iterations= 100, learning_rate = 0.009, print_cost = False)

print ("w = " + str(params["w"]))
print ("b = " + str(params["b"]))
print ("dw = " + str(grads["dw"]))
print ("db = " + str(grads["db"]))
```

</div>

{: .output_stream}

```
w = [[ 0.19033591]
 [ 0.12259159]]
b = [ 1.92535983]
dw = [[ 0.67752042]
 [ 1.41625495]]
db = [ 0.2191945]

```

**Expected Output**:

<table style="width:55%">
    <tr>
       <td> **w** </td>
       <td>[[ 0.19033591]
 [ 0.12259159]] </td>
    </tr>
    
    <tr>
       <td> **b** </td>
       <td> 1.92535983008 </td>
    </tr>
    <tr>
       <td> **dw** </td>
       <td> [[ 0.67752042]
 [ 1.41625495]] </td>
    </tr>
    <tr>
       <td> **db** </td>
       <td> 0.219194504541 </td>
    </tr>

</table>

**Exercise:** 이제 학습을 마쳤으니 학습된 파라미터를 가지고 예측하는 것이 남아있다. `predict()` 함수를 구현해보자. 다음의 두단계가 필요하다.

1. Calculate $\hat{Y} = A = \sigma(w^T X + b)$

2. Convert the entries of a into 0 (if activation <= 0.5) or 1 (if activation > 0.5), stores the predictions in a vector `Y_prediction`. If you wish, you can use an `if`/`else` statement in a `for` loop (though there is also a way to vectorize this).

<div class="prompt input_prompt">
In&nbsp;[15]:
</div>

<div class="input_area" markdown="1">

```python
# GRADED FUNCTION: predict

def predict(w, b, X):
    '''
    Predict whether the label is 0 or 1 using learned logistic regression parameters (w, b)

    Arguments:
    w -- weights, a numpy array of size (num_px * num_px * 3, 1)
    b -- bias, a scalar
    X -- data of size (num_px * num_px * 3, number of examples)

    Returns:
    Y_prediction -- a numpy array (vector) containing all predictions (0/1) for the examples in X
    '''

    m = X.shape[1]
    Y_prediction = np.zeros((1,m))
    w = w.reshape(X.shape[0], 1)

    # Compute vector "A" predicting the probabilities of a cat being present in the picture
    ### START CODE HERE ### (≈ 1 line of code)
    A = sigmoid(np.dot(w.T, X) + b)
    ### END CODE HERE ###

    for i in range(A.shape[1]):

        # Convert probabilities A[0,i] to actual predictions p[0,i]
        ### START CODE HERE ### (≈ 4 lines of code)
        if A[0, i] > 0.5:
            Y_prediction[0, i] = 1
        else:
            A[0, i] = 0
            ### END CODE HERE ###

    assert(Y_prediction.shape == (1, m))

    return Y_prediction
```

</div>

<div class="prompt input_prompt">
In&nbsp;[16]:
</div>

<div class="input_area" markdown="1">

```python
w = np.array([[0.1124579],[0.23106775]])
b = -0.3
X = np.array([[1.,-1.1,-3.2],[1.2,2.,0.1]])
print ("predictions = " + str(predict(w, b, X)))
```

</div>

{: .output_stream}

```
predictions = [[ 1.  1.  0.]]

```

**Expected Output**:

<table style="width:30%">
    <tr>
         <td>
             **predictions**
         </td>
          <td>
            [[ 1.  1.  0.]]
         </td>  
   </tr>

</table>

**What to remember:**
You've implemented several functions that:

- Initialize (w,b)
- Optimize the loss iteratively to learn parameters (w,b):
  - computing the cost and its gradient
  - updating the parameters using gradient descent
- Use the learned (w,b) to predict the labels for a given set of examples

## 5 - Merge all functions into a model

이제 남은 것은 지금까지 만든 함수들을 가지고 전체적인 모델을 구성하는 일이 남았다.

**Exercise:** Implement the model function. Use the following notation: - Y_prediction_test for your predictions on the test set - Y_prediction_train for your predictions on the train set - w, costs, grads for the outputs of optimize()

<div class="prompt input_prompt">
In&nbsp;[17]:
</div>

<div class="input_area" markdown="1">

```python
# GRADED FUNCTION: model

def model(X_train, Y_train, X_test, Y_test, num_iterations = 2000, learning_rate = 0.5, print_cost = False):
    """
    Builds the logistic regression model by calling the function you've implemented previously

    Arguments:
    X_train -- training set represented by a numpy array of shape (num_px * num_px * 3, m_train)
    Y_train -- training labels represented by a numpy array (vector) of shape (1, m_train)
    X_test -- test set represented by a numpy array of shape (num_px * num_px * 3, m_test)
    Y_test -- test labels represented by a numpy array (vector) of shape (1, m_test)
    num_iterations -- hyperparameter representing the number of iterations to optimize the parameters
    learning_rate -- hyperparameter representing the learning rate used in the update rule of optimize()
    print_cost -- Set to true to print the cost every 100 iterations

    Returns:
    d -- dictionary containing information about the model.
    """

    ### START CODE HERE ###
    n_feature = X_train.shape[0]
    m_train = X_train.shape[1]   # Y_train.shape[1]과 같을 것

    n_label = Y_train.shape[0]


    # initialize parameters with zeros (≈ 1 line of code)
    w, b = np.zeros((n_feature, n_label)), np.zeros((n_label))

    # Gradient descent (≈ 1 line of code)
    parameters, grads, costs = optimize(w, b, X_train, Y_train, num_iterations, learning_rate, print_cost)

    # Retrieve parameters w and b from dictionary "parameters"
    w = parameters["w"]
    b = parameters["b"]

    # Predict test/train set examples (≈ 2 lines of code)
    Y_prediction_test = predict(w, b, X_test)
    Y_prediction_train = predict(w, b, X_train)

    ### END CODE HERE ###

    # Print train/test Errors
    print("train accuracy: {} %".format(100 - np.mean(np.abs(Y_prediction_train - Y_train)) * 100))
    print("test accuracy: {} %".format(100 - np.mean(np.abs(Y_prediction_test - Y_test)) * 100))


    d = {"costs": costs,
         "Y_prediction_test": Y_prediction_test,
         "Y_prediction_train" : Y_prediction_train,
         "w" : w,
         "b" : b,
         "learning_rate" : learning_rate,
         "num_iterations": num_iterations}

    return d
```

</div>

Run the following cell to train your model.

<div class="prompt input_prompt">
In&nbsp;[18]:
</div>

<div class="input_area" markdown="1">

```python
d = model(train_set_x, train_set_y, test_set_x, test_set_y, num_iterations = 2000, learning_rate = 0.005, print_cost = True)
```

</div>

{: .output_stream}

```
Cost after iteration 0: 0.693147
Cost after iteration 100: 0.584508
Cost after iteration 200: 0.466949
Cost after iteration 300: 0.376007
Cost after iteration 400: 0.331463
Cost after iteration 500: 0.303273
Cost after iteration 600: 0.279880
Cost after iteration 700: 0.260042
Cost after iteration 800: 0.242941
Cost after iteration 900: 0.228004
Cost after iteration 1000: 0.214820
Cost after iteration 1100: 0.203078
Cost after iteration 1200: 0.192544
Cost after iteration 1300: 0.183033
Cost after iteration 1400: 0.174399
Cost after iteration 1500: 0.166521
Cost after iteration 1600: 0.159305
Cost after iteration 1700: 0.152667
Cost after iteration 1800: 0.146542
Cost after iteration 1900: 0.140872
train accuracy: 99.04306220095694 %
test accuracy: 70.0 %

```

**Expected Output**:

<table style="width:40%">

    <tr>
        <td> **Cost after iteration 0 **  </td>
        <td> 0.693147 </td>
    </tr>
      <tr>
        <td> <center> $\vdots$ </center> </td>
        <td> <center> $\vdots$ </center> </td>
    </tr>
    <tr>
        <td> **Train Accuracy**  </td>
        <td> 99.04306220095694 % </td>
    </tr>

    <tr>
        <td>**Test Accuracy** </td>
        <td> 70.0 % </td>
    </tr>

</table>

**Comment**: Training accuracy is close to 100%. This is a good sanity check: your model is working and has high enough capacity to fit the training data. Test accuracy is 68%. It is actually not bad for this simple model, given the small dataset we used and that logistic regression is a linear classifier. But no worries, you'll build an even better classifier next week!

Also, you see that the model is clearly overfitting the training data. Later in this specialization you will learn how to reduce overfitting, for example by using regularization. Using the code below (and changing the `index` variable) you can look at predictions on pictures of the test set.

<div class="prompt input_prompt">
In&nbsp;[19]:
</div>

<div class="input_area" markdown="1">

```python
# Example of a picture that was wrongly classified.
index = 1
plt.imshow(test_set_x[:,index].reshape((num_px, num_px, 3)))
print ("y = " + str(test_set_y[0,index]) + ", you predicted that it is a \"" + classes[d["Y_prediction_test"][0,index]].decode("utf-8") +  "\" picture.")
```

</div>

{: .output_stream}

```
y = 1, you predicted that it is a "cat" picture.

```

![png](/assets/img/Logistic_Regression_with_a_Neural_Network_mindset_v6a_files/Logistic_Regression_with_a_Neural_Network_mindset_v6a_45_1.png)

Let's also plot the cost function and the gradients.

<div class="prompt input_prompt">
In&nbsp;[20]:
</div>

<div class="input_area" markdown="1">

```python
# Plot learning curve (with costs)
costs = np.squeeze(d['costs'])
plt.plot(costs)
plt.ylabel('cost')
plt.xlabel('iterations (per hundreds)')
plt.title("Learning rate =" + str(d["learning_rate"]))
plt.show()
```

</div>

![png](/assets/img/Logistic_Regression_with_a_Neural_Network_mindset_v6a_files/Logistic_Regression_with_a_Neural_Network_mindset_v6a_47_0.png)

**Interpretation**:
반복을 진행할수록 Cost가 줄어들고 있다. 이는, 곧 파라미터가 학습되었다는 것을 보여준다. 하지만 training set에 대해 모델을 더 훈련할 수로 있다는 것이 보인다. iteration을 더 진행해보면 train accuracy는 낮아지나 test accuracy는 증가함을 볼 수 있다. 이러한 상황을 overfitting이라 한다.

## 6 - Further analysis (optional/ungraded exercise)

Congratulations on building your first image classification model. Let's analyze it further, and examine possible choices for the learning rate $\alpha$.

#### Choice of learning rate

**Reminder**:
그레디언트 감소 방법이 잘 적용되기 위해서는 학습률을 잘 골라야 한다. 학습률 $\alpha$는 얼마나 빠르게 파라미터를 업데이트 할지를 결정한다. 만약에 너무 이 값이 크게 되면 `overshooting`이 발생한다. 만약 너무 작다면 함수를 적합하기 위해 너무 많은 iteration이 요구된다. 그래서 이 값을 잘 정하는 것이 중요하다. 이런 학습률의 변화에 따른 모델의 학습 곡선을 비교해보자.

<div class="prompt input_prompt">
In&nbsp;[21]:
</div>

<div class="input_area" markdown="1">

```python
learning_rates = [0.01, 0.001, 0.0001]
models = {}
for i in learning_rates:
    print ("learning rate is: " + str(i))
    models[str(i)] = model(train_set_x, train_set_y, test_set_x, test_set_y, num_iterations = 1500, learning_rate = i, print_cost = False)
    print ('\n' + "-------------------------------------------------------" + '\n')

for i in learning_rates:
    plt.plot(np.squeeze(models[str(i)]["costs"]), label= str(models[str(i)]["learning_rate"]))

plt.ylabel('cost')
plt.xlabel('iterations (hundreds)')

legend = plt.legend(loc='upper center', shadow=True)
frame = legend.get_frame()
frame.set_facecolor('0.90')
plt.show()
```

</div>

{: .output_stream}

```
learning rate is: 0.01
train accuracy: 99.52153110047847 %
test accuracy: 68.0 %

-------------------------------------------------------

learning rate is: 0.001
train accuracy: 88.99521531100478 %
test accuracy: 64.0 %

-------------------------------------------------------

learning rate is: 0.0001
train accuracy: 68.42105263157895 %
test accuracy: 36.0 %

-------------------------------------------------------


```

![png](/assets/img/Logistic_Regression_with_a_Neural_Network_mindset_v6a_files/Logistic_Regression_with_a_Neural_Network_mindset_v6a_51_1.png)

**Interpretation**:

- 학습률에 따라 다른 cost와 다른 예측 결과를 보여준다.
- 너무 큰 경우 진동하는 경향을 보인다. 즉 발산한다.
- 너무 작을 경우 같은 iteration에 대해 좋은 결과를 보여주지 못한다.
- train cost가 작아지는 것이 test accuracy 와 직결적인 영향을 주지 못한다. 즉, overfitting이 발생할 수 있다.
- 결과적으로 우리는 아래의 방법을 따르는 것이 좋다.
  - 좋은 learning rate를 고르자.
  - 만약 overfitting이 발생했다면 이를 줄일 수 있는 방법을 사용하자.

## 7 - Test with your own image (optional/ungraded exercise)

Congratulations on finishing this assignment. You can use your own image and see the output of your model. To do that: 1. Click on "File" in the upper bar of this notebook, then click "Open" to go on your Coursera Hub. 2. Add your image to this Jupyter Notebook's directory, in the "images" folder 3. Change your image's name in the following code 4. Run the code and check if the algorithm is right (1 = cat, 0 = non-cat)!

<div class="prompt input_prompt">
In&nbsp;[22]:
</div>

<div class="input_area" markdown="1">

```python
## START CODE HERE ## (PUT YOUR IMAGE NAME)
my_image = "my_image.jpg"   # change this to the name of your image file
## END CODE HERE ##

# We preprocess the image to fit your algorithm.
fname = "images/" + my_image
image = np.array(ndimage.imread(fname, flatten=False))
image = image/255.
my_image = scipy.misc.imresize(image, size=(num_px,num_px)).reshape((1, num_px*num_px*3)).T
my_predicted_image = predict(d["w"], d["b"], my_image)

plt.imshow(image)
print("y = " + str(np.squeeze(my_predicted_image)) + ", your algorithm predicts a \"" + classes[int(np.squeeze(my_predicted_image)),].decode("utf-8") +  "\" picture.")
```

</div>

{: .output_stream}

```
y = 0.0, your algorithm predicts a "non-cat" picture.

```

![png](/assets/img/Logistic_Regression_with_a_Neural_Network_mindset_v6a_files/Logistic_Regression_with_a_Neural_Network_mindset_v6a_54_1.png)

**What to remember from this assignment:**

1. 데이터 전처리(벡터화를 해본 것)은 중요하다.
2. initialize, propagate, optimise와 같은 함수를 제작하고 model을 만들었다.
3. learning rate와 같은 hyperparameter를 조정하는 것은 알고리즘에 있어 큰 차이를 가져온다.

Finally, if you'd like, we invite you to try different things on this Notebook. Make sure you submit before trying anything. Once you submit, things you can play with include: - Play with the learning rate and the number of iterations - Try different initialization methods and compare the results - Test other preprocessings (center the data, or divide each row by its standard deviation)

Bibliography:

- http://www.wildml.com/2015/09/implementing-a-neural-network-from-scratch/
- https://stats.stackexchange.com/questions/211436/why-do-we-normalize-images-by-subtracting-the-datasets-image-mean-and-not-the-c
