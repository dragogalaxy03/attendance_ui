import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'leave-data.dart';
import 'leave-request.dart';
class LeaveList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Decode JSON data from external file
    List<dynamic> leaveRequests = jsonDecode(leaveJson);

    return Scaffold(
      appBar: AppBar(
        title: Text("Leave Details",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: CupertinoColors.activeBlue,
      ),
      backgroundColor: Colors.grey,
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: leaveRequests.length,
        itemBuilder: (context, index) {
          return LeaveCard(data: leaveRequests[index]);
        },
      ),
    );
  }
}