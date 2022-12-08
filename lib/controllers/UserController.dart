import 'package:get/get.dart';

class UserController extends GetxController {
  var mail = "".obs;
  var name = "".obs;

  setMail(String adress) {
    mail.value = adress;
    mail.refresh();
  }

  setName(String displayName) {
    name.value = displayName;
    name.refresh();
  }
}
