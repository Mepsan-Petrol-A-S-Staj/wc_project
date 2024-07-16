class Device {
  final String ip, floor, name, deviceName;
  final int? id;
  Device({
    required this.ip,
    required this.floor,
    required this.name,
    required this.deviceName,
    this.id,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      ip: json['ip'],
      floor: json['floor'],
      name: json['name'],
      deviceName: json['deviceName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ip': ip,
      'floor': floor,
      'name': name,
      'deviceName': deviceName,
    };
  }
}
