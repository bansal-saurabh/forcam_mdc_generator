class PluginModel {
  String plugin = "";
  String alias = "";
  List<String> bus = [];

  PluginModel({required this.plugin, required this.alias, required this.bus});

  PluginModel.fromJson(Map<String, dynamic> json) {
    plugin = json['plugin'];
    alias = json['alias'];
    bus = json['bus'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plugin'] = this.plugin;
    data['alias'] = this.alias;
    data['bus'] = this.bus;
    return data;
  }
}