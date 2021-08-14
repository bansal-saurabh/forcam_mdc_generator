import 'package:flutter/material.dart';
import 'package:forcam_mdc_generator/models/signal.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SignalList extends StatelessWidget {
  final List<Signal> signals;

  const SignalList(this.signals);

  @override
  Widget build(BuildContext context) {
    if (signals.isEmpty) {
      return Center(
        child: Text('No Signals created yet!'),
      );
    } else {
      return StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: signals.length,
        itemBuilder: (BuildContext context, int index) {
          var Signal = signals[index];
          return _buildSignal(Signal);
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      signal.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      signal.signalGroup,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      signal.type,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.edit), onPressed: () {  },
                        ),
                        IconButton(
                          iconSize: 30,
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
