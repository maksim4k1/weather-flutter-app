class Snow {
  double? d1h;

  Snow({this.d1h});

  Snow.fromJson(Map<String, dynamic> json) {
    final value = json['1h'];
    if (value != null) {
      if (value is int) {
        d1h = value.toDouble();
      } else if (value is double) {
        d1h = value;
      } else if (value is String) {
        d1h = double.tryParse(value);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (d1h != null) {
      data['1h'] = d1h;
    }
    return data;
  }
}
