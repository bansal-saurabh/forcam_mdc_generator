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
      "plugin": "AUDI_SPS",
      "alias": "AUDI_SPS",
      "bus": [
        "AUDI_SPS_TCP",
      ]
    },
    {
      "plugin": "MDE_UDP_CTRL_01",
      "alias": "MDE_UDP_CTRL_01",
      "bus": [
        "MDE_UDP_PROT_01",
        "IBHLink",
      ]
    },
    {
      "plugin": "HDH",
      "alias": "HDH",
      "bus": [
        "HDHLNK",
      ]
    },
    {
      "plugin": "IBX",
      "alias": "IBX",
      "bus": [
        "IBX_TCP",
      ]
    },
    {
      "plugin": "IOS",
      "alias": "IOS",
      "bus": [
        "IOSCOM",
      ]
    },
    {
      "plugin": "MTCONNECT",
      "alias": "MTCONNECT",
      "bus": [
        "MTCONNECTPROT",
      ]
    },
    {
      "plugin": "OPC_DA_1",
      "alias": "OPC_DA_1",
      "bus": [
        "OPC_DA_1PROT",
      ]
    },
    {
      "plugin": "OPCDAXML",
      "alias": "OPCDAXML",
      "bus": [
        "OPCDAXML_PROT",
      ]
    },
    {
      "plugin": "S5_1XX",
      "alias": "S5_1XX",
      "bus": [
        "IBHLINK_S5",
        "IBX_TCP_PF",
        "IPS5LNK",
        "SIMATIC_TCP",
      ]
    },
    {
      "plugin": "S7_200",
      "alias": "S7_200",
      "bus": [
        "DDES7LNK",
        "IBX_TCP_PF",
        "IPS7LNK",
        "MPIS7LNK",
      ]
    },
    {
      "plugin": "S7_300",
      "alias": "S7_300",
      "bus": [
        "DDES7LNK",
        "IBHLINK_S7",
        "IBX_TCP_PF",
        "IPS7LNK",
        "MPIS7LNK",
        "SIMATIC_TCP",
      ]
    },
    {
      "plugin": "S7_400",
      "alias": "S7_400",
      "bus": [
        "DDES7LNK",
        "IBHLINK_S7",
        "IBX_TCP_PF",
        "IPS7LNK",
        "MPIS7LNK",
        "SIMATIC_TCP",
      ]
    },
    {
      "plugin": "S7_1200",
      "alias": "S7_1200",
      "bus": [
        "DDES7LNK",
        "IBHLINK_S7",
        "IBX_TCP_PF",
        "IPS7LNK",
        "MPIS7LNK",
        "SIMATIC_TCP",
      ]
    },
    {
      "plugin": "S7_1500",
      "alias": "S7_1500",
      "bus": [
        "DDES7LNK",
        "IBHLINK_S7",
        "IBX_TCP_PF",
        "IPS7LNK",
        "MPIS7LNK",
        "SIMATIC_TCP",
      ]
    },
    {
      "plugin": "FANUC10",
      "alias": "FANUC10",
      "bus": [
        "FANUCFOCAS12",
      ]
    },
    {
      "plugin": "ROCKWELL",
      "alias": "ROCKWELL",
      "bus": [
        "ROCKWELLPROT",
      ]
    },
    {
      "plugin": "OPCUA",
      "alias": "OPCUA",
      "bus": [
        "OPCUAPROT",
      ]
    },
    {
      "plugin": "DATAEXCHANGE",
      "alias": "DATAEXCHANGE",
      "bus": [
        "DATAEXCHANGEPROT",
      ]
    },
    {
      "plugin": "MQTT",
      "alias": "MQTT",
      "bus": [
        "MQTTPROT",
      ]
    },
  ];
}