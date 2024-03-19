import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/size_controller.dart';
import 'package:wc_project/shared/constant_shared.dart';
import 'package:wc_project/shared/list_shared.dart';

import '../services/controllers/loginpage_controller.dart';
import '../services/provider/all_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  final double height, width;

  const LoginPage({
    required this.height,
    required this.width,
    super.key,
  });
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // Clean up the focus nodes and controllers when the widget is disposed
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginPageController controller = LoginPageController(ref: ref);
    SizeController sizeController =
        SizeController(height: widget.height, width: widget.width);
    int screenType = sizeController.getScreenType(MediaQuery.of(context));
    return Column(
      children: [
        Text(
          SharedConstants.loginText,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenType == 0
                ? widget.width * SharedConstants.generalPadding
                : widget.width * SharedConstants.bigPadding * 5,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                widget.height * SharedConstants.generalPadding,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                widget.height * SharedConstants.generalPadding,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: widget.height * SharedConstants.generalPadding,
                    ),
                    child: TextField(
                      focusNode: usernameFocusNode,
                      controller: usernameController,
                      decoration: InputDecoration(
                        icon: SharedList.loginPageTextFieldIconList[0],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.height * SharedConstants.generalPadding,
                          ),
                        ),
                        hintText: SharedList.loginPageTextfieldHintTextList[0],
                        hintStyle: Theme.of(context).textTheme.displayMedium,
                      ),
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: widget.height * SharedConstants.generalPadding,
                    ),
                    child: TextField(
                      focusNode: passwordFocusNode,
                      controller: passwordController,
                      decoration: InputDecoration(
                        icon: SharedList.loginPageTextFieldIconList[1],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.height * SharedConstants.generalPadding,
                          ),
                        ),
                        hintText: SharedList.loginPageTextfieldHintTextList[1],
                        hintStyle: Theme.of(context).textTheme.displayMedium,
                      ),
                      onSubmitted: (_) => _submit(controller),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: widget.height * SharedConstants.generalPadding,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            widget.height * SharedConstants.generalPadding,
                          ),
                        ),
                      ),
                      onPressed: () => _submit(controller),
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

  void _submit(LoginPageController controller) {
    String username = usernameController.text;
    // String password = passwordController.text;
    int index = username == "admin" ? 4 : 2;
    ref.read(pageIndexProvider.notifier).update((state) => index);
    controller.login();
  }
}
