%% Wrapper for the CMSC426Course final project at University of Maryland, College Park
% Code by: Nitin J. Sanket (nitinsan@terpmail.umd.edu)
%          (Originally for CMSC828T)

clc
clear all
close all

%% Add ToolBox to Path eg. ToolboxPath = 'gtsam_toolbox';
addpath(ToolboxPath);

%% Load Data
% Download data from the following link: 
% https://drive.google.com/open?id=1ZFXZEv4yWgaVDE1JD6-oYL2KQDypnEUU
load('CalibParams.mat');

%% Load Data (Two datasets have been provided: DataMapping and DataSquare; ...
%% Uncomment the one you are using):
% load('DataMapping.mat');
% load('DataSquare.mat');


%% SLAM Using GTSAM (DetAll: is a cell array with AprilTag detections per frame along with the TagID, ...
%  K: Camera Calibration Parameters, TagSize: AprilTag Size in the real world, ...
%  LeftImgs: cell array where each cell is a Image, TLeftImgs: Timestamps for LeftImgs)
[LandMarksComputed, AllPosesComputed] = SLAMusingGTSAM(DetAll, K, TagSize, LeftImgs, TLeftImgs);


%% Extra Credit: (Uncomment the bottom line if you are doing the Extra credit part)
%  For other variables, refer: https://cmsc426.github.io/2019/proj/p4/
% [LandMarksComputed, AllPosesComputed] = SLAMusingGTSAM(DetAll, K, TagSize, qIMUToC, TIMUToC,...
                                                IMU, LeftImgs, TLeftImgs);