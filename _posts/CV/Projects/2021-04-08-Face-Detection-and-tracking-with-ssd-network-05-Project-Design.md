---
layout: post
title: "05: Project Design"
category: "CV/Projects"
comments: true
tags: [project, "CV"]
feature-img: "assets/img/72.jpg"
feature-title:
use_math: true
summary: "시행착오 후 프로젝트 설계를 진행한다."
series: "Face Detection and Tracking with SSD Network"
---

# Feature Appearance Training

Deepsort repository에 있는 Cosine Similarity extractor를 학습하려 했으나, 내 Gpu에서 Session을 열지 못하여 계속해서 에러가 났다. 추가로 Cpu로 학습을 시도하며 디버깅을 했을 때, 코드가 학습하고 싶은 데이터셋에 너무 적합해 있어서 사용하기가 까다로웠다.

# Deepsort Debugging

대안을 찾기 위해 Deepsort 코드를 디버깅을 진행하여, 정확하게 Appearance Feature가 무엇인지 확인해 보았다. Apperance Feature는 특정 이미지에서 보행자를 탐지했을 때, 그 탐지한 Patch image를 기반으로 Feature를 추출하는 것이었다. 저자들은 이 부분에 있어서 custom으로 학습을 진행하여 추출한 것이 전부였다. 그래서 Tensorflow에서 제공하는 Pretrain model에서 Head를 제거한 상태로 먼저 Feature Extraction을 진행하기로 했다.


# Face Detection Algorithm 성능 비교

논문에서 Detection 성능에 따라 추적 알고리즘의 성능이 달라진다고 명시되어 있었다. 지난 주 SSD를 사용해본 결과 성능이 좋지 않아 실제로 사용하기가 굉장히 어렵다는 생각을 했다. 아래는 Face Detection Algorithm 성능 비교 영상이다.

<iframe width="660" height="360" src="https://www.youtube.com/embed/GZ2p2hj2H5k" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

영상을 보면 처음에는 MTCNN과 SSD 모두 잘 탐색하는 것을 보인다. 하지만 SSD의 경우 측면의 경우 잘 탐지하지 못하고, 프레임마다 흔들림이 큰 모양새를 보인다. Deepsort알고리즘은 이전 프레임에서의 Detection 결과를 기반으로 다음 프레임을 예측하기 때문에 이러한 점은 알고리즘이 정상 작동하는데 무리를 준다. 속도면에서 SSD가 상당히 우위에 있으나, Tracking 성능을 유지하기 위해 MTCNN을 사용하는 것은 피할 수 없다고 판단했다.

# Project Design

![Untitled Diagram (1)](https://user-images.githubusercontent.com/37871541/113891923-7bd65c80-9800-11eb-8854-00033661b651.jpg){: .center}*Face Tracking Project Design*

1. Video -> images 변환
* Frame 번호 명시
* Image width, height
* image 수
2. MTCNN
* Bounding box
* frame number
3. Feature Extractor : `RESNET50`
* output vector size : 128
* output format : [`frame no`. , `object_id` , `bb_left` , `bb_top` , `bb_width` , `bb_height` , `score`, `X`, `Y`, `Z`]
* example : 1, 3, 280, 100, 200, 180, 0.98, -1, -1, -1
* .npy file format
4. Deepsort


# Environment Setting

* tensorflow 2.4
* numpy latest version
* sklearn 0.2.22
* python 3.7
* MTCNN


# File Structure
* application_util
  - image_viewer.py : opencv로 local에서 이미지를 보기 위한 코드
  - preprocessing.py : 이미지 전처리 (NMS 등) 코드
  - visualization.py : 시각화를 위한 코드가 작성
* resources
  - detections : frame별 detection과 feature가 존재하는 공간
  - networks : pretrained model(descriptor)를 저장하는 공간
  - output : 추적한 뒤의 txt file, video file이 저장되는 공간
  - sequences : video의 frame별 이미지가 저장되는 공간
  - video : 추적을 진행하고 싶은 비디오를 넣는 폴더
* tools
  - append_descriptor.py : MTCNN의 결과 txt파일에 feature 정보를 붙이기 위한 파일
  - freeze_model.py : descriptor를 만들기 위한 모델의 파라미터를 고정시키는 작업을 수행
  - generate_detections.py : MTCNN을 기반으로 image에 대해 detection을 수행
  - video_to_images.py : video input file을 frame별 image파일로 변경한다. 
* deep_sort
  - detection.py
  - iou_matching.py
  - kalman_filter.py
  - linear_assignment.py
  - nn_matching.py
  - track.py
  - tracker.py
- deep_sort_app.py : 실행하기 위한 코드
- generate_videos.py : tracking video를 만들기 위한 코드. resource/output에 저장된다.



# input video 설정

가장 구분이 잘되는 쉬운 영상에 대해 테스트하기 위해 다음의 영상을 첫번째로 선택하였다.

<iframe width="660" height="360" src="https://www.youtube.com/embed/g5v2Mst78uA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

화상 통화에서 같은 얼굴이 꾸준히 보이는 상황에서 잘 작동하는지 판단한다.

<iframe width="660" height="360" src="https://www.youtube.com/embed/sCy-VSbfQKw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

라이브 방송에서 tracking이 유지되는지 확인한다.

<iframe width="660" height="360" src="https://www.youtube.com/embed/rmve1k_f4Tk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

얼굴이 많이 나오면서, 가려짐이 많이 발생하는 영상을 찾았다.
<iframe width="660" height="360" src="https://www.youtube.com/embed/kfy2rn62yEc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>