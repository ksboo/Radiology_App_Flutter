from flask import Flask, request, jsonify
import cv2
import numpy as np
import base64
import tensorflow as tf

app = Flask(__name__)

# Assuming `model` is your TensorFlow model
model = tf.keras.models.load_model('/Users/khushbooshrivastava/Desktop/Projects/EL-Vth SEm/dbms_lab/model.h5')

@app.route('/predictPneumonia', methods=['POST'])
def predict():
    try:
        # Get the image data from the request
        request_data = request.get_json()
        image_data = request_data['image']

        # Ensure correct padding
        image_data += '=' * (len(image_data) % 4)

        # Remove whitespaces
        image_data = image_data.replace(' ', '')

        # Replace URL-safe characters
        image_data = image_data.replace('-', '+').replace('_', '/')

        # Decode base64 string to bytes
        image_bytes = base64.b64decode(image_data)

        # Convert bytes to numpy array using np.frombuffer
        image_np = np.frombuffer(image_bytes, np.uint8)

        # Decode the image using cv2.imdecode
        image = cv2.imdecode(image_np, cv2.IMREAD_COLOR)

        # Check if the image is loaded successfully
        if image is None:
            return jsonify({'error': 'Failed to load image'}), 400

        # Perform your image processing or model prediction here
        # Resize the image
        resized_image = tf.image.resize(tf.convert_to_tensor(image), (500, 500))
        # Normalize the resized image (assuming your model expects values in [0, 1])
        normalized_image = resized_image / 255.0

        # Expand dimensions to match the model's input shape
        input_image = tf.expand_dims(normalized_image, 0)

        # Make the prediction
        prediction = model.predict(input_image)

        if prediction > 0.5:
            result = 'valid'
        else:
            result = 'invalid'

        return jsonify({'result': result})
    except Exception as e:
        # Log or handle the exception appropriately
        print(f"Error: {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500

if __name__ == '__main__':
    app.run(debug=True)