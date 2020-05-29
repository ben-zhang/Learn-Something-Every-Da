# Optimization For Deep Learning

## 8.3 Basic  Algorithms For DL Optimization

### Stochastic Gradient Descent

We can use SGD to follow the gradients of randomly selected minibatches downhill. 

The learning rate of SGD must be decreased over time, so it differs from one iteration to the next. The SGD gradient estimator introduces a source of noise

![image-20200519165915383](C:\Users\Benzh\AppData\Roaming\Typora\typora-user-images\image-20200519165915383.png)

Review: Concept of Momentum

We can use **momentum** in conjunction with SGD. While SGD considers only the current gradient, momentum-based methods consider past gradients as well, in order to 

### Parameter Initialization

****

**Nesterov Momentum**: Compute momentum before computing gradient. We use the alpha term to determine something or other. 

### Adaptive Learning Rates

The learning rate of an algorithm is a hyperparameter.