---
layout: page
mathjax: true
title: Linear Least Squares
permalink: /hw1/
---
**This article is written by [Chethan Parameshwara](http://analogicalnexus.github.io).**

Table of Contents:

## Introduction

This home work is designed to test your understanding of Math tutorial discussed in this \href{https://cmsc426.github.io/math-tutorial/}{link}. The task is to fit the line to two dimensional data points using different linear least square techniques discussed in the tutorials:

- Line fitting using Linear Least Squares
- Outliers rejection using Regularization
- Outliers rejection using RANSAC

## What you need to do

The data is provided in the form of .mat file. The data has various noise level as shown in the Figure 1.

<div class="fig fighighlight">
  <img src="/assets/hw1/data.png" width="60%">
  <div class="figcaption">
    2D data points.
  </div>
  <div style="clear:both;"></div>
</div>

### Problem Statement 

- Write matlab code to visualize geometric interpretation of eigenvalues/covariance matrix as discussed in this \href{http://www.visiondummy.com/2014/04/geometric-interpretation-covariance-matrix/}{link} [200 points]  
- Decide the best outlier rejection technique for each of these datasets and write matlab code to fit the line. Also, discuss why your choice of technique is optimal [300 points] 
