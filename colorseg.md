---
layout: page
mathjax: true
permalink: /colorseg/
---
The Table of Contents:

- [Introduction to perception in an intelligent system](#intro)
- [Sample Vision Pipeline](#visionpipeline)
- [Color Imaging](#colimaging)

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
A simple black-and-white/grayscale sensor works by measuring number of photons per second on each pixel. Think of a grayscale image as a 2D array of pixels where each pixel is one array unit. The array location is the pixel index in the image and the array holds a value representing the amount of light (number of photons) that hit that particular pixel in some unit of time (this is generally the shutter speed of the camera). If you open the PRO mode on your phone's camera or have a fancy DSLR camera you'll see the following four most important things: Focal Length, Aperture, ISO, Shutter Speed. A combination of the last 3 aforementioned factors control the average brightness of the picture taken and are generally called the exposure triangle in photography. Focal Length tells you how wide the Field Of View (FOV) of the lens is, i.e., the smaller the focal length, the more angle you see and vice-versa. For eg. an 8mm lens can have an FOV of 110$$^\circ$$ and a 50mm lens can have an FOV of 32$$^\circ$$. The Aperture is the amount of opnening of the lens, i.e., the lens can have a diameter of 70mm but only 5mm might be collecting light. You might wonder why would I use only 5mm if I have a 70mm diameter lens? The answer to that is the depth of field. The depth of field controls how far on both sides (towards the camera and away from it) is "acceptably in focus". A wide opening in the lens lets in a lot of light but has a shallower depth of field which means that only a very small amount of deviation (towards the camera and away from it) from the focus point makes the image not in focus/blurred. This method is used by photographers to capture beautiful portraits of people. This is not very good for shooting landscapes/robotics perception because everything is not in focus. On the other hand one can set a very small aperture so that we have a large depth of field. This is good for focus but bad as it let's in very little light, i.e., doesn't work well at night or low-light. There is no silver bullet to solve this problem. But a general approximation people in vision/robotics do is that they say we don't really care about focus very close to the camera (say 1m from the camera) and they chose an aperture small enough to let in enough light and that depth of field allows everything from 1m onwards to $$\infty$$ to be in-focus. The next factor controlling the brightness of the image is the ISO. To understand what this factor does, you'll need to understand how the camera/imager captures an image. Each pixel is generally a capacitor/transistor which converts photos/light into some voltage which can be measured by a circuit in the camera. Think of this as light truning a dial/volume knob telling you how much light hits a particular pixel. The volatge level measured per pixel can be amplifed by a number (this is like amplifying your volume on your headphones). ISO controls this amplification factor. As you might have expected a higher ISO means a brighter image and vice-versa. 






