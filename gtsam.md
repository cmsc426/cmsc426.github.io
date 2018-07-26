---
layout: page
mathjax: true
title: Structure from Motion
permalink: /gtsam/
---
**This article is written by [Nitin J. Sanket](http://nitinjsanket.github.io).**

Table of Contents:




## Introduction
The SfM pipeline we talked about before relies on an optimization framework to do the bundle adjustment and you would've also observed that we also used `fminunc` or `lsqnonlin` for solving non-linear least squares in traingulation and PnP. This is not very efficient and there has to be a better way right? Guess what, there is! In 2012, Prof. Frank Dellaert published a hallmark paper called [GTSAM](https://smartech.gatech.edu/handle/1853/45226) for solving such problems which are commonly classified as **Pose Graph Optimization** and uses the concept of **Factor Graphs**. This method has been improved over the years and has periodically improved it's optimization methods with the latest literature. Though there are faster pose graph optimization frameworks like [**g2o**](https://github.com/RainerKuemmerle/g2o) or [**SLAM++**](https://sourceforge.net/p/slam-plus-plus/wiki/Home/), GTSAM by far is one of the easiest frameworks to setup, use and understand and hence will be the our choice to solve this project. 

Let us consider a toy example to understand how one would solve SfM/SLAM in GTSAM. For the purpose of brevity, I am assuming that you have followed the setup insturctions [here](https://borg.cc.gatech.edu/download.html) and setup GTSAM 3.2.1 on your computer with MATLAB compatibility. For any issues or help regarding the setup feel free to contact the TAs. Now, let's get back to the problem in hand. The problem is defined as follows. Our robot lives in a 2D world with certain number of unique landmarks  \\(N\\). **The origin in the world and the scale is arbitrary**, i.e., any point in the map can be chosen as the origin. A common choice is the **start of service** or the pose (position and orientation) of the robot at the beginning of the algorithm is chosen as the origin. The scale being arbitrary just means that all the distances are measured to some **relative scale**, i.e., metric scale is unknown. We only know that a landmark is twice as far as the other landmark and this could metrically mean that one landmark is 2m away or 2cm away, the information about this is not known. This is the case when we have only one camera. However, if a distance sensor like a SONAR or a LIDAR is used we would know the metric scale. Note that this doesn't change anything in the algorithm or the framework but merely changes the units in the computation. 

Now, let us say that each landmark is uniqely numbered so that we can distinguish between them. Let each landmark \\(l_k\\) be represented by am \\(\mathbb{R}^2\\) vector which contains the \\(x\\) and \\(y\\) coordinate and is denoted by \\( l_k = \begin{bmatrix} \begin{bmatrix} l_{k,x} & \_{k,y}\end{bmatrix}^T\\)
