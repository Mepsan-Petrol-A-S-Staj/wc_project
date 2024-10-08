import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/services/controllers/size_controller.dart';
import 'package:wc_project/shared/constant_shared.dart';
import 'package:wc_project/shared/list_shared.dart';

import '../services/controllers/pages/loginpage_controller.dart';
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
  final TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode(),
      passwordFocusNode = FocusNode();

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
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    LoginPageController controller = LoginPageController(ref: ref);
    SizeController sizeController = SizeController(
        height: mediaQueryData.size.height, width: mediaQueryData.size.width);
    int screenType = sizeController.getScreenType(mediaQueryData);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.height * SharedConstants.generalPadding,
          ),
          child: Text(
            SharedConstants.loginText,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenType == 0
                ? widget.width * SharedConstants.generalPadding
                : widget.width * SharedConstants.bigPadding * 3,
          ),
          child: Card(
            elevation: 5,
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
                        icon: SharedList.loginPageTextFieldIconList.first,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.height * SharedConstants.generalPadding,
                          ),
                        ),
                        hintText:
                            SharedList.loginPageTextfieldHintTextList.first,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w300),
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
                        icon: (SharedList.loginPageTextFieldIconList.last),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.height * SharedConstants.generalPadding,
                          ),
                        ),
                        hintText:
                            SharedList.loginPageTextfieldHintTextList.last,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w300),
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
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
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

  void _submit(LoginPageController controller) async {
    String username = usernameController.text,
        password = passwordController.text;
    LoginResult result = await controller.login(username, password);
    if (result == LoginResult.userNotFound) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(SharedConstants.userNotFounded),
          duration: Duration(seconds: 2),
        ),
      );
    }

  }
}
