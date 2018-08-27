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

<p style="background-color:#ddd; padding:5px">
<b>NOTE:</b> 
In order to develop a practical video cutout that can perform on complicated video with deformable objects, it is import to follow the two underlying principles:<br>
<b>1.</b> Multiple cues should be used for extracting the foreground such as <b>color, shape, motion and texture information</b>. Among these, shape plays a vital role for maintaining a temporally-coherent recognition.<br>
<b>2.</b> Multiple cues should be evaluated and integrated not just globally, but locally as well in order to maximize their discriminant powers. 
</p>


<a href=""></a>
## Segmenting with Localized Classifiers
### Local Windows
Once the initial mask is obtained, say $$L^t(x)$$ on a keyframe $$I_t$$, a set of overlapping windows $$W_q^t,...,W_n^t$$ along its contour $$C_t$$ are to be uniformly sampled as shown in Fig. 3.
<a style="background-color:#ddd; padding:5px;text-decoration:none">Assume single contour for now, multiple contours can be handled in the same way</a> The size and density of the windows can be chosen emperically, usually $$30\times30$$ to $$80\times80$$ pixels. 
Each window defines the application range of a local classifier, and the classifier will assign to every pixel
inside the window a foreground (object) probability, based on the local statistics it gathers. Neighboring windows overlap for about one-third of the window size.

<div class="fig figcenter fighighlight">
<img src="/assets/rotobrush/local-window.png" width="100%">
<div class="figcaption"> Fig. 3: Illustrating local classifiers. (a) Overlapping classifiers are initialized along the object boundary on frame t. (b) These classifiers are then propagated onto the next frame by motion estimation.
</div>
</div>

<p style="background-color:#ddd; padding:5px">Note: Since each local window moves along its own (averaged) motion vector, the distances between updated neighboring windows may slightly vary. This is one of the main reasons to
use overlapping windows in the keyframe, so that after propagation, the foreground boundary is still fully covered by the windows.</p>

The window-level <i>local classifiers</i> are composed of a color model (<a href="https://cmsc426.github.io/colorseg/#gmm" >GMM</a> to be precise), a shape model (the foreground mask  and a shape confidence mask). Confidence metrics are calculated for the color and shape models: for the color model this is a single value, and for the shape model it is a mask. When the color and shape models are integrated into a single mask, the confidence values are used to assign more weight to the more confident model. Fig. 4 illustrates the segmented foreground and combined probability for local classifiers.

<div class="fig figcenter fighighlight">
<img src="/assets/rotobrush/fig4.png" width="100%">
<div class="figcaption"> Fig. 4: (a) Each classifier contains a local color model and shape model, they are initialized on frame t and updated on frame t+1. Local classification results are then combined to generate a global foreground probability map. (e) The final segmented foreground object on frame t + 1.
</div>
</div>


### Initializing the Color Model
The purpose of the color model is to classify pixels as foreground $$\mathcal{F}$$ or background $$\mathcal{B}$$ based on their color. The assumption is that $$\mathcal{F}$$ and $$\mathcal{B}$$ pixels generally differ in color. The color model is based on GMM. One can use Matlab’s `fitgmdist` and `gmdistribution` function from Statistics and Machine Learning toolbox, but NOT using Computer Vision toolbox for GMMs is prohibited for this project.

In order to create the color model, two GMMs are build for $$\mathcal{F}$$ and $$\mathcal{B}$$ regions seperately.
<p style="background-color:#ddd; padding:5px"><b>Note:</b> Use <i>Lab</i> color space for the color models. To avoid possible sampling errors, we only use pixels whose spatial distance to the segmented boundary is larger than a threshold (5 pixels in our system) as the training data for the GMMs. </p>

Now, for a pixel $$x$$ in the window, its foreground probability generated from the color model is computed as:

$$p_c(x)=p_c(x|\mathcal{F})/(p_c(x|\mathcal{F})+p_c(x|\mathcal{B}))$$
where $$p_c(x|\mathcal{F})$$ and $$p_c(x|\mathcal{B})$$ are the corresponding probabilities computed from the two GMMs. <i>Refer to section 2.1 for more details.</i>


### Color Model Confidence
The local color model confidence $$f_c$$ is used to describe how separable the local foreground is against the local background using just the color model. Let $$L^t(x)$$ be the known segmentation label ($$\mathcal{F}=1$$ and $$\mathcal{B}=0) of pixel $$x$$ for the current frame, $$f_c$$ is computed as

$$f_c=1-\cfrac{\int_{W_k}|L^t(x)-p_c(x)|\cdot\omega_c(x)dx}{\int_{W_k}\omega_c(x)dx}$$

The weighing function $$\omega_c(x)$$ is computed as $$\omega_c(x)=exp(-d^2(x)\ /\ \sigma_c^2$$, where $$d(x)$$ is the spatial distance between $$x$$ and the foreground boundary, computed using the distance transform. $$\sigma_c$$ is fixed as half of the window size. $$\omega_c(x)$$ is higher when $$x$$ is closer to the boundary <i>i.e.</i> the color model is required to work well near the foreground boundary for accurate segmentation.

### Shape Model
The local shape model $$M_s$$ contains the existing segmentation mask $$L^t(x)$$ and a shape confidence mask computed as 

$$f_s(x)=1-exp(-d^2(x)\ /\ \sigma^2_s)$$



## Acknowledgement
This article is adapted from CMSC426 spring 2018 project.

## References
1. Bai, X., Wang, J., Simons, D. and Sapiro, G., 2009, July. Video snapcut: robust video object cutout using localized classifiers. In ACM Transactions on Graphics (ToG) (Vol. 28, No. 3, p. 70). ACM.
2. Wang, J. and Cohen, M.F., 2005, October. An iterative optimization approach for unified image segmentation and matting. In Computer Vision, 2005. ICCV 2005. Tenth IEEE International Conference on (Vol. 2, pp. 936-943). IEEE.
<hr>
