import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodulartools/screens/main/components/overlay.dart';
import 'package:kodulartools/screens/main/components/register.dart';
import '../../../constants.dart';
import '../../../controllers/UserController.dart';
import '../../../responsive.dart';

class Social extends StatelessWidget {
  Social({
    Key? key,
  }) : super(key: key);

  final UserController _userCtrl = Get.find();
  GlobalKey _buttonGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 1.5,
        vertical: kDefaultPadding / (Responsive.isDesktop(context) ? 1.2 : 2),
      ),
    );

    return Obx(
      () => Row(
        children: [
          const SizedBox(width: kDefaultPadding),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 1,
                right: 4,
                child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: kPrimaryAccentColor, shape: BoxShape.circle),
                    child: Text(
                      "3",
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              )
            ],
          ),
          const SizedBox(width: kDefaultPadding),
          _userCtrl.mail.isEmpty
              ? ElevatedButton(
                  onPressed: () {
                    if (_userCtrl.mail.value.isEmpty) {
                      _showRegisterLoginWidget();
                    } else {}
                  },
                  style: buttonStyle,
                  child: const Text("Giriş Yap"),
                )
              : ElevatedButton(
                  key: _buttonGlobalKey,
                  onPressed: () {
                    if (_userCtrl.mail.value.isEmpty) {
                      _showRegisterLoginWidget();
                    } else {
                      final overlayState = Overlay.of(context);
                      if (OverlayWidget.overlayEntry == null) {
                        final renderBox = _buttonGlobalKey.currentContext!
                            .findRenderObject() as RenderBox;
                        OverlayWidget.showTopicsOverlay(context, overlayState,
                            renderBox.localToGlobal(Offset.zero));
                      }
                    }
                  },
                  style: buttonStyle,
                  child: const Text("Konu Aç"),
                )
        ],
      ),
    );
  }

  void _showRegisterLoginWidget() {
    Get.dialog(RegisterWidget(
      login: true,
    ));
  }
}
