import 'package:flutter/material.dart';
import 'package:forcam_mdc_generator/models/plugin_repository.dart';
import 'package:forcam_mdc_generator/io/dcu_generator.dart';

class DCUSignalSelector extends StatefulWidget {
  DCUSignalSelector({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _DCUSignalSelectorState createState() => _DCUSignalSelectorState();
}

class _DCUSignalSelectorState extends State<DCUSignalSelector> {
  final templateName = TextEditingController();
  final templateDesc = TextEditingController();

  PluginRepository repository = PluginRepository();

  List<String> _plugins = ["Plugin Types"];
  List<String> _busTypes = ["Bus Types"];

  String _selectedPlugin = "AUDI_SPS";
  String _selectedBus = "AUDI_SPS_TCP";

  @override
  void initState() {
    _plugins = repository.getStates();
    _busTypes = repository.getBusByPlugin(_selectedPlugin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.0,
            ),
            Text(
              'Add DCU Signals',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 25.0,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(15.0)),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 600,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: templateName,
                            decoration:
                            InputDecoration(hintText: 'Name'),
                          ),
                          TextFormField(
                            controller: templateName,
                            decoration:
                            InputDecoration(hintText: 'Signal Group'),
                          ),
                          DropdownButtonFormField(
                            value: _selectedPlugin,
                            onChanged: (String? value) =>
                                _onSelectedPlugin(value!),
                            items: _plugins.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                          ),
                          DropdownButtonFormField(
                            value: _selectedBus,
                            onChanged: (String? value) =>
                                _onSelectedBus(value!),
                            items: _busTypes.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                            controller: templateDesc,
                            decoration:
                            InputDecoration(hintText: 'Alias'),
                          ),
                          TextFormField(
                            controller: templateDesc,
                            decoration:
                            InputDecoration(hintText: 'Comment'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                _writeJavisController();
                // print(templateName.text + " " + _selectedPlugin + " " + _selectedBus + " " + templateDesc.text);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _writeJavisController() {
    print(templateName.text +
        " " +
        _selectedPlugin +
        " " +
        _selectedBus +
        " " +
        templateDesc.text);

    final DCUGenerator storage = DCUGenerator();

    storage.writeFile(templateName.text, _selectedPlugin, _selectedBus);
  }

  void _onSelectedPlugin(String value) {
    setState(() {
      _selectedPlugin = value;
      _busTypes = repository.getBusByPlugin(value);
      _selectedBus = _busTypes.first;
    });
  }

  void _onSelectedBus(String value) {
    setState(() => _selectedBus = value);
  }
}