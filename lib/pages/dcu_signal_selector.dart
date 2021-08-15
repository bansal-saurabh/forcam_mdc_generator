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

  var signalName = TextEditingController();

  String _selectedSignal = "I";
  bool _signalsAdded = false;

  @override
  void initState() {
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
          padding: const EdgeInsets.all(25.0),
          child: ValueListenableBuilder(
            valueListenable: Hive.box('settings').listenable(),
            builder: _buildWithBox,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Add New Signal',
        onPressed: () {
          if (!_signalsAdded) {
            var signal = Signal()
              ..name = ''
              ..signalGroup = ''
              ..type = ''
              ..alias = ''
              ..comment = '';

            Hive.box<Signal>('signals').add(signal);

            _signalsAdded = true;
            print(signalName.text);
          } else {
            var signal = Signal()
              ..name = 'IDLE'
              ..signalGroup = ''
              ..type = 'Boolean'
              ..alias = 'Idle Signal'
              ..comment = 'Idle = 1, when the machine is not running!';

            print(_signalsAdded);
            Hive.box<Signal>('signals').add(signal);
          }

        },
      ),
    );
  }

  void _writeJavisController() {
    print(templateName.text + " " + _selectedSignal + " " + templateDesc.text);

    final DCUGenerator storage = DCUGenerator();

    // storage.writeFile(templateName.text, _selectedSignal, _selectedSignal);
  }

  Widget _buildWithBox(BuildContext context, Box settings, Widget? child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'DCU Signals',
              style: Theme.of(context).textTheme.headline5,
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

              SignalList signalList = SignalList(signals, signalName);
              print(signalList.signalName.text);
              return signalList;
            },
          ),
        ),
      ],
    );
  }
}
