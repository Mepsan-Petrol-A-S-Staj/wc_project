import 'package:flutter/material.dart';
import 'package:wc_project/shared/constant_shared.dart';

import '../shared/list_shared.dart';

class TaskPage extends StatelessWidget {
  final double height, width;
  const TaskPage({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * SharedConstants.generalPadding,
        vertical: height * SharedConstants.generalPadding,
      ),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                height * SharedConstants.mediumSize,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: height > width
                    ? height * SharedConstants.generalPadding
                    : width * SharedConstants.generalPadding,
                horizontal: width > height
                    ? width * SharedConstants.generalPadding
                    : height * SharedConstants.generalPadding,
              ),
              child: Column(
                children: [
                  Text(
                    SharedConstants.taskPageTitle,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  for (int i = 0;
                      i < SharedList.taskPageCardTextList.length;
                      i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          SharedList.taskPageCardTextList[i],
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        for (int i = 0; i < 10; i++)
                          ListTile(
                            title: Text(
                              'Task $i',
                            ),
                            subtitle: Text(
                              'Task $i description',
                            ),
                            trailing: Checkbox(
                              value: false,
                              onChanged: (bool? value) {},
                            ),
                          ),
                      ],
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
