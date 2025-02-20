import 'package:flutter/material.dart';
import 'package:mobile_task/Employee%20Form/employee-form.dart';
import 'package:mobile_task/Employee%20Screen/employee-screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: EmployeeForm(),
    );
  }
}

