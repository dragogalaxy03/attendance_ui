import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_task/LeaveRequestCard/leave-data.dart';


class LeaveCard extends StatelessWidget {
  final Map<String, dynamic> data;

  LeaveCard({required this.data});

  Color getStatusColor(String status) {
    switch (status) {
      case "ACCEPTED":
        return Colors.green;
      case "REJECTED":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case "ACCEPTED":
        return Colors.white;
      case "REJECTED":
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.only(bottom: 12),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(data["profileImage"]),
                  ),
                  title: Text(
                    data["name"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(data["designation"]),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: getStatusColor(data["status"]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      data["status"],
                      style: TextStyle(
                        color: getStatusTextColor(data["status"]),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Applied Date: ${data["appliedDate"]}'),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.event, size: 18, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Leave Date: ${data["leaveDate"]}'),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.description, size: 18, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(child: Text(data["reason"])),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}