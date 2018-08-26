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
</div>

In this article, we specifically will implement an algorithm called <a href="http://juew.org/projects/SnapCut/snapcut.htm"><i>Video SnapCut</i></a> (also known as <i>RotoBrush</i> in <i>Adobe After Effects</i>) by Bai et. al. To get a very good inituition, we would <b>highly recommend</b> watching this 5 min <a href="https://www.youtube.com/watch?v=XSXRcXrPyIM"> video </a> that describes the entire paper.


<a href="System Overview"></a>
## Overview

As mentioned in the introduction section, we need to provide a foreground mask for the object that needs to be segmented. This can be done using `roipoly` from Image Processing Toolbox in MATLAB. The <i>SnapCut</i> can then sample a series of overlapping image windows along the object's boundary. For each such windows, a <i>local classifier</i> is created which is trained to classify whether a pixel belongs to foreground or background. The classifier is trained in such a way that it not only takes into account the color (like [2]) but shape as well. 

<div class="fig figcenter fighighlight">
<img src="/assets/rotobrush/initial.gif" width="100%">
<div class="figcaption"> Fig. 2: Creating the initial foreground mask
</div>
</div>

For the subsequent frames, the local classifiers are used for estimating an updated foreground mask. First, the object's movements between frames is estimated for reposition of the image windows. The goal is to have the windows stay in the same position on the object's boundary, or the most similar place possible. With the window positions updated, we then use the local classifiers to re-estimate the foreground mask for each window. These windows
overlap, so we merge their foreground masks together to obtain a final, full-object mask. Optionally, we can rerun the local classifiers and merging steps to refine the mask for this frame. Before moving on to the next frame, we re-train the local classifiers, so they remain accurate despite changes in background (and possibly foreground) appearance.

<a style="background-color:#ddd; padding:5px">
<b>NOTE:</b> 
In order to develop a practical video cutout that can perform on complicated video with deformable objects, it is import to follow the two underlying principles:
1. <b>Multiple cues should be used for extracting</b> the foreground such as <b>color, shape, motion and texture information</b>. Among these, shape plays a vital role for maintaining a temporally-coherent recognition.
2. Multiple cues should be evaluated and integrated not just globally, but locally as well in order to maximize their discriminant powers. 
</a>



## Acknowledgement
This article is adapted from CMSC426 spring 2018 project.

## References
1. Bai, X., Wang, J., Simons, D. and Sapiro, G., 2009, July. Video snapcut: robust video object cutout using localized classifiers. In ACM Transactions on Graphics (ToG) (Vol. 28, No. 3, p. 70). ACM.
2. Wang, J. and Cohen, M.F., 2005, October. An iterative optimization approach for unified image segmentation and matting. In Computer Vision, 2005. ICCV 2005. Tenth IEEE International Conference on (Vol. 2, pp. 936-943). IEEE.
<hr>
