class DistanceDuration_model {
  DistanceDuration_model({
    required this.destinationAddresses,
    required this.originAddresses,
    required this.rows,
    required this.status,
  });
  late final List<String> destinationAddresses;
  late final List<String> originAddresses;
  late final List<Rows> rows;
  late final String status;

  DistanceDuration_model.fromJson(Map<String, dynamic> json){
    destinationAddresses = List.castFrom<dynamic, String>(json['destination_addresses']);
    originAddresses = List.castFrom<dynamic, String>(json['origin_addresses']);
    rows = List.from(json['rows']).map((e)=>Rows.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['destination_addresses'] = destinationAddresses;
    _data['origin_addresses'] = originAddresses;
    _data['rows'] = rows.map((e)=>e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class Rows {
  Rows({
    required this.elements,
  });
  late final List<Elements> elements;

  Rows.fromJson(Map<String, dynamic> json){
    elements = List.from(json['elements']).map((e)=>Elements.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['elements'] = elements.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Elements {
  Elements({
    required this.distance,
    required this.duration,
    required this.status,
  });
  late final Distance distance;
  late final Duration duration;
  late final String status;

  Elements.fromJson(Map<String, dynamic> json){
    distance = Distance.fromJson(json['distance']);
    duration = Duration.fromJson(json['duration']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['distance'] = distance.toJson();
    _data['duration'] = duration.toJson();
    _data['status'] = status;
    return _data;
  }
}

class Distance {
  Distance({
    required this.text,
    required this.value,
  });
  late final String text;
  late final int value;

  Distance.fromJson(Map<String, dynamic> json){
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    _data['value'] = value;
    return _data;
  }
}

class Duration {
  Duration({
    required this.text,
    required this.value,
  });
  late final String text;
  late final int value;

  Duration.fromJson(Map<String, dynamic> json){
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    _data['value'] = value;
    return _data;
  }
}