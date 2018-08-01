import numpy as np
from keras.preprocessing import image
from keras.applications import resnet50

# Load Keras' ResNet50 model that was pre-trained against the ImageNet database
model =

# Load the image file, resizing it to 224x224 pixels (required by this model)
img =

# Convert the image to a numpy array
x =

# Add a forth dimension since Keras expects a list of images
x =

# Scale the input image to the range used in the trained network
x =

# Run the image through the deep neural network to make a prediction
predictions =

# Look up the names of the predicted classes. Index zero is the results for the first image.
predicted_classes =

print("This is an image of:")

for imagenet_id, name, likelihood in predicted_classes[0]:
    print(" - {}: {:2f} likelihood".format(name, likelihood))

