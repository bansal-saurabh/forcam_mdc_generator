import 'package:flutter/material.dart';
import 'package:forcam_mdc_generator/io/dcu_generator.dart';
import 'package:forcam_mdc_generator/signals/mtconnectprot.dart';
import 'package:forcam_mdc_generator/signals/signal_list.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:forcam_mdc_generator/models/signal.dart';

class DCUSignalSelector extends StatefulWidget {
  DCUSignalSelector({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _DCUSignalSelectorState createState() => _DCUSignalSelectorState();
}

class _DCUSignalSelectorState extends State<DCUSignalSelector> {
  final templateName = TextEditingController();
  final templateDesc = TextEditingController();

  MTConnectProt mtConnectProt = MTConnectProt();

  List<String> _signals = ["Plugin Types"];
  // List<String> _busTypes = ["Bus Types"];

  String _selectedSignal = "I";
  // String _selectedBus = "AUDI_SPS_TCP";

  @override
  void initState() {
    _signals = mtConnectProt.getSignals();
    // _busTypes = repository.getBusByPlugin(_selectedSignal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ValueListenableBuilder(
            valueListenable: Hive.box('settings').listenable(),
            builder: _buildWithBox,
          ),
        ),
      ),
    );
  }

  void _writeJavisController() {
    print(templateName.text +
        " " +
        _selectedSignal +
        " " +
        templateDesc.text);

    final DCUGenerator storage = DCUGenerator();

    // storage.writeFile(templateName.text, _selectedSignal, _selectedSignal);
  }

  void _onSelectedSignal(String value) {
    setState(() {
      _selectedSignal = value;
      // _busTypes = repository.getBusByPlugin(value);
      // _selectedBus = _busTypes.first;
    });
  }

  Widget _buildWithBox(BuildContext context, Box settings, Widget? child) {
    // var reversed = settings.get('reversed', defaultValue: true) as bool;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Signals',
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 40),
        Expanded(
          child: ValueListenableBuilder<Box<Signal>>(
            valueListenable: Hive.box<Signal>('signals').listenable(),
            builder: (context, box, _) {
              var signals = box.values.toList().cast<Signal>();
              // if (reversed) {
              //   signals = signals.reversed.toList();
              // }
              return SignalList(signals);
            },
          ),
        ),
      ],
    );
  }

}
