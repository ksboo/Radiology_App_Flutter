import random
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy import Date, Time
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import func
from pymongo import MongoClient
import bcrypt
from flask_cors import CORS
import urllib.parse

app = Flask(__name__)

# Encode the MySQL password
encoded_password = urllib.parse.quote_plus("@New_123")

# Set the SQLAlchemy database URI
app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql://root:{encoded_password}@localhost/radiologymanagementsystem'
db = SQLAlchemy(app)

client = MongoClient('mongodb://localhost:27017/')
dbm = client['radiologymanagementsystem']
collection = dbm['xrayimages']

CORS(app)



class Patients(db.Model):
    __tablename__ = 'patients'
    PatientID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    FirstName = db.Column(db.String(255))
    LastName = db.Column(db.String(255))
    DateOfBirth = db.Column(db.Date)
    Gender = db.Column(db.Enum('Male', 'Female'))
    StreetNumber = db.Column(db.Integer)
    StreetName = db.Column(db.String(255))
    City = db.Column(db.String(255))
    Country = db.Column(db.String(255))
    ContactNumber = db.Column(db.String(255))
    Password = db.Column(db.String(60))  # Assuming hashed password will be stored as string

class Physicians(db.Model):
    __tablename__ = 'physicians'
    PhysicianID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    FirstName = db.Column(db.String(255))
    LastName = db.Column(db.String(255))
    Specialization = db.Column(db.String(255))
    ContactNumber = db.Column(db.String(255))
    Password = db.Column(db.String(60))

class Staff(db.Model):
    StaffID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    FirstName = db.Column(db.String(255))
    LastName = db.Column(db.String(255))
    StreetNumber = db.Column(db.Integer)
    StreetName = db.Column(db.String(255))
    City = db.Column(db.String(255))
    Country = db.Column(db.String(255))
    ContactNumber = db.Column(db.String(255))
    Role = db.Column(db.String(255))
    Password = db.Column(db.String(60))

class Appointments(db.Model):
    __tablename__ = 'appointments'
    AppointmentID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    PatientID = db.Column(db.Integer, db.ForeignKey('patients.PatientID'), nullable=False)
    PhysicianID = db.Column(db.Integer, db.ForeignKey('physicians.PhysicianID'), nullable=False)
    ProcedureType = db.Column(db.String(255))
    AppointmentDate = db.Column(db.Date)
    AppointmentTime = db.Column(db.Time)

    patient = relationship("Patients", foreign_keys=[PatientID])
    physician = relationship("Physicians", foreign_keys=[PhysicianID])


@app.route('/patient_login', methods=['POST'])
def patient_login():
    data = request.json
    contact_number = data.get('contactNumber')
    password = data.get('password')

    patient = Patients.query.filter_by(ContactNumber=contact_number).first()
    if patient:
        patient_password = patient.Password

        if patient_password == password:
            patient_data = {
                'patientid': patient.PatientID,
                'firstName': patient.FirstName,
                'lastName': patient.LastName,
                'contactNumber': patient.ContactNumber,
                'streetNumber': patient.StreetNumber,
                'streetName': patient.StreetName,
                'city': patient.City,
                'country': patient.Country
            }
            return jsonify(patient_data), 200
        else:
            return jsonify({'message': 'Invalid contact number or password'}), 401
    else:
        return jsonify({'message': 'User not found'}), 404
    
@app.route('/physician_login', methods=['POST'])
def physician_login():
    data = request.json
    contact_number = data.get('contactNumber')
    password = data.get('password')

    physician = Physicians.query.filter_by(ContactNumber=contact_number).first()
    if physician:
        physician_password = physician.Password

        if physician_password == password:
            physician_data = {
                'physicianid': physician.PhysicianID,
                'firstName': physician.FirstName,
                'lastName': physician.LastName,
                'contactNumber': physician.ContactNumber,
                'specialization': physician.Specialization,
            }
            return jsonify(physician_data), 200
        else:
            return jsonify({'message': 'Invalid contact number or password'}), 401
    else:
        return jsonify({'message': 'User not found'}), 404
    
@app.route('/staff_login', methods=['POST'])
def staff_login():
    data = request.json
    contact_number = data.get('contactNumber')
    password = data.get('password')

    staff = Staff.query.filter_by(ContactNumber=contact_number).first()
    if staff:
        staff_password = staff.Password

        if staff_password == password:
            staff_data = {
                'staffid': staff.StaffID,
                'firstName': staff.FirstName,
                'lastName': staff.LastName,
                'role': staff.Role,
                'contactNumber': staff.ContactNumber,
                'streetNumber': staff.StreetNumber,
                'streetName': staff.StreetName,
                'city': staff.City,
                'country': staff.Country
            }
            return jsonify(staff_data), 200
        else:
            return jsonify({'message': 'Invalid contact number or password'}), 401
    else:
        return jsonify({'message': 'User not found'}), 404


@app.route('/insert_patient', methods=['POST'])
def insert_patient():
    data = request.json

    raw_password = data['password']
    # Hash the password
    # hashed_password = bcrypt.hashpw(raw_password.encode('utf-8'), bcrypt.gensalt(5))
    
    patient = Patients(
        FirstName=data['firstName'],
        LastName=data['lastName'],
        DateOfBirth=data['dateOfBirth'],
        Gender=data['gender'],
        ContactNumber=data['contactno'],
        StreetNumber=data['streetNumber'],
        StreetName=data['streetName'],
        City=data['city'],
        Country=data['country'],
        Password=raw_password # Hash the password before storing
    )
    db.session.add(patient)
    db.session.commit()
    return 'Patient data inserted successfully'


@app.route('/patients', methods=['GET'])
def get_patients():
    patients = Patients.query.all()
    patient_list = [{
        'patientid': patient.PatientID,
        'firstName': patient.FirstName,
        'lastName': patient.LastName,
        'dateOfBirth': str(patient.DateOfBirth),
        'gender': patient.Gender,
        'streetNumber': patient.StreetNumber,
        'streetName': patient.StreetName,
        'city': patient.City,
        'country': patient.Country,
        'contactNumber': patient.ContactNumber
    } for patient in patients]
    return jsonify(patient_list)

@app.route('/book_appointment', methods=['POST'])
def book_appointment():
    data = request.json
    appointment_date = data.get('AppointmentDate')
    appointment_time = data.get('AppointmentTime')
    procedure_type = data.get('ProcedureType')

    # Select a random physician ID
    physician_ids = [physician.PhysicianID for physician in Physicians.query.all()]
    random_physician_id = random.choice(physician_ids)

    appointment = Appointments(
        PatientID=data.get('PatientID'),
        PhysicianID=random_physician_id,
        AppointmentDate=appointment_date,
        AppointmentTime=appointment_time,
        ProcedureType=procedure_type
    )

    db.session.add(appointment)
    db.session.commit()

    return 'Appointment booked successfully', 200

@app.route('/patients/<int:patient_id>/appointments', methods=['GET'])
def get_patient_appointments(patient_id):
    try:
        # Query the appointments for the given patient ID
        appointments = Appointments.query.filter_by(PatientID=patient_id).all()

        # Convert appointment objects to a list of dictionaries
        appointment_list = []
        for appointment in appointments:
            physician = Physicians.query.get(appointment.PhysicianID)
            appointment_dict = {
                'AppointmentID': appointment.AppointmentID,
                'PhysicianName': f"{physician.FirstName} {physician.LastName}",
                'ProcedureType': appointment.ProcedureType,
                'AppointmentDate': str(appointment.AppointmentDate),
                'AppointmentTime': str(appointment.AppointmentTime)
            }
            print(appointment.ProcedureType)
            appointment_list.append(appointment_dict)

        return jsonify(appointment_list)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/upload', methods=['POST'])
def upload_image():
    try:
        data = request.json
        image_base64 = data['image']
        patient_id = data['patient_id']
        physician_id = data['physician_id']
        remarks = data['remarks']

        # # Decode base64 image
        # image = decode_base64_image(image_base64)
        
        # # Preprocess image
        # image_array = image_preprocessor(image)
        
        # # Perform prediction
        # prediction = model_pred(image_array)
        # result = "Pneumonia" if prediction == 1 else "Normal"

        # Inserting data into MongoDB
        inserted_id = collection.insert_one({
            'image': image_base64,
            'patient_id': patient_id,
            'physician_id': physician_id,
            'remarks': remarks,
            # 'prediction': result  # Include prediction result in the database
        }).inserted_id

        print('Data uploaded successfully')
        return jsonify({'message': 'Data uploaded successfully', 'inserted_id': str(inserted_id)}), 200
    except Exception as e:
        print('Error:', e)
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
