import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kodulartools/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/UserController.dart';

class RegisterService {
  final UserController _userCtrl = Get.find();
  final _dio = Dio();
  Future authUser(
      {required String mail,
      required String pass1,
      required String pass2,
      required String method,
      required Function onError,
      required Function onAuth}) async {
    if (method == "register" && pass1 != pass2) {
      print(method);
      onError("Şifreler uyuşmuyor");
      return;
    }

    final result = await _dio
        .post("$kHostAdress/auth?mail=$mail&password=$pass1&method=$method");
    print(result.data);
    if (result.data == "OK") {
      await userLocal(mail: mail);
      onAuth();
    } else {
      onError(result.data);
    }
  }

  Future<bool> userLocal({String? mail, bool onlyCheck = false}) async {
    final prefs = await SharedPreferences.getInstance();
    // Mail kayıtlı değilse kaydet
    if (prefs.getString("mail") == null) {
      // ilk açılışta veri yoksa kapat
      if (onlyCheck) return false;
      await prefs.setString("mail", mail!);
      await prefs.setString("name", mail.split("@")[0]);
    }
    // ilk açılışta veya kayıt aşamasında verileri state'e kaydet
    _userCtrl.setMail(prefs.getString("mail")!);
    _userCtrl.setName(prefs.getString("name")!);
    return true;
  }
}
