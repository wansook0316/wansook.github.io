---
layout: post
title: "04: Trial and Error"
category: "CV/Projects"
comments: true
tags: [project, "CV"]
feature-img: "assets/img/72.jpg"
feature-title:
use_math: true
summary: "프로젝트 진행 사항을 적고 시행착오를 적는다."
series: "Face Detection and Tracking with SSD Network"
---
# Tensorflow object detection api 사용

* [tensorflow models](https://github.com/tensorflow/models)

위의 레포를 기반으로 작업한다. 

## 가상환경 설정

먼저, python 3.7버전으로 가상환경을 만들자. object detection이 돌아가는 환경을 만들기 위함이다.

```bash
conda create -n myvenv python=3.7
```

다음으로 object detection 모델을 clone한다.

```bash
git clone https://github.com/tensorflow/models.git
```
마지막으로 필요한 기본 라이브러리를 설치한다.

```bash
pip install TensorFlow==1.15 lxml pillow matplotlib jupyter contextlib2 cython tf_slim
```



## protoc

* [protobuf documentation](https://developers.google.com/protocol-buffers)

protobuf는 데이터를 구조화하고, 이를 전송하고자 하는데 있어서 유연하고 효율적으로 작성하고 파싱하도록 지원하는 자동화 솔루션이다. json이나 xml을 생각하면 이해가 쉬운데, 사실 조금 다른 부분이 있다. protobuf는 데이터 구조를 `.proto`라는 파일로 작성하면, 이를 컴파일 해서 C++/C#/Python 등의 다양한 언어 코드 형태로 변환이 가능하다. 또한 변환된 언어 형태로 모듈까지 생성되어, 해당 언어로 데이터 구조를 전송하고 받아올 수 있도록 해준다.

C언어로 예를 들어 구조체를 정의하고, 이를 소켓을 통해 전송할 수 있게 Serialize(전송할 수 있도록 변환)하고, 변환된 데이터를 받은 후 Deserialize(파싱해서 다시 구조체의 형태로 저장) 하던 과정이 있다면, 이를 직접 코드로 다 작성해야 한다. 하지만 ProtoBuf는 데이터 구조만 정의하면 이 과정은 전부 지원해준다.


* [protocbuf 3.4v](https://github.com/protocolbuffers/protobuf/releases/tag/v3.4.0)  

window 10 환경에서 잘 작동하는 버전은 3.4v이다. 다양한 버전 테스트를 해봤지만 당장 제대로 돌아가는 버전을 사용하는 것이 맞다는 판단을 했다. 페이지 안에서 win32버전을 선택하자. 파일을 받았다면 압축을 풀고, `bin` 폴더 안에 있는 `protoc.exe`를 `models/research`안에 넣어주자. 그리고 cmd를 킨다.

```cmd
protoc object_detection/protos/*.proto --python_out=.
```

이 작업을 하면, 모두 컴파일이 되어 나오게 된다.

## Object detection setup

`/models/research/object_detection/packages/tf1` 에 있는 `setup.py`를 복사해서 object_detection 폴더로 이동한다. `tensorflow 1.15`버전을 사용할 것이기 때문에 예전 setup을 사용해야 한다.



```bash
python setup.py build
python setup.py install
pip install pycocotools-windows
```
여기서 윈도우 유저라면 pycocotools를 설치하면 에러가 날 것이다. 다른 운영체제 사용자는 기존대로 설치해도 괜찮다. window 사용자라면 꼭 뒤에 `-windows`를 추가해주자.



# Deepsort 사용

* [Deep SORT](https://github.com/nwojke/deep_sort)

위의 레포를 기반으로 작업한다.

## sklearn version switching

`linear_assignment_`은 해당 레포에서 사용했던 버전에서 더이상 작동하지 않는다.

`sklearn.utils.linear_assignment_`을 `from scipy.optimize import linear_sum_assignment as linear_assignment` 으로 변경하거나, sklearn version을 0.22.2 버전으로 변경하자.

```
pip install scikit-learn==0.22.2
```





## Demo


먼저 tracking 결과를 간단히 확인하고, result file을 만들기 위해서는 아래의 커맨드를 입력한다. 이 때, mot test 폴더에 있는 각각의 sequence folder의 이름과 output file의 이름을 같게 해주어야 한다. 그래야 나중에 tracking file을 기반으로 동영상을 추출할 수 있다.

```bash
python deep_sort_app.py \
    --sequence_dir=./MOT16/test/MOT16-06 \
    --detection_file=./resources/detections/MOT16_POI_test/MOT16-06.npy \
    --min_confidence=0.3 \
    --nn_budget=100 \
    --display=True \
    --output_file=./output/MOT16-06.txt
```

tracking이 잘 되었다면, 비디오를 생성하자.

```bash
python generate_videos.py \
    --mot_dir=./MOT16/test \
    --result_dir=./output \
    --output_dir=./output_videos
```


## 문제점

해당 repo의 소스코드를 뜯어본 결과 문제점들을 확인할 수 있었다.


1. Deepsort를 작동 시키기 위해서는 detection model이 필요하다.
2. tracking을 진행할 video가 frame 단위로 존재해야 한다.
3. 본격적인 tracking을 진행하기 전에, detection이 된 결과를 기반으로 각각의 물체에 대한 appearence feature를 만들어 두어야 한다.
   * 이게 정말 실시간인가 하는 의문이 든다.
   * appearence feature를 만들기 위해 feature extractor를 학습해야 한다.


최종적으로 실시간으로 작동하는 tracking 모델을 만드는 것이 목적이지만, 당장은 face detector와 deepsort를 연결하여 동작하는지를 확인해야 할 듯하다. 


# Cosine-metric-learning

Deepsort를 사용하기 위해서는 appearence metric을 사용해야 한다. 그러기 위해서는 원하는 이미지에 대해서 feature extraction을 하기 위한 모델을 훈련해야 한다. 

[cosine-metric-learning](https://github.com/nwojke/cosine_metric_learning)  

위의 레포를 기반으로 훈련할 수 있다. 다만 사용하는 dataset이 달라 변환하는 과정을 거쳐야 할 것으로 보인다.


# 실행 계획
1. face detection pretrained model 테스트하기
2. Deepsort cosine-metric-learning 테스트하기
   1. Dataset을 WIDER-face dataset으로 변경후 학습
   2. gpu 학습 설정
   3. tensorboard 사용
3. Trained model Deepsort repo로 옮기기
4. detection output을 deepsort detection result와 양식을 맞춘다.
5. tracking result 생성
   * inference time per frame 계산 후 확인
6. tracking video 생성



## Face Detection Pretrained Model
[Tensorflow Face Detector](https://github.com/yeephycho/tensorflow-face-detection)  
해당 모델을 사용하려 했으나, 다양한 input에 대해 inference를 해본 결과, 생각보다 물체를 많이 못잡는다는 점을 파악했다. MTCNN을 사용하려 했지만, inference 속도가 너무 나오지 않아서 사용하는 것을 포기했다.

<img width="892" alt="KakaoTalk_Photo_2021-03-30-12-47-44" src="https://user-images.githubusercontent.com/37871541/112931052-59847500-9156-11eb-8e57-a7b0d4d3d91e.png">{: .center-small}
<img width="892" alt="KakaoTalk_Photo_2021-03-30-12-47-39" src="https://user-images.githubusercontent.com/37871541/112931058-5ee1bf80-9156-11eb-88fa-a37235907eaa.png">{: .center-small}
<img width="1086" alt="KakaoTalk_Photo_2021-03-30-12-47-29" src="https://user-images.githubusercontent.com/37871541/112931061-6012ec80-9156-11eb-955c-518bb4a5356b.png">{: .center-small}

ssd_mobile_net으로, 속도에 주안점을 둔 모델이라 이런 성능이 나온 것으로 보인다. 다른 모델로 변경할 수도 있지만 당장은 이 정도의 output을 가지고 Deepsort와 연동하는 방법을 고민하기로 했다.




# Reference
[How to Install TensorFlow Object Detection in 2020 (Webcam and Images!)](https://www.youtube.com/watch?v=usR2LQuxhL4&t=786s)