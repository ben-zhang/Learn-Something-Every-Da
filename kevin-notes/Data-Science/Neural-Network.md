# Artificial neural network
Artificial neural networks (ANNs) are simple mathematical models defining `f: X -> Y` or a distribution over X or both X and Y

Uses a connectionism model, based on modelling mental phenomena using interconnected units. Neural Networks are a computational approach based on a collection of neural units connected by axons.
- each neural unit holds a function of all of it's inputs, whose output is propagated to other neural units
- typically consist of multiple layers or a cube design where signal path traverses from front to back
- in connectionist models, networks change over time

[source](https://ujjwalkarn.me/2016/08/09/quick-intro-neural-networks/)

A single neuron takes input from other nodes and computes an output
- inputs have associated weights for relative importance
- the node applies a function f to the weighted sums + b (bias)
- f is a non-linear Activation Function
  - purpose is to introduce non-linearity into the output of a neuron
  - most real world data is non-linear, so this is needed for representation
- Sigmoid: takes real-valued input and squashes into a range between 0 and 1
- tanh: real -> [-1,1]
- ReLU: Rectified Linear Unit is f(x) = max(0,x), threshold at 0

[Bias](http://stackoverflow.com/questions/2480650/role-of-bias-in-neural-networks) lets you shift the activation function left or right, which may be critical for success
- without bias, an activation function can only change in steepness, while bias lets you represent more real world trends in data

<img src="http://natekohl.net/media/sigmoid-scale.png" height=200 alt="adjusting weighting"> vs. <img src="http://natekohl.net/media/sigmoid-shift.png" height=200 alt="adjusting bias">

**Feedforward Neural Networks** are the simplest type of NN
- neurons arranged in layers, and nodes between layers have connections and associated weights
- nodes are typed based on which layer they're in: input, hidden, or output
- feedforward, information *only moves in one direction*- no cycles 
- single layer perceptron has no hidden layers, while multi layer perceptron (MLP) has one or more 
- MLPs learn through the **Backpropagation algorithm**
  - one way NNs are trained
  - supervised, learning from mistakes
  - initially all edge weights are random
  - for every input, the output is compared to the desired one, and error is propagated back to the previous layer

# Convolutional Neural Networks
[source](https://ujjwalkarn.me/2016/08/11/intuitive-explanation-convnets/)

A category of Neural Networks, effective in image recognition and classification
- tagging scene recognition, object recognition, NLP sentence classification


Feed-forward neural network: connections between units are acyclic, and is unidirectional
- individual neurons respond to stimuli in a restricted region of space known as the receptive field
- overlap between receptive fields of neruons are the visual field
- convolution is the operation on two first class functions `f` and `g` to produce a third function
  - modified version of one of the original functions, giving the integral of pointwise multiplication of the two functions

### [ImageNet classification with deep convolutional neural networks](http://papers.nips.cc/paper/4824-imagenet-classification-with-deep-convolutional-neural-networks.pdf)
CNN's capacity can be controlled by varying their depth and breadth (layers), and make strong assumptions with less needed connections
- faster to train since less connections, theoretical "best-performance" is only slightly worse dispite less connections
- ImageNet challenge is to create a classifier that determines which object is in the image
- in this implementation, they use ReLU instead of tanh for activiation functions (since it has 10x performance) 
  - multiple GPUs, each handling different convolutional layers
  - local response normalization
  - overlapping pooling

Maxout networks are designed to work with dropout networks
- dropout is like training an exponential number of networks
