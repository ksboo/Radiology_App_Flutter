import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _patientIdController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _procedureTypeController = TextEditingController();

  Future<void> bookAppointment() async {
    const url = 'http://127.0.0.1:5000/book_appointment';
    var data = {
      'PatientID': _patientIdController.text,
      'AppointmentDate': _dateController.text,
      'AppointmentTime': _timeController.text,
      'ProcedureType': _procedureTypeController.text
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Appointment booked successfully');
    } else {
      print('Failed to book appointment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
        backgroundColor: Color.fromRGBO(218, 234, 226, 1),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _patientIdController,
                decoration: InputDecoration(labelText: 'Patient ID'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Patient ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Appointment Date'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Appointment Date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Appointment Time'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Appointment Time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _procedureTypeController,
                decoration: InputDecoration(labelText: 'Procedure Type'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Procedure Type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    bookAppointment();
                  }
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Success'),
                      content: Text('Appointment Booked Successfully!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(218, 234, 226, 1),
                ),
                child: Text('Book Appointment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
