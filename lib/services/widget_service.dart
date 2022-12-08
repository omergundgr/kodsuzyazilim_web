import 'package:flutter/material.dart';

import '../screens/main/main_screen.dart';

class WidgetService {
  void scrollBottom() {
    MainScreen.scrollCtrl.animateTo(
        MainScreen.scrollCtrl.position.maxScrollExtent,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 2));
  }
}
