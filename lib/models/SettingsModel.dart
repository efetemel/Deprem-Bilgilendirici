class SettingsModel {
  bool? onlyQuakesFourAndAboveView;

  SettingsModel({this.onlyQuakesFourAndAboveView});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    onlyQuakesFourAndAboveView = json['onlyQuakesFourAndAboveView'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onlyQuakesFourAndAboveView'] = this.onlyQuakesFourAndAboveView;
    return data;
  }
}