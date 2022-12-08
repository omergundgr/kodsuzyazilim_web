import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodulartools/services/post_service.dart';

import '../../../constants.dart';
import '../../../controllers/MenuController.dart';

class SideMenu extends StatelessWidget {
  final MenuController _controller = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kDarkBlackColor,
        child: Obx(
          () => ListView(
            children: [
              const DrawerHeader(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kDefaultPadding * 3.5),
                    child: Text(
                      "Kodsuz Yazılım",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
              ...List.generate(
                _controller.menuItems.length,
                (index) => DrawerItem(
                  isActive: index == _controller.selectedIndex,
                  title: _controller.menuItems[index],
                  press: () {
                    _controller.setShowContentId(-1);
                    _controller.setMenuIndex(index);
                    _controller.openOrCloseDrawer();
                    _controller.setSelectedPostCategory("");
                    if (index == 0) {
                      GetterService().getPosts();
                    } else if (index == 2) {
                      GetterService().getPosts(category: "extension");
                    } else if (index == 3) {
                      GetterService().getPosts(category: "schema");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback press;

  const DrawerItem({
    Key? key,
    required this.title,
    required this.isActive,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        selected: isActive,
        selectedTileColor: kPrimaryColor,
        onTap: press,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
