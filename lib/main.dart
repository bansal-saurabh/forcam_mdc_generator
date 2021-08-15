import 'package:flutter/material.dart';
import 'package:forcam_mdc_generator/models/signal.dart';
import 'package:forcam_mdc_generator/pages/dcu_template_selector.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SignalAdapter());

  await Hive.openBox<Signal>('signals');
  await Hive.openBox('settings');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Forcam Force MDC Generator',
      debugShowCheckedModeBanner: false,
      home: DCUTemplateSelector(title: 'Force MDC Template Generator'),
    );
  }
}
