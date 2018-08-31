

# udacity-deep-learning
Assignments of the Udacity MOOC Deep Learning

This repository contains the assignments I have done during the [Udacity MOOC on Deep Learning with Google][udacity-deep-learning]. The course is free but there is no support expect if you register to a [nanodegree program][udacity-nanodegree]. That's why I'm sharing my homeworks with as much comments as possible, you may find them useful.

**Disclaimer:** there is probably a code of conduct if you are enrolled in the nanodegree. Copying the code from the repository and pretending it to be sure would be bad. Even looking into it may be an infringement. Talk to your instructor.

The course is just great! You will use and develop neural networks for image recognition with convolution, natural language processing with embeddings and character based text generation with RNN/LTSM.

See below an outcome of one of the assignments, a t-SNE projection of word vectors, clustered by similarity.

![t-SNE projection of word vectors clustered by similarities][tsne-word-vectors]

Amazing, isn't it?

## Installation and setup

Since the datasets are loaded in memory, 4 GB of RAM are short to run the notebooks, 8 GB will be more comfortable. The instructions are given for Mac OS, but it works on Linux as well.

I recommend to install the Python bundle [Anaconda][anaconda]. All the assignments have been done with Python 2.7, so download the installation script accordingly. You can then install [Jupyter Notebook][jupyter] from ``conda``.

The next step is to install TensorFlow. At the time of writing, the latest release is r0.9, after several upgrades during the course. You can refer to the [official documentation][tensorflow-anaconda-install]. Here is the list of commands:

```
$ conda create -n tensorflow python=2.7
$ source activate tensorflow
(tensorflow)$ export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/mac/tensorflow-0.9.0-py2-none-any.whl
(tensorflow)$ pip install --upgrade --ignore-installed $TF_BINARY_URL
```

You can now grab the assignments from here to run my code or the stubs from the [TensorFlow repository][tensorflow-repo]. All the other prerequisites (like ``numpy``) have to be installed on the fly.

## Quick start

From the repository root, start the Notebook server with ``jupyter notebook``.

## Contributions

This repository is mainly for my own purpose but I would be happy to share some thoughts with you. There are probably many ways to improve and tune the various neural nets.

To do so, just fork this repository.

## Credits

+ all the assignments come from [Udacity][udacity-deep-learning] and the [TensorFlow repository][tensorflow-repo]
+ the weird fonts dataset used for this image recognition is the [notMNIST dataset][notmnist] from Yaroslav Bulatov (there are also a download mirrors for the [large][notmnist-large] and [small][notmnist-small] dataset)
+ the final neural network of the assignment #4 is loosely inspired by the notorious LeNet-5, as described in the research paper ["Gradient-Based Learning Applied to Document Recognition"][lenet-5] by Y. LeCun, L. Bottou, Y. Bengio and P. Haffner

[udacity-deep-learning]: https://www.udacity.com/course/deep-learning--ud730
[udacity-nanodegree]: https://www.udacity.com/nanodegree

[jupyter]: http://jupyter.org/
[anaconda]: https://www.continuum.io/
[tensorflow-anaconda-install]: https://www.tensorflow.org/versions/r0.9/get_started/os_setup.html#anaconda-installation
[tensorflow-repo]: https://github.com/tensorflow/tensorflow/tree/master/tensorflow/examples/udacity

[notmnist]: http://yaroslavvb.blogspot.fr/2011/09/notmnist-dataset.html
[notmnist-large]: http://commondatastorage.googleapis.com/books1000/notMNIST_large.tar.gz
[notmnist-small]: http://commondatastorage.googleapis.com/books1000/notMNIST_small.tar.gz
[lenet-5]: http://yann.lecun.com/exdb/publis/pdf/lecun-98.pdf

[tsne-word-vectors]: https://raw.githubusercontent.com/Arn-O/udacity-deep-learning/master/assets/img/word-similarities-tsne.png "t-SNE projection of word vectors clustered by similarities"
