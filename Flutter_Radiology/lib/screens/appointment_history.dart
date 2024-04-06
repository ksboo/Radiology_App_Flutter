import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Appointment {
  final int appointmentID;
  final String physicianName;
  final String procedureType;
  final String appointmentDate;
  final String appointmentTime;

  Appointment({
    required this.appointmentID,
    required this.physicianName,
    required this.procedureType,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentID: json['AppointmentID'],
      physicianName: json['PhysicianName'],
      procedureType: json['ProcedureType'],
      appointmentDate: json['AppointmentDate'],
      appointmentTime: json['AppointmentTime'],
    );
  }
}
// print(appointmentID)

class AppointmentHistoryPage extends StatefulWidget {
  final int patientID;

  AppointmentHistoryPage({required this.patientID});

  @override
  _AppointmentHistoryPageState createState() => _AppointmentHistoryPageState();
}

class _AppointmentHistoryPageState extends State<AppointmentHistoryPage> {
  List<Appointment> appointments = [];

  @override
  void initState() {
    super.initState();
    fetchAppointmentHistory();
  }

  Future<void> fetchAppointmentHistory() async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:5000/patients/${widget.patientID}/appointments'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        appointments =
            data.map((item) => Appointment.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to fetch appointment history');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment History'),
      ),
      body: appointments.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: <Widget>[
                DataTable(
                  columns: [
                    DataColumn(label: Text('Appointment ID')),
                    DataColumn(label: Text('Physician')),
                    DataColumn(label: Text('Procedure Type')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Time')),
                  ],
                  rows: appointments.map((appointment) {
                    return DataRow(cells: [
                      DataCell(Text('${appointment.appointmentID}')),
                      DataCell(Text('${appointment.physicianName}')),
                      DataCell(Text('${appointment.procedureType}')),
                      DataCell(Text('${appointment.appointmentDate}')),
                      DataCell(Text('${appointment.appointmentTime}')),
                    ]);
                  }).toList(),
                ),
              ],
            ),
    );
  }
}
