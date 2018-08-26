---
layout: page
mathjax: true
title: Rotobrush
permalink: /rotobrush/
---

This article is written by <a href="">Chahat Deep Singh</a> 

Table of Content:

- [Introduction](#intro)
- [Overview](#overview)
- [](#)




<a href="#intro"></a>
## Introduction

In this project, we will learn segmenting objects in a video sequence. Given a <i> good</i> boundary detection in the initial frame of a video, the object can be tracked and segmented out in the remaining sequence. It is much easier to segment the rigid objects in the scene using traditional tracking algorithms but the same can't be said for deformable objects like the one you can see in the Fig. 1. 

<div class="fig figcenter fighighlight">
<img src="/assets/rotobrush/demo.gif" width="100%">
<div class="figcaption"> Fig. 1: Segmenting out non-rigid objects in a video sequence
</div>

In this article, we specifically will implement an algorithm called <a href="http://juew.org/projects/SnapCut/snapcut.htm"><i>Video SnapCut</i></a> (also known as <i>RotoBrush</i> in <i>Adobe After Effects</i>) by Bai et. al. To get a very good inituition, we would <b>highly recommend</b> watching this 5 min <a href="https://www.youtube.com/watch?v=XSXRcXrPyIM"> video </a> that describes the entire paper.


