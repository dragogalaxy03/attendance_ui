import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeForm extends StatefulWidget {
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _attachmentController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _checkInTime;
  TimeOfDay? _checkOutTime;
  DateTime? _previousDate;

  // Dummy employee data
  final Map<String, dynamic> _employee = {
    "imageUrl": "https://www.shutterstock.com/image-photo/profile-picture-smiling-successful-young-260nw-2040223583.jpg",
    "name": "John Wick",
    "employeeId": "12345",
    "designation": "Software Engineer",
    "location": "Delhi"
  };

  @override
  void initState() {
    super.initState();
    _previousDate = DateTime.now().subtract(Duration(days: 1)); // Default value
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _previousDate = prefs.containsKey('previousDate')
          ? DateTime.parse(prefs.getString('previousDate')!)
          : _previousDate; // Use default value if no data is found
      _checkInTime = prefs.containsKey('checkInTime')
          ? TimeOfDay(hour: prefs.getInt('checkInHour')!, minute: prefs.getInt('checkInMinute')!)
          : null;
      _checkOutTime = prefs.containsKey('checkOutTime')
          ? TimeOfDay(hour: prefs.getInt('checkOutHour')!, minute: prefs.getInt('checkOutMinute')!)
          : null;
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('previousDate', _selectedDate?.toIso8601String() ?? '');
    if (_checkInTime != null) {
      prefs.setInt('checkInHour', _checkInTime!.hour);
      prefs.setInt('checkInMinute', _checkInTime!.minute);
    }
    if (_checkOutTime != null) {
      prefs.setInt('checkOutHour', _checkOutTime!.hour);
      prefs.setInt('checkOutMinute', _checkOutTime!.minute);
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context, bool isCheckIn) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInTime = picked;
        } else {
          _checkOutTime = picked;
        }
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _attachmentController.text = result.files.single.path ?? '';
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form Submitted Successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Attendance Form')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              //Employee Details Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(_employee["imageUrl"]!),
                        radius: 40,
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_employee["name"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text("ID: ${_employee["employeeId"]}"),
                          Text("Designation: ${_employee["designation"]}"),
                          Text("Location: ${_employee["location"]}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              //Previous Check-In/Out Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Previous Check-in/Check-out", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 8),
                      // Text("Date: ${_previousDate != null ? _previousDate!.toLocal().toString().split(' ')[0] : 'Not available'}"),
                      // Text("Check-in: ${_checkInTime?.format(context) ?? 'Not available'}"),
                      // Text("Check-out: ${_checkOutTime?.format(context) ?? 'Not available'}"),
                      Text("Date: 2025-02-20"),
                      Text("Check-in: 09:30 AM"),
                      Text("Check-out: 06:30 PM")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              //Date
              Text('Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListTile(
                  title: Text(_selectedDate == null
                      ? 'Select Date'
                      : '${_selectedDate!.toLocal()}'.split(' ')[0]),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => _pickDate(context),
                ),
              ),
              SizedBox(height: 16),
              //Select Check-in/out
              Text('Check-in & Check-out Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        title: Text(_checkInTime == null
                            ? 'Check-In'
                            : _checkInTime!.format(context)),
                        trailing: Icon(Icons.access_time),
                        onTap: () => _pickTime(context, true),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        title: Text(_checkOutTime == null
                            ? 'Check-Out'
                            : _checkOutTime!.format(context)),
                        trailing: Icon(Icons.access_time),
                        onTap: () => _pickTime(context, false),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              //Attachment
              Text('Attachment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextFormField(
                controller: _attachmentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: _pickFile,
                  ),
                ),
                readOnly: true,
              ),
              SizedBox(height: 16),
              //Comments
              Text('Comments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextFormField(
                controller: _commentController,
                decoration: InputDecoration(border: OutlineInputBorder()),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              //Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}