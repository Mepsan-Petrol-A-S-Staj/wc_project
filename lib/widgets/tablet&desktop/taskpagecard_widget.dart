import 'package:flutter/material.dart';

import '../../shared/constant_shared.dart';
import '../../shared/list_shared.dart';

class TaskPageTabletandDesktopCardWidget extends StatelessWidget {
  const TaskPageTabletandDesktopCardWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          SharedConstants.taskPageTitle,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Padding(
          padding:
              EdgeInsets.only(top: height * SharedConstants.generalPadding),
          child: Row(
            children: [
              for (int i = 0; i < 2; i++)
                Expanded(
                  child: Card(
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
                          Padding(
                            padding: EdgeInsets.only(
                              top: height * SharedConstants.generalPadding,
                            ),
                            child: ListTile(
                              leading: Icon(
                                SharedList.taskPageCardWidgetIconList[i],
                                color: i == 0 ? Colors.red : Colors.green,
                              ),
                              title: Text(
                                "Task:",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              subtitle: Text(
                                "Task Description",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              trailing: i == 0
                                  ? Checkbox(
                                      value: false, onChanged: (value) {})
                                  : IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.settings_backup_restore_rounded,
                                        color: Colors.red,
                                        size:
                                            height * SharedConstants.mediumSize,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
