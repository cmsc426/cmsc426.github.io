---
layout: page
title: Math Tutorial
permalink: /math-tutorial/
---
The Table of Contents:

- [Hilbert Space, Vectors, Dot and Cross Products](#hilbert)
- [Eigenvalues and Eigenvectors](#eigen)


<a name='hilbert'></a>
## Hilbert Space, Vectors, Dot and Cross Products
In the simplest sense, the Eucledian space we consider in everyday life is mathematically called the Hilbert Space. The co-ordinates of the Hilbert space can represent anything from physical metric co-ordinates (most general sense) to something like cost of goods, volume of goods and so on. Any general metric graph is a Hilbert Space. An \\(n\\) dimensional Hilbert space is said to like in \\(\mathbb{R}^n\\) which indicates that all the numbers represented in this space are real. Note that Cartesian space is different from Hilbert space and is a sub-set of it. Mathematically, a Hilbert space is an abstract vector space which preserves the structure of an inner product. In non-math terms, it just means that one can measure length and angle in this space. 

Now, for the sake of easy discussion and without loss of any generality let us assume that our Hilbert Space is in \\(\mathbb{R}^3\\). Think of this as our \\(X-Y-Z\\) co-ordinate space. Any point in space \\(p\\) is represented as a triplet \\([x,y,z]^T\\), i.e., having 3 values (one for x-coordinate, one for y-coordinate and one for z-coordinate). I made an implicit assumption when I said that we have \\(X-Y-Z\\) coordinate space. Can you think of what it is?

Simple, I assumed that the three axes (basis) are perpendicular or orthogonal to each other. One may ask why we need this condition? This is to have the minimal set of numbers to represent any data in the space and that one would only have a unique conbination of these axes (basis) to represent any point. Also, the axes are represented by unit vectors for representing direction only (more about this later). Now any point in the space represents a vector from origin \\([0,0,0]^T\\) to itself, i.e., the tail of the vector is at the origin and the head of the vector is at the point. Note that the vector is a column vector, this is the general mathematical representation of a vector. Otherwise unless stated vectors are assumed to be column vectors. 

Now let us assume that the space is Cartesian. One might be wondering what other spaces exist? Think of [cylindrical coordinates](http://mathworld.wolfram.com/CylindricalCoordinates.html) or [spherical coordinates](http://mathworld.wolfram.com/SphericalCoordinates.html) which are used in panorama stiching on your phone for Virtual Reality. Let us assume that we have 3 points in this space denoted by \\(A, B, C\\). The vector from origin to either \\(A\\) or \\(B\\) or \\(C\\) is denoted by their repsective coordinates. Now a vector between 2 points \\(A, B\\) is represented as \\(\vec{AB}\\) and is given by \\(\vec{AB} = B - A\\). 

The dot product between 2 vectors \\( \vec{AB}, \vec{BC} \\) is defined as \\( \vec{AB}\cdot \vec{BC} = \vert \vert \vec{AB} \vert \vert \vert \vert \vec{BC} \vert \vert \cos \theta\\). Here, \\(\vert \vert \vec{AB} \vert \\) represents norm of the vector \\(\vec{AB}\\) and is given by \\( \sqrt{AB_x^2 + AB_y^2 + AB_z^2}\\) where \\(\vec{AB} = [AB_x, AB_y, AB_z]^T\\), \\( \theta \\) is the angle between the two vectors. Note that the dot product is a scalar value. The dot product represents the projection of one vector onto another vector. This is generally used to measure similarity of vectors in computer vision. Particularly in 3D data from multiple cameras or a [Kinect sensor](https://en.wikipedia.org/wiki/Kinect). Note that the dot product is commutative (\\(\mathbf{a}\cdot \mathbf{b} = \mathbf{b}\cdot \mathbf{a}\\)) and **not** associative because the dot product between a scalar (\\(a \cdot b\\)) and a vector (\\(c\\)) is not defined.  \\((a \cdot b) \cdot c\\) or \\(a \cdot (b \cdot c\\)) are both ill-defined. Other properties can be found [here](https://en.wikipedia.org/wiki/Dot_product).


<div class="fig figleft fighighlight">
  <img src="/assets/math/proj.png" width="35%">
  <div class="figcaption">
    Projection of \(a\) on \(b\) (\(a1\)), and rejection of \(a\) from \(b\) (\(a2\)).
  </div>
  <div style="clear:both;"></div>
</div>


It is incovinent to write the vector superscript everytime, so a boldface text is commonly used to represent vectors, for eg., \\( \vec{AB}\\) and \\( \mathbf{AB}\\) reperesent the same thing. 

The cross product between 2 vectors \\(\mathbf{a}, \mathbf{b}\\) is defined as \\( \mathbf{a} \times \mathbf{b} = \vert \vert \mathbf{a} \vert \vert \vert \vert \mathbf{b} \vert \vert \sin \theta \mathbf{n}\\). Here \\( \mathbf{n}\\) is the vector perpendicular/normal to the plane containing the two vectors \\( \mathbf{a}, \mathbf{b} \\) and \\(\theta\\) is the angle between the two vectors. The direction of cross product is found using the right hand rule in a right handed coordinate system. 

<div class="fig figleft fighighlight">
  <img src="/assets/math/crossproduct.png" width="35%">
  <div class="figcaption">
    Finding the direction of the cross product by the right-hand rule.
  </div>
  <div style="clear:both;"></div>
</div>


An animation of the cross product is shown below:

<div class="fig figleft fighighlight">
  <img src="/assets/math/crossproductanimation.gif" width="35%">
  <div class="figcaption">
   The cross product \( \mathbf{a} \times \mathbf{b}\) (vertical, in purple) changes as the angle between the vectors \( \mathbf{a} \) (blue) and \( \mathbf{b} \) (red) changes. The cross product is always orthogonal to both vectors, and has magnitude zero when the vectors are parallel and maximum magnitude \( \vert \vert \mathbf{a} \vert \vert \vert \vert \mathbf{b} \vert \vert \) when they are orthogonal.
  </div>
  <div style="clear:both;"></div>
</div>

The cross product is used to find normal vector to a plane in computer vision. This is especially useful in aligning 3D point clouds (images with depth infromation). This method is extensively used in self driving cars to make a map using LIDAR scans. If you are curious, have a look at [Point to Plane Iterative Closest Point algorithm](https://www-new.comp.nus.edu.sg/~lowkl/publications/lowk_point-to-plane_icp_techrep.pdf) to understand how this works. Don't worry you'll implement this in Project 3. Note that the cross prodct is  anticommutative (\\(\mathbf{a}\times \mathbf{b} = -\mathbf{b}\times\mathbf{a}\\)) and **not** associative. Other properties can be found [here](https://en.wikipedia.org/wiki/Dot_product).

<a name='eigen'></a>
## Eigenvalues and Eigenvectors
Let us say we have a vector \\(\mathbf{v}\\) in \\( \mathbb{R}^n\\). A linear transformation of \\(\mathbf{v}\\) is given by a matrix \\(A\\) multiplied by \\(\mathbf{v}\\). One could have a special vector \\(\mathbf{v}\\) such that the function \\(A \mathbf{v}\\) returns a scaled version of \\(\mathbf{v}\\), i.e., the direction of the \\( \mathbf{v}\\) is maintained upon a linear transformation by \\(A\\). This can mathematically be written as:

$$
A \mathbf{v} = \lambda \mathbf{v}
$$

Note that \\( \lambda \mathbf{v}\\) is a scaled version of \\(\mathbf{v}\\), i.e., the direction of both the vectors is the same. Recall, that the direction of a vector \\(\mathbf{v}\\) is given by \\(\frac{\mathbf{v}}{\vert \vert \mathbf{v} \vert \vert}\\). The concept of scale factor is very important for computer vision and will be later used in the last project. 

In the above transformation \\( A \in \mathbb{R}^{n \times n}\\). Now one can solve the above equation as follows:

$$
\left(A - \lambda I \right)\mathbf{v} =  0
$$

Here \\( I\\) is an identity matrix of size \\( n \times n\\) and has all the diagonal elements as 1 and non-diagonal elements as 0. Once the above equation is solved, one would find \\(n\\) pairs of \\(\lambda_i\\) and \\(\mathbf{v}_i\\) such that the above equation is satisfied (\\(i\\) varies from 1 to \\(N\\)). These set of \\(\lambda_i\\) values are called **eigenvalues** and these set of \\(\mathbf{v}_i\\) vectors are called **eigenvectors**. Note that the eigenvectors are linearly independent, i.e., dot product between any of them is zero. However, eigenvalues need not be distinct. If we have a matrix \\(Q\\) whose columns are made up of the eigenvectors, i.e., 

$$
Q = \begin{bmatrix} \mathbf{v_1} & \mathbf{v_2} & \cdots & \mathbf{v_n} \end{bmatrix}
$$

Now, consider \\( AQ\\) and the fact that \\( A \mathbf{v} = \lambda \mathbf{v}\\).

$$
AQ = \begin{bmatrix} \lambda_1\mathbf{v_1} & \lambda_2\mathbf{v_2} & \cdots & \lambda_n\mathbf{v_n} \end{bmatrix}
$$

This can be re-written as:

$$
AQ = \begin{bmatrix} \mathbf{v_1} & \mathbf{v_2} & \cdots & \mathbf{v_n} \end{bmatrix} \Lambda
$$ 

Here \\(\Lambda\\) is a diagonal matrix with \\(\Lambda_{ii} = \lambda_i\\). We also know that columns of \\(Q\\) are linearly independent, this means that 
\\(Q\\) is invertible. 

$$
A = Q\Lambda Q^{-1}
$$

The above is called **Eigen-decomposition** in literature. Eigen-decomposition is very commonly used in an algorithm called [**Principle Component Analysis (PCA)**](https://en.wikipedia.org/wiki/Principal_component_analysis). PCA is used to find the most important linearly independent basis of a given data. 

You might be wondering what the inuition to Eigen-decomposition is. The eigenvalues represent the covariance and eigenvectors represent the linearly independent directions of variation in data. A sample eigenvectors and eigenvalues are shown below:


<div class="fig figcenter fighighlight">
  <img src="/assets/math/eigenvectors.png" width="60%">
  <div class="figcaption">Eigenvectors of a covariance matrix of data shown in blue. Data is drawn from a gaussian distribution.</div>
</div>

For a detailed explanation of the visualization look at [this link](http://www.visiondummy.com/2014/04/geometric-interpretation-covariance-matrix/). In computer vision, eigenspaces have been used for ages. Consider the problem of face recognition. Here we have a dataset of a lot of faces and we need to identify the person given a photo of the face. This is similar to what TSA does when they check your ID at the airport, they are manually trying to see if the photo in the ID looks like the person in front of them. One of the ealiest face recognition methods used eigenspaces and the algorithm is aptly called **Eigenfaces**. The idea of the algorithm is to represent any face as a linear combination of **eigenfaces**. These **eigenfaces** are supposed to represent the most common features of a face and that any face can be reconstructed as their linear combination. This means that each face is represented as a vector of weights which multiply these eigenfaces and are added up to make the original face. Think of this as representing each face as an encoded vector. This idea is also used extensively in compression. During the face identification, the test face is also converted to a vector and the label (person ID) of closest vector in the training set (database of face images on the computer) is chosen as the predicted label (person ID). A visual representation of this is shown below. For more details look at [this link](http://www.vision.jhu.edu/teaching/vision08/Handouts/case_study_pca1.pdf).


<div class="fig figcenter fighighlight">
  <img src="/assets/math/eigenface1.PNG" width="35%">
  <div class="figcaption">Sample images in the database/training set.</div>
  <img src="/assets/math/eigenface2.PNG" width="70%">
  <div class="figcaption">
   Top row: Eigenfaces. Bottom row: How any face can be represented as a linear combination of eigenfaces.</div>
</div>

Note that Eigendecomposition only works on **square matrices**.