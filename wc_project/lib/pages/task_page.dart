import 'package:flutter/material.dart';
import 'package:wc_project/shared/constants_shared.dart';

import '../shared/list_shared.dart';

class TaskPage extends StatelessWidget {
  final double height, width;
  const TaskPage({
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool value = false;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * SharedConstants.generalPadding,
        vertical: height * SharedConstants.generalPadding,
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
                        height * SharedConstants.generalPadding,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * SharedConstants.generalPadding,
                        vertical: height * SharedConstants.generalPadding,
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
                              onChanged: (newValue) {
                                value = newValue ?? false;
                              },
                            ),
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
              top: height * SharedConstants.generalPadding,
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
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
