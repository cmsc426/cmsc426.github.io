---
layout: page
title: System Setup and Matlab Resources
permalink: /system-setup-and-matlab-resources/
---

## Setup
You can work on the assignment in one of two ways: locally on your own machine, or on a virtual machine on Google Cloud. 

### Working remotely on Google Cloud (Recommended)

**Note:** after following these instructions, make sure you go to **Download data** below (you can skip the **Working locally** section).

As part of this course, you can use Google Cloud for your assignments. We recommend this route for anyone who is having trouble with installation set-up, or if you would like to use better CPU/GPU resources than you may have locally. Please see the set-up tutorial [here](http://cs231n.github.io/gce-tutorial/) for more details. :)

### Working locally

**Installing Anaconda:**
If you decide to work locally, we recommend using the free [Anaconda Python distribution](https://www.anaconda.com/download/), which provides an easy way for you to handle package dependencies. Please be sure to download the Python 3 version, which currently installs Python 3.6. We are no longer supporting Python 2.

**Anaconda Virtual environment:**
Once you have Anaconda installed, it makes sense to create a virtual environment for the course. If you choose not to use a virtual environment, it is up to you to make sure that all dependencies for the code are installed globally on your machine. To set up a virtual environment, run (in a terminal)

`conda create -n cs231n python=3.6 anaconda`

to create an environment called `cs231n`.

Then, to activate and enter the environment, run

`source activate cs231n`

To exit, you can simply close the window, or run

`source deactivate cs231n`

Note that every time you want to work on the assignment, you should run `source activate cs231n` (change to the name of your virtual env).

You may refer to [this page](https://conda.io/docs/user-guide/tasks/manage-environments.html) for more detailed instructions on managing virtual environments with Anaconda.

**Python virtualenv:**
Alternatively, you may use python [virtualenv](http://docs.python-guide.org/en/latest/dev/virtualenvs/) for the project. To set up a virtual environment, run the following:

```bash
cd assignment1
sudo pip install virtualenv      # This may already be installed
virtualenv -p python3 .env       # Create a virtual environment (python3)
# Note: you can also use "virtualenv .env" to use your default python (please note we support 3.6)
source .env/bin/activate         # Activate the virtual environment
pip install -r requirements.txt  # Install dependencies
# Work on the assignment for a while ...
deactivate                       # Exit the virtual environment
```

## Matlab Resources

All projects in this course will be done in Matlab.  Matlab is available (for Windows, Mac, and Linux) to students for free through [Terpware](https://terpware.umd.edu/).  **Be sure to get the Computer Vision Toolkit**, as we'll use it in later projects.

### Tutorials
**Introduction to Matlab:**

* [Getting Started with MATLAB.](https://www.mathworks.com/videos/getting-started-with-matlab-68985.html)
* [Interface overview.](http://www.mathworks.com/videos/working-in-the-development-environment-69021.html)
* [How to write a script/program.](http://www.mathworks.com/videos/writing-a-matlab-program-69023.html)
* [Introduction to Matlab (code)](http://cs.brown.edu/courses/csci1290/docs/matlab/matlabtutorialcode.html), from Brown CSCI1290.

**Writing good code:**

* [Techniques to improve performance](https://www.mathworks.com/help/matlab/matlab_prog/techniques-for-improving-performance.html), from Mathworks.
  * Vectorization is especially important.  [Here's an overview from Mathworks.](https://www.mathworks.com/help/matlab/matlab_prog/vectorization.html)
* [Debugging in Matlab](https://www.mathworks.com/help/matlab/matlab_prog/debugging-process-and-features.html), from Mathworks.
