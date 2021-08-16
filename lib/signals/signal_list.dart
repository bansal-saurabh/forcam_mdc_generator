import 'package:flutter/material.dart';
import 'package:forcam_mdc_generator/models/signal.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'mtconnectprot.dart';

class SignalList extends StatefulWidget {
  final List<Signal> signals;
  final TextEditingController signalName;
  final TextEditingController signalGroup;
  final TextEditingController signalType;
  final TextEditingController signalAlias;
  final TextEditingController signalComment;

  SignalList(
      {Key? key,
      required this.signals,
      required this.signalName,
      required this.signalGroup,
      required this.signalType,
      required this.signalAlias,
      required this.signalComment})
      : super(key: key);

  // const SignalList(this.signals, this.signalName, this.signalGroup, this.signalType, this.signalAlias, this.signalComment);

  @override
  _SignalListState createState() => _SignalListState();
}

class _SignalListState extends State<SignalList> {
  late List<String> _signals;
  late List<String> _selectedSignalList;
  late String _selectedSignal;
  bool _enableTextField = false;
  late List<bool> _enableTextFieldList;
  late List<bool> _signalTypeChanged;

  MTConnectProt mtConnectProt = MTConnectProt();

  @override
  void initState() {
    _signals = mtConnectProt.getSignals();
    // _selectedSignalList = ['I', 'DBDX', 'DBDW2', 'DBREAL', 'DBSTRING'];
    _enableTextFieldList = List.generate(widget.signals.length, (index) => false);
    _selectedSignal = _signals.first;
    print(widget.signals.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.signals.isEmpty) {
      return Center(
        child: Text('No Signals created yet!'),
      );
    } else {
      print('Running now...');
      _selectedSignalList = List.generate(widget.signals.length, (index) => 'I');
      _signalTypeChanged = List.generate(widget.signals.length, (index) => false);
      _selectedSignalList.forEach((element) => print(element));

      return StaggeredGridView.countBuilder(
        crossAxisCount: 3,
        itemCount: widget.signals.length,
        itemBuilder: (BuildContext context, int index) {
          var signal = widget.signals[index];

          // _selectedSignalList = List.filled(widget.signals.length, 'I');
          // _enableTextFieldList = List.generate(widget.signals.length, (index) => false);

          // print(widget.signals.length);
          return _buildSignal(signal, index);
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      );
    }
  }

  Widget _buildSignal(Signal signal, int index) {
    if (index == widget.signals.length - 1) {
      widget.signalName.clear();
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: index == widget.signals.length - 1 ? widget.signalName : null,
                      // controller: widget.signalName,
                      decoration: InputDecoration(hintText: 'Name'),
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Signal Group'),
                    ),
                    DropdownButtonFormField(

                      // value: index !=  widget.signals.length - 1 ? _selectedSignalList[index] : 'I',
                      // onChanged: (String? value) {
                      //   setState(() {
                      //     _selectedSignalList[index] = value!;
                      //     _signalTypeChanged[index] = true;
                      //     _enableTextFieldList[index] = true;
                      //   });
                      // },
                      // => _onSelectedSignal(value!, index),
                      onChanged: (String? value) => _onSelectedSignal(value!, index),
                      items: _signals.map((String dropDownStringItem) {
                        // _signalTypeChanged = false;
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _signalTypeChanged[index] ? _selectedSignalList[index] : _selectedSignal,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Delay (on)'),
                    ),
                    TextField(
                      enabled: _enableTextFieldList[index],
                      // enabled: _enableTextField,
                      decoration: InputDecoration(hintText: 'Delay (off)'),
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Dead Band'),
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Alias'),
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Comment'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 30,
                          tooltip: 'Edit Signal',
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        ),
                        IconButton(
                          iconSize: 30,
                          tooltip: 'Copy Signal',
                          icon: Icon(Icons.add_to_photos),
                          onPressed: () {
                            // Hive.box<Signal>('signals').add(signal);
                          },
                        ),
                        IconButton(
                          iconSize: 30,
                          tooltip: 'Delete Signal',
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            signal.delete();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectedSignal(String value, int index) {
    setState(() {
      _selectedSignalList[index] = value;
      _signalTypeChanged[index] = true;
      _enableTextFieldList = List.generate(widget.signals.length, (index) => false);
      if (value == 'DBDX')
        _enableTextFieldList[index] = true;
      else
        _enableTextFieldList[index] = false;
    });
  }
}
