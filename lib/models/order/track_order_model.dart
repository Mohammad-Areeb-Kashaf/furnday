class TrackOrderModel {
  TrackOrderModel({required this.title, required this.subtitle});
  late String title;
  late String subtitle;

  TrackOrderModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    return data;
  }
}
