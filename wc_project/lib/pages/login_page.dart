import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wc_project/shared/constants_shared.dart';
import 'package:wc_project/shared/list_shared.dart';

import '../services/providers/pageindex_provider.dart';

class LoginPage extends StatelessWidget {
  final double height, width;
  const LoginPage({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          SharedConstants.loginText,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.25,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                height * SharedConstants.generalPadding,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                height * SharedConstants.generalPadding,
              ),
              child: Column(
                children: [
                  for (int i = 0; i < 2; i++)
                    // texfield outlineborder
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * SharedConstants.generalPadding,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          icon: SharedList.loginPageTextFieldIconList[i],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              height * SharedConstants.generalPadding,
                            ),
                          ),
                          hintText:
                              SharedList.loginPageTextfieldHintTextList[i],
                          hintStyle: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * SharedConstants.generalPadding,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        int index = 2;
                        Provider.of<PageIndexProvider>(context, listen: false)
                            .setIndex(index);
                      },
                      child: Text(
                        SharedConstants.loginText,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.2,
        )
      ],
    );
  }
}
