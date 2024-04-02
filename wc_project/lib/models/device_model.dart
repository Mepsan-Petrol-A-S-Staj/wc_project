class Device {
  final String ip, floor, name;
  final int? id;
  Device({
    required this.ip,
    required this.floor,
    required this.name,
    this.id,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      ip: json['ip'],
      floor: json['floor'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ip': ip,
      'floor': floor,
      'name': name,
    };
  }
}
