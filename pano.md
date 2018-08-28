---
layout: page
mathjax: true
title: Panorama Stitching
permalink: /pano/
---

Table of Contents:

- [Introduction](#intro)
- [Adaptive Non-Maximal Suppression](#anms)
- [Feature Descriptor](#feat-descriptor)
- [Feature Matching](#feat-matching)
- [RANSAC to estimate Robust Homography](#homography)
- [Cylinderical Projection](#cyl-projection)
- [Blending Images](#blending)
- [Discussion](#discussion)




<a name='intro'></a>
## 1. Introduction

Now that we have learned about a few building blocks of computer vision from [link: Pano Part 1], let us try to do something cool with it! The purpose of this project is to stitch two or more images in order to create one seamless panorama image. Each image should have few repeated local features ($$\sim 30-50\%$$ or more, emperically chosen). In this project, you need to capture multiple such images. Note that your camera motion should be limited to purely translational or purely rotational around the camera center. The following method of stitching images should work for most image sets but you'll need to be creative for working on harder image sets. 


<div class="fig figcenter fighighlight">
  <img src="/assets/pano/delicate-arch-set.jpg" width="100%">
  <div class="figcaption"> Fig. 1: Image Set for Panorama Stitching: Delicate Arch (at Arches National Park, Utah) </div><br>
  <img src="/assets/pano/delicate-arch-pano.jpg" width="100%">
  <div class="figcaption"> Fig. 2: Panorama image of the Delicate Arch </div>
</div>


For this project, let us consider a set of sample images with much stronger corners as shown in the Fig. 3.  
<div class="fig figcenter fighighlight">
  <img src="/assets/pano/pano-image-set.png" width="100%">
  <div class="figcaption"> Fig. 3: Sample image set for panorama stitching </div>
</div>



## 2. Adaptive Non-Maximal Suppression (or ANMS)
The objective of this step is to detect corners such that they are equally distributed across the image in order to avoid weird artifacts in warping. Corners in the image can be detected using `cornermetric` function with the appropriate parameters. The output is a matrix of corner scores: the higher the score, the higher the probability of that pixel being a corner. <i> Try to visualize the output using the Matlab function </i>`imagesc` or `surf`.

To find particular strong corners that are spread across the image, first we need to find $$N$$<sub>strong</sub> corners. Feel free to use MATLAB function `imregionalmax`. Because, when you take a real image, the corner is never perfectly sharp, each corner might get a lot of hits out of the $$N$$ strong corners - we want to choose only the $$N$$<sub>best</sub> best corners after ANMS. In essence, you will get a lot more corners than you should! ANMS will try to find corners which are local maxima.

<div class="fig figcenter fighighlight">
  <img src="/assets/pano/anms.png" width="100%">
</div>

Fig 4. shows the output after ANMS. Clearly, the corners are spread across the image. To plot these dots over the image in MATLAB, do: $$\texttt{imshow(..); hold on; plot(...); hold off;}$$
<div class="fig figcenter fighighlight">
  <img src="/assets/pano/anms-output.png" width="100%">
  <div class="figcaption"> Fig. 4: Output of ANMS on first 2 images. </div>
</div>

## 3. Feature Descriptor
In the previous step, you found the feature points (locations of the N best best corners after ANMS are called the feature points). You need to describe each feature point by a feature vector, this is like encoding the information at each feature points by a vector. One of the easiest feature descriptor is described next.

Take a patch of size $$40 \times 40$$ centered <b>(this is very important)</b> around the keypoint. Now apply gaussian blur (feel free to play around with the parameters, for a start you can use Matlab’s default parameters in `fspecial` command, Yes! you are allowed to use `fspecial` command in this project). Now, sub-sample the blurred output (this reduces the dimension) to $$8 \times 8$$. Then reshape to obtain a $$64 \times 1$$ vector. Standardize the vector to have zero mean and variance of 1 <i>(This can be done by subtracting all values by mean and then dividing by the standard deviation)</i>. Standardization is used to remove bias and some illumination effect.

## 4. Feature Matching
In the previous step, you encoded each keypoint by $$64\times1$$ feature vector. Now, you want to match the feature points among the two images you want to stitch together. In computer vision terms, this step is called as finding feature correspondences within the 2 images. Pick a point in image 1, compute sum of square difference between all points in image 2. Take the ratio of best match (lowest distance) to the second best match (second lowest distance) and if this is below some ratio keep the matched pair or reject it. Repeat this for all points in image 1. You will be left with only the comfident feature correspondences and these points will be used to estimate the transformation between the 2 images also called as <a href="pano-prereq#homography">_Homography_</a>. Use the function `dispMatchedFeatures` given to you to visualize feature correspondences. Fig. 5 shows a sample output of `disMatchedFeatures` on the first two images.

<div class="fig figcenter fighighlight">
  <img src="/assets/pano/feat-match.png" width="100%">
  <div class="figcaption"> Fig. 5: Output of \(\texttt{dispMatchedFeatures}\) on first 2 images. </div>
</div>


## 5. RANSAC to estimate Robust Homography
We now have matched all the features correspondences but not all matches will be right. To remove incorrect matches, we will use a robust method called <i>Random Sampling Concensus</i> or <b>RANSAC</b> to compute homography.

Recall the RANSAC steps are: 
1. Select four feature pairs (at random), $$p_i$$ from image 1, $$p_i^1$$ from image 2.
2. Compute homography $$H$$ (exact). Use the function `est_homography` that will be provided to you. Check Panorama assignment!
3. Compute inliers where $$SSD(p_i^1, Hp_i) < \texttt{thresh}$$. Here, $$Hp_i$$ computed using the $$\texttt{apply_homography}$$ function given to you.
4. Repeat the last three steps until you have exhausted $$N$$<sub>max</sub> number of iterations (specified by user) or you found more than percentage of inliers (Say $$90\%$$ for example).
5. Keep largest set of inliers.
6. Re-compute least-squares $$\hat{H}$$ estimate on all of the inliers. Use the function `est_homography` given to you.

## 6. Cylinderical Projection
When we are try to stitch a lot of images with translation, a simple projective transformation (homography) will produce substandard results and the images will be strectched/shrunken to a large extent over the edges. Fig. 6 below highlights the stitching with bad distortion at the edges. 

<div class="fig figcenter fighighlight">
  <img src="/assets/pano/distortion.png" width="100%">
  <div class="figcaption"> Fig. 6: Panorama stitched using projective transform showing bad distortion at edges. </div>
</div>

To overcome such distortion problem at the edges, we will be using cylinderical projection on the images first before performing other operations. Essentially, this is a pre-processing step. The following equations transform between normal image co-ordinates and cylinderical co-ordinates: 

$$x' = f \cdot tan \left(\cfrac{x-x_c}{f}\right)+x_c$$

$$y' = \left( \cfrac{y-y_c}{cos\left(\cfrac{x-x_c}{f}\right)}\right)+y_c$$

In the above equations, $$f$$ is the focal length of the lens in pixels (feel free to experiment with values, generally values range from 100 to 500, however this totally depends on the camera and can lie outside this range). The original image co-ordinates are $$(x, y)$$ and the transformed image co-ordinates (in cylindrical co-ordinates) are $$(x' ,y')$$. $$x_c$$ and $$y_c$$ are the image center co-ordinates. Note that, $$x$$ is the column number and $$y$$ is the row number in MATLAB.

<p style="background-color:#ddd; padding:5px"><b>Note:</b> Use `meshgrid`, `ind2sub`, `sub2ind` to speed up this part. <b>Using loops will TAKE FOREVER!</b></p>

## 7. Blending Images:
### A. Poisson Blending

## 8. Discussion

