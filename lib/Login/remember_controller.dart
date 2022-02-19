import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hire_lawyer/Models/Users.dart';

class RememberController extends GetxController {
  void RememberClient(Cusers user) {
    var storage = GetStorage();
    token(1);
    storage.write("user", {
      'email': user.Email,
      'name': user.Name,
      'name': user.LastName,
      'url': user.Url
    });
  }

  void RememberLawyer(Cusers user) {
    var storage = GetStorage();
    token(2);
    storage.write("user",
        {'email': user.Email, 'name': user.Name, 'name': user.LastName});
  }

  void token(int index) {
    var storage = GetStorage();
    storage.write("auth", 1);
    storage.write("type_auth", index);
  }

  void Logout() {
    var storage = GetStorage();
    storage.write("auth", 0);
  }

  check() {
    var seen = GetStorage();
    seen.write("seen", 1);
  }
}
