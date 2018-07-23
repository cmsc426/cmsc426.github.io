---
layout: page
title: Math Tutorial
permalink: /math-tutorial/
---
The Table of Contents:

- [Hilbert Space, Vectors, Dot and Cross products](#hilbert)


<a name='hilbert'></a>
In the simplest sense, the Eucledian space we consider in everyday life is mathematically called the Hilbert Space. The co-ordinates of the Hilbert space can represent anything from physical metric co-ordinates (most general sense) to something like cost of goods, volume of goods and so on. Any general metric graph is a Hilbert Space. An $$n$$ dimensional Hilbert space is said to like in \\(\mathbb{R}^n\\) which indicates that all the numbers represented in this space are real. Note that Cartesian space is different from Hilbert space and is a sub-set of it. Mathematically, a Hilbert space is an abstract vector space which preserves the structure of an inner product. In non-math terms, it just means that one can measure length and angle in this space. 

Now, for the sake of easy discussion and without loss of any generality let us assume that our Hilbert Space is in \(\mathbb{R}^3\). Think of this as our $$X-Y-Z$$ co-ordinate space. Any point in space \(p\) is represented as a triplet \([x,y,z]^T\), i.e., having 3 values (one for x-coordinate, one for y-coordinate and one for z-coordinate). I made an implicit assumption when I said that we have \(X-Y-Z\) coordinate space. Can you think of what it is?

Simple, I assumed that the three axes (basis) are perpendicular or orthogonal to each other. One may ask why we need this condition? This is to have the minimal set of numbers to represent any data in the space and that one would only have a unique conbination of these axes (basis) to represent any point. Also, the axes are represented by unit vectors for representing direction only (more about this later). Now any point in the space represents a vector from origin \([0,0,0]^T\) to itself, i.e., the tail of the vector is at the origin and the head of the vector is at the point. Note that the vector is a column vector, this is the general mathematical representation of a vector. Otherwise unless stated vectors are assumed to be column vectors. 

Now let us assume that the space is Cartesian. One might be wondering what other spaces exist? Think of [cylindrical coordinates](http://mathworld.wolfram.com/CylindricalCoordinates.html) or [spherical coordinates](http://mathworld.wolfram.com/SphericalCoordinates.html) which are used in panorama stiching on your phone for Virtual Reality. Let us assume that we have 3 points in this space denoted by \(A, B, C\). The vector from origin to either \(A\) or \(B\) or \(C\) is denoted by their repsective coordinates. Now a vector between 2 points \(A, B\) is represented as \(\vec{AB}\) and is given by \(\vec{AB} = B - A\). 

The dot product between 2 vectors \( \vec{AB}, \vec{BC} \) is defined as \( \vec{AB}\cdot \vec{BC} = \vert \vert \vec{AB} \vert \vert \vert \vert \vec{BC} \vert \vert \cos \theta\). Here, \(\vert \vert \vec{AB} \vert \) represents norm of the vector \(\vec{AB}\) and is given by \( \sqrt{AB_x^2 + AB_y^2 + AB_z^2}\) where \(\vec{AB} = [AB_x, AB_y, AB_z]^T\), \( \theta \) is the angle between the two vectors. Note that the dot product is a scalar value. The dot product represents the projection of one vector onto another vector. This is generally used to measure similarity of vectors in computer vision. Particularly in 3D data from multiple cameras or a [Kinect sensor](https://en.wikipedia.org/wiki/Kinect). Note that the dot prodct is commutative, i.e., 

It is incovinent to write the vector superscript everytime, so a boldface text is commonly used to represent vectors, for eg., \( \vec{AB}\) and \( \matbf{AB}\) reperesent the same thing. 

The cross product between 2 vectors \(\mathbf{a}, \mathbf{b}\) is defined as \( \mathbf{a} \times \mathbf{b} = \vert \vert \mathbf{a} \vert \vert \vert \vert \mathbf{b} \vert \vert \sin \theta \mathbf{n}\). Here \( n\) is the vector perpendicular/normal to the plane containing the two vectors \( \mathbf{a}, \mathbf{b} \) and \(\theta\) is the angle between the two vectors. The cross product is generally found using the right hand rule. 

<div class="fig figleft fighighlight">
  <img src="/assets/math/crossproduct.png" width="60%">
  <div class="figcaption">
    Finding the direction of the cross product by the right-hand rule.
  </div>
  <div style="clear:both;"></div>
</div>


An animation of the cross product is shown below:

<div class="fig figcenter fighighlight">
  <img src="/assets/math/crossproductanimation.gif" width="60%">
  <div class="figcaption">The cross product \( \mathbf{a} \times \mathbf{b}\) (vertical, in purple) changes as the angle between the vectors \( \mathbf{a} \) (blue) and \( \mathbf{b} \) (red) changes. The cross product is always orthogonal to both vectors, and has magnitude zero when the vectors are parallel and maximum magnitude \( \vert \vert \mathbf{a} \vert \vert \vert \vert \mathbf{b} \vert \vert \) when they are orthogonal.</div>
</div>


