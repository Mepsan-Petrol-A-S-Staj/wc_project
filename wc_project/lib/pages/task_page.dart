import 'package:flutter/material.dart';
import 'package:wc_project/shared/constants_shared.dart';

import '../shared/list_shared.dart';

class TaskPage extends StatefulWidget {
  final double height, width;
  const TaskPage({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.width * SharedConstants.generalPadding,
        vertical: widget.height * SharedConstants.generalPadding,
      ),
      child: Column(
        children: [
          Row(
            children: [
              for (int i = 0; i < 2; i++)
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        widget.height * SharedConstants.generalPadding,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            widget.width * SharedConstants.generalPadding,
                        vertical:
                            widget.height * SharedConstants.generalPadding,
                      ),
                      child: Column(
                        children: [
                          Text(
                            SharedList.taskPageCardTextList[i],
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          ListTile(
                            leading: Text(
                              "1",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            title: Text(
                              "Görev",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            subtitle: Text(
                              "Görev Detayı",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            trailing: Checkbox(
                                value: value,
                                onChanged: (value) {
                                  value = !value!;
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: widget.height * SharedConstants.generalPadding,
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text(
                'Anaekrana Dön!',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
