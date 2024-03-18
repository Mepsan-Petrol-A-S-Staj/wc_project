import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wc_project/models/user_model.dart';
import 'package:wc_project/services/apis/user_service.dart';

import '../provider/all_provider.dart';

class LoginPageController {
  // Future<bool> userCheck(User user, WidgetRef ref) async {
  //   Future<Map<String, dynamic>> response =
  //       AuthService().login(user.username, user.password);
  //   response.then((value) {
  //     if (value['id'] != 0 && value['token'] != '') {
  //       ref.read(userIdProvider.notifier).update((state) => value['id']);
  //       ref.read(tokenProvider.notifier)
  //         ..update((state) => value['token'].toString());
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   });
  // }

  void isAFK(WidgetRef ref) async {
    int counter = ref.watch(afkTimeCounter);
    while (true) {
      counter = ref.watch(afkTimeCounter);
      if (counter == 15) {
        counterReset(ref);
        break;
      }
      // delay 1 second
      await Future.delayed(const Duration(seconds: 1));
      ref.read(afkTimeCounter.notifier).update((state) => state + 1);
    }
  }

  void counterReset(WidgetRef ref) {
    ref.read(afkTimeCounter.notifier).update((state) => 0);
  }
}
