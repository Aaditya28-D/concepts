import tensorflow as tf
from tensorflow.keras import layers, models

# Load and preprocess data
(train_images, train_labels), (test_images, test_labels) = tf.keras.datasets.mnist.load_data()

train_images = train_images.reshape((60000, 28, 28, 1)).astype('float32') / 255
test_images = test_images.reshape((10000, 28, 28, 1)).astype('float32') / 255

train_labels = tf.keras.utils.to_categorical(train_labels)
test_labels = tf.keras.utils.to_categorical(test_labels)

# Build the neural network model
model = models.Sequential()
model.add(layers.Conv2D(32, (3, 3), activation='relu', input_shape=(28, 28, 1)))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.Conv2D(64, (3, 3), activation='relu'))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.Conv2D(64, (3, 3), activation='relu'))
model.add(layers.Flatten())
model.add(layers.Dense(64, activation='relu'))
model.add(layers.Dense(10, activation='softmax'))

# Compile the model
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])

# Train the model
model.fit(train_images, train_labels, epochs=5, batch_size=64, validation_split=0.2)

# Evaluate the model
test_loss, test_acc = model.evaluate(test_images, test_labels)
print(f'Test accuracy: {test_acc}')

# Make predictions
predictions = model.predict(test_images[:5])
print(predictions)


import numpy as np

# Assuming predictions is a list of predicted labels (e.g., output from model.predict())
predictions = np.argmax(model.predict(test_images), axis=1)

# Convert one-hot encoded test labels to integer labels
true_labels = np.argmax(test_labels, axis=1)

# Compare predictions with true labels
correct_predictions = np.equal(predictions, true_labels)

# Print the indices of correct and incorrect predictions
correct_indices = np.where(correct_predictions)[0]
incorrect_indices = np.where(~correct_predictions)[0]

print("Correctly predicted indices:", correct_indices)
print("Incorrectly predicted indices:", incorrect_indices)

# Access the actual values of correct and incorrect predictions
correct_labels = true_labels[correct_indices]
incorrect_labels = true_labels[incorrect_indices]

print("Correctly predicted labels:", correct_labels)
print("Incorrectly predicted labels:", incorrect_labels)
