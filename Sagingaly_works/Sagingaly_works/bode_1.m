clear all; close all; clc;

sys = tf(1, [1 3 1 4]);

bode(sys);
