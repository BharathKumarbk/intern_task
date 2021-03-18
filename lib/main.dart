import 'package:flutter/material.dart';
import 'package:interview_task/controllers/api_service.dart';
import 'package:provider/provider.dart';
import 'views/timetable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApiService>(
      create: (_) => ApiService(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
          ),
          home: Home()),
    );
  }
}
