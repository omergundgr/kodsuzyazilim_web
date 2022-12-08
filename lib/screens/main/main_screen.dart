import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controllers/MenuController.dart';
import '../../controllers/UserController.dart';
import '../home/home_screen.dart';
import 'components/header.dart';
import 'components/overlay.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  static final scrollCtrl = ScrollController();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _menuCtrl = Get.put(MenuController());
  final _userCtrl = Get.put(UserController());

  void _removeOverlays() {
    if (OverlayWidget.overlayEntry != null) {
      try {
        OverlayWidget.overlayEntry!.remove();
        OverlayWidget.overlayEntry = null;
      } catch (e) {}
    }
  }

  @override
  void initState() {
    MainScreen.scrollCtrl.addListener(() => _removeOverlays());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _menuCtrl.scaffoldkey,
      drawer: SideMenu(),
      body: GestureDetector(
        onTap: () => _removeOverlays(),
        child: SingleChildScrollView(
          controller: MainScreen.scrollCtrl,
          child: Column(
            children: [
              Header(),
              Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                constraints: const BoxConstraints(maxWidth: kMaxWidth),
                child: SafeArea(child: HomeScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
