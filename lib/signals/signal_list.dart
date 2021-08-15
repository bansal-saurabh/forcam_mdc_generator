import 'package:flutter/material.dart';
import 'package:forcam_mdc_generator/models/signal.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';

import 'mtconnectprot.dart';

class SignalList extends StatefulWidget {
  final List<Signal> signals;

  const SignalList(this.signals);

  @override
  _SignalListState createState() => _SignalListState();
}

class _SignalListState extends State<SignalList> {
  late List<String> _signals;
  String _selectedSignal = "I";

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
          var Signal = widget.signals[index];
          return _buildSignal(Signal);
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
                      // controller: templateName,
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
}

void _onSelectedSignal(String value) {
  // setState(() {
  //   _selectedSignal = value;
  //   // _busTypes = repository.getBusByPlugin(value);
  //   // _selectedBus = _busTypes.first;
  // });
}
