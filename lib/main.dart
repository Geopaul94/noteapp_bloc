import 'package:flutter/material.dart';
import 'package:note_application/api_call/api_call.dart';
import 'package:note_application/home/ui/home_notelist.dart';

void main() async {
 
  await getall();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note Application',
        theme: ThemeData(
          primaryColor: Colors.tealAccent,
        ),
        home: const HomeNotelist());
  }
}
