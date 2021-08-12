import 'plugin_model.dart';

class PluginRepository {
  List getAll() => _dcuplugins;

  getBusByPlugin(String plugin) => _dcuplugins
      .map((map) => PluginModel.fromJson(map))
      .where((item) => item.plugin == plugin)
      .map((item) => item.bus)
      .expand((i) => i)
      .toList();

  List<String> getStates() => _dcuplugins
      .map((map) => PluginModel.fromJson(map))
      .map((item) => item.plugin)
      .toList();

  List _dcuplugins = [
    {
      "plugin": "S7-1200",
      "alias": "S7-1200",
      "bus": [
        "IPS7Link",
        "IBHLink",
      ]
    },
    {
      "plugin": "S7-1500",
      "alias": "S7-1500",
      "bus": [
        "IPS7Link",
        "IBHLink",
      ]
    },
    {
      "plugin": "OPC UA",
      "alias": "OPC UA",
      "bus": [
        "OPCUA Prot",
      ]
    },
    {
      "plugin": "OPC DA",
      "alias": "OPC DA",
      "bus": [
        "OPCDA Prot",
      ]
    },
    {
      "plugin": "RPCSinumerik",
      "alias": "RPCSinumerik",
      "bus": [
        "RPC Bus",
      ]
    },
  ];
}