class Device {
  final String ip;
  final String floor;
  final String name;

  Device({
    required this.ip,
    required this.floor,
    required this.name,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      ip: json['ip'],
      floor: json['floor'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ip': ip,
      'floor': floor,
      'name': name,
    };
  }
}


