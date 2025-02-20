import 'package:flutter/material.dart';

import '../Employee Model/employee-model.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  EmployeeCard({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Profile image, name and share Section
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    employee.imageUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${employee.name}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("${employee.position} (${employee.id})"),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 10),
            //Attendanec Related
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusBox("P", employee.present, Colors.green),
                _buildStatusBox("A", employee.absent, Colors.red),
                _buildStatusBox("H-D", employee.halfDay, Colors.orange),
                _buildStatusBox("H", employee.holiday, Colors.blue.shade300),
                _buildStatusBox("W", employee.weekend, Colors.purple.shade300),
                _buildStatusBox("N", employee.notavail, Colors.grey)
              ],
            ),
            Divider(),
            //Salary Related
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Debits: \$${employee.debits}"),
                    Text("Bonus: \$${employee.bonus}"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Overtime Hours: ${employee.overtimeHours}"),
                    Text("Overtime Wages: \$${employee.overtimeWages}"),
                    Text(
                      "Total Salary: \$${employee.totalSalary}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBox(String label, int value, Color color) {
     return Expanded(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            color: color,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              value.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
