---
layout: page
mathjax: true
title: Linear Least Squares
permalink: /hw1/
---
**This article is written by [Chethan Parameshwara](http://analogicalnexus.github.io).**

Table of Contents:

## Introduction

This home work is designed to test your understanding of Math tutorial discussed in this [link](https://cmsc426.github.io/math-tutorial/). The task is to fit the line to two dimensional data points using different linear least square techniques discussed in the tutorials:

- Line fitting using Linear Least Squares
- Outliers rejection using Regularization
- Outliers rejection using RANSAC

## What you need to do

The data is provided in the form of .mat file ( click [here](https://github.com/cmsc426/cmsc426.github.io/blob/master/assets/hw1/hw1_data.zip) to download). The data has various noise level as shown in the Figure 1.

<div class="fig fighighlight">
  <img src="/assets/hw1/data.jpg" width="100%">
  <div class="figcaption">
    2D data points.
  </div>
  <div style="clear:both;"></div>
</div>

### Problem Statement 

- Write matlab code to visualize geometric interpretation of eigenvalues/covariance matrix as discussed in this [link](http://www.visiondummy.com/2014/04/geometric-interpretation-covariance-matrix/) [40 points]  
- Decide the best outlier rejection technique for each of these datasets and write matlab code to fit the line. Also, discuss why your choice of technique is optimal [60 points] 

## Submission Guidelines

<b> If your submission does not comply with the following guidelines, you'll be given ZERO credit </b>

### File tree and naming

Your submission on Canvas must be a zip file, following the naming convention <b>``YourDirectoryID\_hw1.zip"<\b>.  For example, xyz123\_hw1.zip.  The file <b>must have the following directory structure<\b>, based on the starter files

YourDirectoryID\_hw1.zip.
 - data/. 
 - plot_eigen.m.
 - least_square.m.
 - report.pdf


### Report
For each section of the homework, explain briefly what you did, and describe any interesting problems you encountered and/or solutions you implemented.  You must include the following details in your writeup:

- Your understanding of eigenvectors and eigenvalues
- Your choice of outlier rejection technique for each dataset
- Limitation of each outliers rejection technique


As usual, your report must be full English sentences,<b>not</b> commented code. There is a word limit of 750 words and no minimum length requirement


## Collaboration Policy
You are <b>not allowed</b> to discuss the ideas with other people. The code should be your own, and should be the result of you exercising your own understanding of it. If you reference anyone else's code in writing your project, you must properly cite it in your code (in comments) and your writeup.  For the full honor code refer to the CMSC426 Fall 2018 website
