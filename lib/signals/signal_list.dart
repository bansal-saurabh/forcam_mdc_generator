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
  String _selectedSignal = "I";
  bool _enableTextField = false;

  MTConnectProt mtConnectProt = MTConnectProt();

  @override
  void initState() {
    _signals = mtConnectProt.getSignals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.signals.isEmpty) {
      return Center(
        child: Text('No Signals created yet!'),
      );
    } else {
      return StaggeredGridView.countBuilder(
        crossAxisCount: 3,
        itemCount: widget.signals.length,
        itemBuilder: (BuildContext context, int index) {
          var signal = widget.signals[index];
          return _buildSignal(signal);
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      );
    }
  }

  Widget _buildSignal(Signal signal) {
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
                    TextFormField(
                      controller: widget.signalName,
                      decoration: InputDecoration(hintText: 'Name'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Signal Group'),
                    ),
                    DropdownButtonFormField(
                      value: _selectedSignal,
                      onChanged: (String? value) => _onSelectedSignal(value!),
                      items: _signals.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Delay (on)'),
                    ),
                    TextFormField(
                      enabled: _enableTextField,
                      decoration: InputDecoration(hintText: 'Delay (off)'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Dead Band'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Alias'),
                    ),
                    TextFormField(
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

  void _onSelectedSignal(String value) {
    setState(() {
      _selectedSignal = value;
      if (value == 'DBDX')
        _enableTextField = true;
      else
        _enableTextField = false;
    });
  }
}
