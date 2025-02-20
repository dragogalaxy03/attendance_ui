import 'package:flutter/material.dart';

import '../Employee Card/employee-card.dart';
import '../Employee Model/employee-model.dart';

class EmployeeScreen extends StatelessWidget {
  final List<Employee> employees = [
    Employee(
      imageUrl: 'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
      name: "Aanda S. Vitiello",
      position: "Joint Director",
      id: 820,
      present: 23,
      absent: 2,
      halfDay: 1,
      holiday: 1,
      weekend: 4,
      notavail: 0,
      debits: 1000,
      bonus: 500,
      overtimeHours: 12,
      overtimeWages: 1500,
      totalSalary: 31000,
    ),
    Employee(
      imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
      name: "Amy B. Clay",
      position: "Technical",
      id: 102,
      present: 25,
      absent: 1,
      halfDay: 0,
      holiday: 0,
      weekend: 4,
      notavail: 0,
      debits: 0,
      bonus: 300,
      overtimeHours: 6,
      overtimeWages: 624,
      totalSalary: 25924,
    ),
    Employee(
      imageUrl: 'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
      name: "Brville S. Martin",
      position: "Engineering Officer",
      id: 820,
      present: 24,
      absent: 1,
      halfDay: 0,
      holiday: 1,
      weekend: 4,
      notavail: 0,
      debits: 500,
      bonus: 0,
      overtimeHours: 2,
      overtimeWages: 400,
      totalSalary: 40000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employee Details")),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return EmployeeCard(employee: employee);
        },
      ),
    );
  }
}