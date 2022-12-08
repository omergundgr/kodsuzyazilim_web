import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodulartools/services/register_service.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class RegisterWidget extends StatefulWidget {
  late bool login;
  RegisterWidget({super.key, required this.login});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _t1 = TextEditingController();
  final _t2 = TextEditingController();
  final _t3 = TextEditingController();
  bool _errorVisible = false;
  String _errorMessage = "";

  void _onErrorMessage(String code) {
    setState(() {
      _errorMessage = code;
      _errorVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              width: 400,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              decoration: BoxDecoration(
                  color: kDarkBlackColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.login
                              ? "Aramıza Hoşgeldin!"
                              : "Tekrar Hoşgeldin!",
                          style: const TextStyle(
                              fontSize: 19,
                              fontFamily: "Raleway",
                              color: kBgColor),
                        ),
                      ),
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(widget.login
                          ? "Bir hesabın yok mu?"
                          : "Bir hesabın mı var?"),
                      TextButton(
                          onPressed: () =>
                              setState(() => widget.login = !widget.login),
                          child: Text(widget.login ? "Kayıt Ol" : "Giriş Yap"))
                    ],
                  ),
                  const SizedBox(height: 15),
                  _textField(
                      hint: "E-Posta Adresiniz",
                      controller: _t1,
                      keyboardType: TextInputType.emailAddress),
                  _textField(
                      hint: "Şifre Giriniz", controller: _t2, obscure: true),
                  if (!widget.login)
                    _textField(
                        hint: "Şifre Tekrar", controller: _t3, obscure: true),
                  const SizedBox(height: 30),
                  Visibility(
                      visible: _errorVisible,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      )),
                  ElevatedButton(
                    onPressed: () => RegisterService().authUser(
                        mail: _t1.text,
                        pass1: _t2.text,
                        pass2: _t3.text,
                        method: widget.login ? "login" : "register",
                        onError: _onErrorMessage,
                        onAuth: () => Get.back()),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5,
                        vertical: kDefaultPadding /
                            (Responsive.isDesktop(context) ? 1.2 : 2),
                      ),
                    ),
                    child: Text(widget.login ? "Giriş Yap" : "Kayıt Ol"),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _textField(
      {required String hint,
      required controller,
      bool obscure = false,
      TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
