import 'package:flutter/material.dart';
import 'package:forcam_mdc_generator/pages/dcu_selector.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Forcam Force MDC Generator',
      debugShowCheckedModeBanner: false,
      home: DCUSelector(title: 'Force MDC Template Generator'),
    );
  }
}