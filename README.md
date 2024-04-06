# Radiology System Manager - Flutter and Flask
This project is a radiology management system that facilitates patient, physician, and staff management, appointment scheduling, and image uploading with MongoDB integration for storing radiology images and related information.



## Installation:


### MySQL Installation:

1. Install MySQL on your system. You can download it from the official MySQL website: MySQL Downloads

2. Follow the installation instructions provided for your operating system.

3. During the installation process, set up a username and password for your MySQL database. Make a note of these credentials as you'll need them later.

### MongoDB Installation:

1. Install MongoDB on your system. You can download it from the official MongoDB website: MongoDB Downloads

2. Follow the installation instructions provided for your operating system.

### Flutter Installation

1. Install Flutter by following the instructions provided in the official Flutter documentation: Flutter - Get Started

2. Set up your preferred IDE for Flutter development. You can use Android Studio, Visual Studio Code, or any other IDE of your choice.

3. Ensure that Flutter and Dart SDKs are properly configured in your development environment.

### Setting up Database Credentials

1. Navigate to the Flask backend directory.

2. Open the 'app.py' file in a text editor.

3. Locate the following line:

        app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@New_123@localhost/radiologymanagementsystem'

4. Replace 'root' with your MySQL username, and '@New_123' with your MySQL password.

5. Save the changes to app.py.

### MongoDB Setup

1. Ensure that MongoDB server is running on your system. You can start the MongoDB server using the command mongod in your terminal.

2. Once MongoDB server is running, navigate to the MongoDB shell by typing mongo in your terminal.

3. Create a new database for the Radiology Management System by typing the following commands:

        use radiologymanagementsystem


### Running the Application
1. Start the Flask backend server by running the following command in the backend directory:

       python app.py

2.Start the Flutter frontend application by running the following command in the frontend directory:

      flutter run

3. Access the application from your web browser or mobile device.
