import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodulartools/controllers/MenuController.dart';
import 'package:kodulartools/screens/blog/create_post.dart';
import 'package:kodulartools/services/widget_service.dart';
import '../../../constants.dart';

class OverlayWidget {
  static OverlayEntry? overlayEntry;
  static showTopicsOverlay(BuildContext context, OverlayState? overlayState,
      Offset buttonOffset) async {
    final MenuController _menuController = Get.find();

    Widget _menuItem({required Function onPressed, required String text}) {
      return TextButton(
        onPressed: () {
          overlayEntry!.remove();
          overlayEntry = null;
          _menuController.setMenuIndex(5);
          _menuController.setSelectedTopic(text);
          CreatePost.t1.clear();
          WidgetService().scrollBottom();
          onPressed;
        },
        child: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: kDarkBlackColor),
        ),
      );
    }

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: buttonOffset.dx,
        top: buttonOffset.dy + 50,
        child: Container(
          width: 115,
          height: 120,
          decoration: BoxDecoration(
            color: kBgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kDarkBlackColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _menuItem(onPressed: () {}, text: "Blog Yaz"),
              _menuItem(onPressed: () {}, text: "Eklenti Paylaş"),
              _menuItem(onPressed: () {}, text: "Şema Paylaş"),
            ],
          ),
        ),
      );
    });

    overlayState!.insert(overlayEntry!);
  }
}
