---
layout: page
mathjax: true
permalink: /colorseg/
---
The Table of Contents:

- [Introduction to perception in an intelligent system](#intro)
- [Sample Vision Pipeline](#visionpipeline)
- [Color Imaging](#colimaging)
- [RGB and other Color Spaces](#colorspace)
- [Color Classification](#colorclassification)

<a name='intro'></a>

## Introduction
This lecture is designed to introduce students from various backgrounds to how the camera captures the image and how one can manipulate color-spaces to identify specific colored objects in the image.

Any intelligent system (robotic system/robot/robot agent) senses the world through it's sensors and interacts with the environment based on some actuators. This can be shown in the figure below:

<div class="fig figcenter fighighlight">
  <img src="/assets/classify.png">
  <div class="figcaption">Robot interactive with the environment and sensing the world.</div>
</div>

The sensors and the movements of a robot are noisy. The robot has a sense of where it is in the world with respect to other objects to a certain degree of uncertainity or noise, for eg. an autonomous car might know that it is about 5ft away from the pedestrian with a certain degree of accuracy. The goal of any robot is to combine the information from multiple sensors to increase it's accuracy. Also, whenever a robot moves, because the motors are not perfect, the movements are noisy. To counteract this non-perfect movement the robots need to continuously monitor it's sensor values and re-evaluate the world. 

<a name='visionpipeline'></a>

## A sample Vision Pipeline in an intelligent agent
Consider the example of a Nao robot playing soccer. The Nao is a 58cm high humanoid robot which can walk, pick-up things, talk. It has 2 cameras, 1 front and 1 facing down at an angle, some sonar sensors and an Intel Atom processor on-board. It is used in the robocup soccer competiion where a 5 on 5 autonomous soccer match takes place between nao robots with all processing done on-board. This necessitates the algorithms to be robust, fast and cheap. The competition takes place on a green-colored soccer field with an orange ball and yellow goal-posts. The aim of the project 1 is to give a flavor of what goes behind the scenes in this compeition's vision pipeline. Your aim in this project would be to detect the red soccer ball and estimate the distance to it. Doesn't it sound cool?

Let's talk about the key concepts first. A sample vision pipeline in a robot is as follows. The robot gets an input image (say RGB color), then the robot has to identify certain important colors in the scene (like green, orange and yellow in this case) where the colors are labelled as discrete color classes, i.e., each pixel can only be either yellow or green or orange. These labelled pixels are then grouped and finally object classification is done to give way to higher level knowledge like kick the ball.


<div class="fig figcenter fighighlight">
  <img src="/assets/classify.png">
  <div class="figcaption">Nao robot.</div>
</div>


<div class="fig figcenter fighighlight">
  <img src="/assets/classify.png">
  <div class="figcaption">Sample Vision pipeline in a robocup robot.</div>
</div>

<a name='colimaging'></a>

## Color Imaging
A simple black-and-white/grayscale sensor works by measuring number of photons per second on each pixel. Think of a grayscale image as a 2D array of pixels where each pixel is one array unit. The array location is the pixel index in the image and the array holds a value representing the amount of light (number of photons) that hit that particular pixel in some unit of time (this is generally the shutter speed of the camera). If you open the PRO mode on your phone's camera or have a fancy DSLR camera you'll see the following four most important things: Focal Length, Aperture, ISO, Shutter Speed. A combination of the last 3 aforementioned factors control the average brightness of the picture taken and are generally called the exposure triangle in photography.
RGB and other Color Spaces
Focal Length tells you how wide the Field Of View (FOV) of the lens is, i.e., the smaller the focal length, the more angle you see and vice-versa. For eg. an 8mm lens can have an FOV of 110$$^\circ$$ and a 50mm lens can have an FOV of 32$$^\circ$$.

The Aperture is the amount of opnening of the lens, i.e., the lens can have a diameter of 70mm but only 5mm might be collecting light. You might wonder why would I use only 5mm if I have a 70mm diameter lens? The answer to that is the depth of field. The depth of field controls how far on both sides (towards the camera and away from it) is "acceptably in focus". A wide opening in the lens lets in a lot of light but has a shallower depth of field which means that only a very small amount of deviation (towards the camera and away from it) from the focus point makes the image not in focus/blurred. This method is used by photographers to capture beautiful portraits of people. This is not very good for shooting landscapes/robotics perception because everything is not in focus. On the other hand one can set a very small aperture so that we have a large depth of field. This is good for focus but bad as it let's in very little light, i.e., doesn't work well at night or low-light. There is no silver bullet to solve this problem. But a general approximation people in vision/robotics do is that they say we don't really care about focus very close to the camera (say 1m from the camera) and they chose an aperture small enough to let in enough light and that depth of field allows everything from 1m onwards to $$\infty$$ to be in-focus. Also, a very small aperture leads to an effect called difraction which leads to a "softer" image.

The next factor controlling the brightness of the image is the ISO. To understand what this factor does, you'll need to understand how the camera/imager captures an image. Each pixel is generally a capacitor/transistor which converts photos/light into some voltage which can be measured by a circuit in the camera. Think of this as light truning a dial/volume knob telling you how much light hits a particular pixel. The volatge level measured per pixel can be amplifed by a number (this is like amplifying your volume on your headphones). ISO controls this amplification factor. As you might have expected a higher ISO means a brighter image and vice-versa. Then one might ask why not just set a small aperture and increase your ISO to the maximum value? Increasing ISO comes at a cost, a lot of noise. So generally one has to be mindful of the parameters chosen. A balance of these parameters have to be chosen.

The last factor in the exposure triangle is the shutter speed. This is the time the camera/imager is collecting light. The voltage measured will be a sum of all the photons collected during the shutter is active/open. A longer shutter speed gives you more light but wil blur any motion. The camera's auto mode generally selects the best balance of all the exposure triangle parameters based on some heuristic. 

- Link the paper to make long exposure from shot photos!

You might be wondering how does one collect color/RGB (Red Green Blue) images. A simple way of doing this is having a camera sensor where each pixel has 3 sub-pixels (or 3 pixels inside each pixel) each of which measures a color out of red, green and blue respectively. One can select a color by using the dye of the same color on the pixel (grayscale has a transparent dye). This becomes very expensive and is generally only used in very high end cameras which cost thousands of dollars. The cheaper sensors use something called a bayer pattern. Where each pixel has one colored dye and they alternatively are Red, Green and Blue. The missing colors are interpolated using a simple interpolation algorithm. The RGB image is represented as a three dimentional array (width x height x 3) on the computer. 


<div class="fig figcenter fighighlight">
  <img src="/assets/classify.png">
  <div class="figcaption">Bayer Pattern.</div>
</div>


A simple question one might ask, why use RGB for the color image and why not something else? The answer is human retina has 3 types of cone cells which are selective to see RGB colors. One can think of the the amount of activation/response/sensitivity of a cone cell be modelled as some unimodal distribution function. A unimodal distribution means the distribution has only one peak. The three kinds of cone cells are sensitive to Small ($$S(\lambda)$$), Medium ($$M(\lambda)$$) and Long ($$L(\lambda)$$) wavelengths of visible light which coincides with red, green and blue colored light. Think of these cone cells as very sensitive to red, green or blue light. Any scene reflects a arbitrary spectrum of light (or signal represnted as $$f(\lambda)$$). One might wonder what the response of red sensitive cone cells will look like on this input light spectrum. One can represent the response of the S, M and L detectors/cone cells by a super simplified model given by:

$$ S_{res}=\int S(\lambda)f(\lambda) d\lambda$$

$$ M_{res}=\int M(\lambda)f(\lambda) d\lambda$$

$$ L_{res}=\int L(\lambda)f(\lambda) d\lambda$$

Note that one can have a completely different scene which reflects a different spectrum of light ($$f'(\lambda)$$). Because of the way the detectors work, one could have the **exact** same value for $$ S_{res}, M_{res}, L_{res}$$. This means that one cannot distringuish both the scenes in terms of colors. This happens because the eyes are "seeing" a 3D projection of the $$\infty$$-dimensional hilbert space of the spectrum. This is mathematically represented as $$\mathbb{R}^\infty \rightarrow \mathbb{R}^3$$. Color blindess is missing one of the receptors or the S, M, L receptors become too similar to each other. This in-turn reduces the dimentionality from 3 to 2 or 1. This is in some sense taking PCA of the infiinte dimentional spectrum in your eyes. 


<a name='colorspace'></a>
## RGB and other Color Spaces
The colors (RGB) can be represented in a 3D vector space. Think of this as X, Y and Z co-ordinate of a vector space representing colors. In most generic cameras, 8-bits are used to represent each color channel (the values range from 0-255). This means that an RGB pixel has 24-bits of data represented as a triplet of **\[Red, Green, Blue\]**. A value of \[0,0,0\] represents pure black, \[255,255,255\] represents pure white, \[255,0,0\] represents pure red and so on. Gray is any color which equal values of all the three channels. When RGB space is represented in the 3D vector space/cartesian space one can think of all normalized colors (divide each value by 255 for 8-bit) to be present in a unit-cube. One might think if colors are just a vector space then why cannot one transform them to make a different space. Indeed, this is what gives rise to other color spaces. Two such examples are Hue Saturation Value (HSV) and Luminance and chroma (YCbCr) color spaces. If $$[R, G, B]$$ represents a sample color in the RGB color space, then the equivalent HSV color space value is given by,

$$ R' = \frac{R}{255} $$

$$ G' = \frac{G}{255} $$

$$ B' = \frac{B}{255} $$

$$ C_{max} = \max{\left(R', G', B'\right)}  $$

$$ C_{min} = \min{\left(R', G', B'\right)}  $$

$$ \Delta = C_{max} - C_{min} $$

Hue is calculated as follows:

$$ 
\begin{cases} 
0^\circ &\quad \text{if }\Delta=0\\
60^\circ \times \frac{G'-B'}{\Delta} % 6 &\quad \text{if } C_{max}=R'\\
60^\circ \times \frac{B'-R'}{\Delta} + 2 &\quad \text{if } C_{max}=G'\\
60^\circ \times \frac{R'-G'}{\Delta} + 4 &\quad \text{if } C_{max}=B'\\ 
\end{cases}
$$

Saturation is calculated as follows:

$$ 
\begin{cases} 
0 &\quad \text{if }C_{max}=0\\
\frac{\Delta}{C_{max}} &\quad \text{if } C_{max}\neq 0\\
\end{cases}
$$

Value is calulated as follows:

$$
V = C_{max}
$$

You might be wondering what this wierd transformation space looks like when the RGB space was a pretty unit cube? The unit RGB cube in HSV space looks like a cone (cool eh?). HSV is very popular and is used in NTSC, PAL, SECAM and other television broadcast systems. 


If $$[R, G, B]$$ represents a sample color in the RGB color space, then the equivalent YCbCr color space value is given by,

$$
Y = 0.299R + 0.587G + 0.114B 
$$

$$
Cb = -0.169R + -0.331G + 0.500B + 128 
$$

$$
Cr = 0.500R + -0.419G + -0.081B + 128 
$$

Keen readers might have observed that HSV was a non-linear transformation and YCbCr is a linear transformation of the RGB color space. As you expect the RGB color cube looks like a rotated cuboid in YCbCr space. Look at ``rgb2hsv, hsv2rgb, rgb2ycbcr, ycbcr2rgb`` functions in MATLAB and play around. **Fun exercise would be to try to plot the RGB color cube in different color spaces.** 

<div class="fig figcenter fighighlight">
  <img src="/assets/classify.png">
  <div class="figcaption">RGB, HSV and YCbCr color spaces.</div>
</div>


- [Color Classification](#colorclassification)
In the project 1, the nao robot wants to classify each pixel as a set of discrete colors, i.e., green of the grass field, orange of the soccer ball and yellow of the goal post. Particularly we are interested in finding the orange pixels because this represents the ball. As we talked about before, in RGB color space each pixel is represented as a vector in $$ \mathbb{R}^3$$. Let us define the problem mathematically. Say each pixel is represented by $$x=[r,g,b]^T \in \mathbb{R}^3$$. There exist $$l$$ color classes. We want to model the probability of a pixel belonging to a color class $$C_l$$ given the pixel value $$x$$ and this is denoted by $$p(C_l \vert x)$$. If you make the assumption/approximation that each pixel only belongs to one color class, i.e., color classes are mutually exlusive. (This is like saying if a pixel is classified as orange it cannot be classified as red, though in reality a red pixel could have some amount of orange and vice-versa. This comes from that fact that the camera sensor percieves a 3-dimensinal projection of the $$\infty$$-dimensional hilbert space projection of the light spectrum). The hard classification problem can be mathematically defined as follows:

<!-- https://stackoverflow.com/questions/36174987/how-to-typeset-argmin-and-argmax-in-markdown -->
$$ 
C_l^*(x) = 
\underset{C_k}{\operatorname{argmax}} p(C_k\vert x) 
$$

Here, $$C_l^*(x)$$ represents the most probable color class that pixel belongs to. For eg. if the color is closer to orange than red then the pixel will be called orange. This can be done using the [Color Thresholder app](https://www.mathworks.com/help/images/ref/colorthresholder-app.html) in MATLAB. In RGB space, thresholding can be thought of selecting pixels in a cube defined by some minimum and maximum value in each channel (RGB), i.e., you are selecting all the pixels in a cube whose faces are defined by the minimum and maxmimum value in each channel. This can be mathematically formulated as:

$$
x_{sel} = \{x \vert x^r \in [R_{min}, R_{max}], x^g \in [G_{min}, G_{max}], x^b \in [B_{min}, B_{max}]\}
$$

where $$x^r, x^g, x^b$$ represent the red, green and blue channel values of a particular pixel. 

<div class="fig figcenter fighighlight">
  <img src="/assets/classify.png">
  <div class="figcaption">Color Thresholder app.</div>
</div>


This is good for most basic cases but is bad for robotics because we said that everything (sensors and actuators) is noisy and we want to model the world in a probabilistic manner. This means that instead of saying a pixel is orange/red we want to say that the pixel is orange with 70% probability and red with 30% probability. This is denoted as $$p(C_l\vert x)$$ as mentioned before. Because we are in 2019 and everything is machine learning driven, let us treat the problem in hand as  a machine learning problem. 


