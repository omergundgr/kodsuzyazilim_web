import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodulartools/controllers/MenuController.dart';
import 'package:kodulartools/services/post_service.dart';

import '../../../constants.dart';
import 'sidebar_container.dart';

class Categories extends StatelessWidget {
  Categories({
    Key? key,
  }) : super(key: key);

  final MenuController _menuCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return SidebarContainer(
      title: "Kategoriler",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _category('Eklenti Dökümantasyon'),
          _category('Faydalı Araçlar'),
          _category('Kodular Yenilikleri'),
          _category('Sorulara Cevaplar'),
          _category('Nasıl Yapılır?'),
          _category('Ücretsiz Paylaşımlar'),
        ],
      ),
    );
  }

  Widget _category(title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
      child: TextButton(
        onPressed: () {
          _menuCtrl.setShowContentId(-1);
          _menuCtrl.setMenuIndex(0);
          _menuCtrl.setSelectedPostCategory(title);
          GetterService().getPosts(category: title);
        },
        child: Text(
          title,
          style: const TextStyle(color: kDarkBlackColor),
        ),
      ),
    );
  }
}
