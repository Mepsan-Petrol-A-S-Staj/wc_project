import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/providers/pageindex_provider.dart';

class DeviceSavePage extends StatefulWidget {
  final double height, width;
  const DeviceSavePage({
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  DeviceSavePageState createState() => DeviceSavePageState();
}

class DeviceSavePageState extends State<DeviceSavePage> {
  late TextEditingController _controller;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    // SharedPreference'dan devicenum değerini al ve eğer varsa TextField'a set et
    String? deviceNum = _prefs.getString('devicenum');
    if (deviceNum != null) {
      _controller.text = deviceNum;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            'Cihaz Kaydet',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Cihaz Numarası',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              String deviceNumber = _controller.text;
              await _prefs.setString('devicenum', deviceNumber);
              await _prefs.setBool('savedDevice', true);

              int index = 0;
              Provider.of<PageIndexProvider>(context, listen: false)
                  .setIndex(index);
            },
            child: const Text('Cihaz Kaydet'),
          ),
        ],
      ),
    );
  }
}
