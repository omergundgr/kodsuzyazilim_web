import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodulartools/screens/blog/create_post.dart';
import 'package:kodulartools/services/post_service.dart';
import 'package:kodulartools/services/register_service.dart';
import '../../constants.dart';
import '../../controllers/MenuController.dart';
import '../../responsive.dart';
import 'components/blog_post.dart';
import 'components/categories.dart';
import 'components/recent_posts.dart';
import 'components/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _menuController = Get.put(MenuController());

  @override
  void initState() {
    RegisterService().userLocal(onlyCheck: true);
    GetterService().getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => [0, 2, 3].contains(_menuController.selectedIndex)
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: _menuController.showContentId == -1
                        ? _contentListWidget()
                        : _showContentWidget()),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: kDefaultPadding),
                // Sidebar
                if (!Responsive.isMobile(context))
                  Expanded(
                    child: Column(
                      children: [
                        const Search(),
                        const SizedBox(height: kDefaultPadding),
                        Categories(),
                        const SizedBox(height: kDefaultPadding),
                        const RecentPosts(),
                      ],
                    ),
                  ),
              ],
            )
          : _menuController.selectedIndex == 5
              ? CreatePost()
              : Text(
                  _menuController.selectedIndex.toString(),
                ),
    );
  }

  Column _contentListWidget() {
    return Column(
      children: _menuController.postList.isEmpty
          ? _menuController.noResult
              ? [const Text("Sonuç Yok")]
              : [
                  const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: kPrimaryAccentColor,
                      ))
                ]
          : List.generate(
              _menuController.postList.length,
              (index) {
                return Column(
                  children: [
                    if (index == 0) _categoryInfoLabel(),
                    BlogPostCard(
                        post: _menuController.postList[index], index: index),
                  ],
                );
              },
            ),
    );
  }

  Column _showContentWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: () => _menuController.setShowContentId(-1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(Icons.keyboard_arrow_left),
                  Text("Geri Dön")
                ],
              ),
            ),
          ),
        ),
        BlogPostCard(
          post: _menuController.postList[_menuController.showContentId],
          showContent: true,
          index: _menuController.showContentId,
        ),
      ],
    );
  }

  Widget _categoryInfoLabel() {
    String category = "";
    int index = _menuController.selectedIndex;
    if (index == 0) {
      category = _menuController.selectedPostCategory;
      if (category.isEmpty) category = "Blog";
    } else if (index == 2) {
      category = "Eklentiler";
    } else if (index == 3) {
      category = "Şemalar";
    }
    return category == "Blog"
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Raleway"),
                ),
                const Text(
                  " İçin Sonuçlar",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontFamily: "Raleway"),
                )
              ],
            ),
          );
  }
}
