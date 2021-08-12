import 'signal_model.dart';

class MTConnectProt {
  List getAll() => _dcusignals;

  // getBusByPlugin(String plugin) => _dcuplugins
  //     .map((map) => PluginModel.fromJson(map))
  //     .where((item) => item.plugin == plugin)
  //     .map((item) => item.bus)
  //     .expand((i) => i)
  //     .toList();

  List<String> getSignals() => _dcusignals
      .map((map) => SignalModel.fromJson(map))
      .map((item) => item.signal)
      .toList();

  List _dcusignals = [
    {
      "signal": "I",
      "alias": "I",
    },
    {
      "signal": "DBDX",
      "alias": "DBDX",
    },
    {
      "signal": "DBDW2",
      "alias": "DBDW2",
    },
    {
      "signal": "DBREAL",
      "alias": "DBREAL",
    },
    {
      "signal": "DBSTRING",
      "alias": "DBSTRING",
    },
  ];
}