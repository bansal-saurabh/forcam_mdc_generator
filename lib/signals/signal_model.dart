class SignalModel {
  String signal = "";
  String alias = "";
  // List<String> bus = [];

  SignalModel({required this.signal, required this.alias});

  SignalModel.fromJson(Map<String, dynamic> json) {
    signal = json['signal'];
    alias = json['alias'];
    // bus = json['bus'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signal'] = this.signal;
    data['alias'] = this.alias;
    // data['bus'] = this.bus;
    return data;
  }
}