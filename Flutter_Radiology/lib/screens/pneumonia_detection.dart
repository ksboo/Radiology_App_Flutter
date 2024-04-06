import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http; // yaml --> http: ^0.13.3
import 'package:flutter/services.dart' show ByteData, rootBundle;

class PneumoniaDetectionScreen extends StatefulWidget {
  @override
  _PneumoniaDetectionScreenState createState() =>
      _PneumoniaDetectionScreenState();
}

class _PneumoniaDetectionScreenState extends State<PneumoniaDetectionScreen> {
  dynamic _image;
  final picker = ImagePicker();
  TextEditingController patientIDController = TextEditingController();
  TextEditingController physicianIDController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  String predictionResult = '';

  Future<void> sendImageToServer() async {
    // Replace the URL with your Flask server URL
    final String apiUrl = 'http://127.0.0.1:5000/predict';

    //converting the png image into base64_encoded_image_data
    // Replace 'path/to/your/image.png' with the actual path to your PNG image file
     String imagePath = 'assets/image1.jpeg';
    //  String imagePath = 'assets/portrait-white-man-isolated_53876-40306.png';

    String base64Image = ''; // Declare the variable outside the try block

    try {
      // Read the PNG image file as bytes using rootBundle
      List<int> imageBytes = await rootBundle
          .load(imagePath)
          .then((ByteData data) => data.buffer.asUint8List());

      // Encode the image bytes to base64
      base64Image = base64Encode(imageBytes);

      // Print or use the base64-encoded image string as needed
      print('Base64-encoded image data:\n$base64Image');
    } catch (e) {
      print('Error reading or encoding the image: $e');
    }

// Now you can use the base64Image variable outside the try block
    final String imageBase64 = base64Image;

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/predictPneumonia'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': imageBase64}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          predictionResult = data['result'];
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile;
    });

    // Check if running on web
    if (kIsWeb && pickedFile != null) {
      // Read the selected image file as a data URL
      final reader = html.FileReader();
      reader.onLoadEnd.listen((event) {
        final imageDataUrl = reader.result as String?;
        setState(() {
          _image = imageDataUrl;
        });
      });
      reader.onError.listen((error) => print(error));
      final Uint8List imageData = await pickedFile!.readAsBytes();
      reader.readAsDataUrl(html.Blob([imageData]));
    }
  }

  Future<void> _uploadData() async {
    if (_image == null) {
      print('No image selected.');
      return;
    }

    String? base64Image;

    if (_image is XFile) {
      List<int> imageBytes = await (_image as XFile).readAsBytes();
      base64Image = base64Encode(imageBytes);
    } else if (_image is String) {
      // For web, _image is a data URL
      base64Image = _image as String;
    } else {
      print('Unsupported image type: ${_image.runtimeType}');
      return;
    }

    var data = {
      'image': base64Image,
      'patient_id': patientIDController.text,
      'physician_id': physicianIDController.text,
      'remarks': remarksController.text,
    };

    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:5000/upload'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print(patientIDController.text);
        print('Data uploaded successfully');
      } else {
        print('Failed to upload data');
      }
    } catch (e) {
      print('Error uploading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pneumonia Detection'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _image != null
                ? kIsWeb
                    ? Image.network(
                        _image,
                        height: 200,
                      )
                    : Image.file(
                        _image,
                        height: 200,
                      )
                : Text('No image selected.'),
            ElevatedButton(
              onPressed: getImage,
              child: Text('Select Image'),
            ),
            TextField(
              controller: patientIDController,
              decoration: InputDecoration(labelText: 'Patient ID'),
            ),
            TextField(
              controller: physicianIDController,
              decoration: InputDecoration(labelText: 'Physician ID'),
            ),
            TextField(
              controller: remarksController,
              decoration: InputDecoration(labelText: 'Remarks'),
            ),
            ElevatedButton(
              onPressed: () {
                sendImageToServer();
                _uploadData;
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Success'),
                      content: Text('Data Uploaded Sucessfully'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
              },
              child: Text('Upload Data'),
            ),
            SizedBox(height: 20),
            Text('Prediction Result: $predictionResult'),
          ],
        ),
      ),
    );
  }
}

// class YourButtonScreen extends StatefulWidget {
//   @override
//   _YourButtonScreenState createState() => _YourButtonScreenState();
// }

// class _YourButtonScreenState extends State<YourButtonScreen> {
//   String predictionResult = '';

//   Future<void> sendImageToServer() async {
//     // Replace the URL with your Flask server URL
//     final String apiUrl = 'http://127.0.0.1:5000/predict';

//     //converting the png image into base64_encoded_image_data
//     // Replace 'path/to/your/image.png' with the actual path to your PNG image file
//      String imagePath = 'assets/test_2.png';
//     //  String imagePath = 'assets/portrait-white-man-isolated_53876-40306.png';

//     String base64Image = ''; // Declare the variable outside the try block

//     try {
//       // Read the PNG image file as bytes using rootBundle
//       List<int> imageBytes = await rootBundle
//           .load(imagePath)
//           .then((ByteData data) => data.buffer.asUint8List());

//       // Encode the image bytes to base64
//       base64Image = base64Encode(imageBytes);

//       // Print or use the base64-encoded image string as needed
//       print('Base64-encoded image data:\n$base64Image');
//     } catch (e) {
//       print('Error reading or encoding the image: $e');
//     }

// // Now you can use the base64Image variable outside the try block
//     final String imageBase64 = base64Image;

//     try {
//       final response = await http.post(
//         Uri.parse('http://127.0.0.1:5000/predict'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'image': imageBase64}),
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         setState(() {
//           predictionResult = data['result'];
//         });
//       } else {
//         print('Error: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Flutter App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 sendImageToServer();
//               },
//               child: Text('Run Python Code'),
//             ),
//             SizedBox(height: 20),
//             Text('Prediction Result: $predictionResult'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: YourButtonScreen(),
//   ));
// }
