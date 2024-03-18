import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/shared/constant_shared.dart';
import 'package:wc_project/shared/list_shared.dart';

import '../services/controllers/loginpage_controller.dart';
import '../services/provider/all_provider.dart';

class LoginPage extends ConsumerWidget {
  final double height, width;
  const LoginPage({
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TextEditingController> controllers = [
      TextEditingController(),
      TextEditingController(),
    ];
    LoginPageController controller = LoginPageController(ref: ref);
    return Column(
      children: [
        Text(
          SharedConstants.loginText,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: height > width
                ? width * SharedConstants.generalPadding
                : height * SharedConstants.generalPadding,
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
                  for (int i = 0;
                      i < SharedList.loginPageTextfieldHintTextList.length;
                      i++)
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * SharedConstants.generalPadding,
                      ),
                      child: TextField(
                        controller: controllers[i],
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
                        String userAdmin = controllers[0].text;
                        int index = 0;
                        if (userAdmin == "admin") {
                          index = 4;
                        } else {
                          index = 2;
                        }
                        ref
                            .read(pageIndexProvider.notifier)
                            .update((state) => index);
                        controller.login();
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
      ],
    );
  }
}
