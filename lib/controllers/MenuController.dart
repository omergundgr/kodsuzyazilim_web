import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kodulartools/models/post_model.dart';

class MenuController extends GetxController {
  var _selectedIndex = 0.obs;
  var _selectedTopic = "".obs;
  var _selectedPostCategory = "".obs;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _pageIndex = 0.obs;
  var _postLoading = false.obs;
  var _postOffset = 0.obs;
  var _postList = RxList<Post>();
  var _noResult = false.obs;
  var _showContentId = "-1".obs;

  String? postCategory;
  String? newCategory;

  int get selectedIndex => _selectedIndex.value;
  String get selectedTopic => _selectedTopic.value;
  int get pageIndex => _pageIndex.value;
  int get postOffset => _postOffset.value;
  bool get postLoading => _postLoading.value;
  List<Post> get postList => _postList;
  int get showContentId => int.parse(_showContentId.value);
  List<String> get menuItems =>
      ["Blog", "Araçlar", "Eklentiler", "Şemalar", "İletişim"];
  String get selectedPostCategory => _selectedPostCategory.value;
  bool get noResult => _noResult.value;
  GlobalKey<ScaffoldState> get scaffoldkey => _scaffoldKey;

  void openOrCloseDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void setMenuIndex(int index) {
    _selectedIndex.value = index;
  }

  void setSelectedTopic(String value) {
    _selectedTopic.value = value;
  }

  void setPageIndex(int index) {
    _pageIndex.value = index;
  }

  void setPostOffset(int offset) {
    _postOffset.value = offset;
  }

  void addToPostList(List<Post> list) {
    _postList.addAll(list);
    _postList.refresh();
    _postOffset.value = postOffset + 5;
  }

  void clearPostList() {
    _postList.clear();
    _postList.refresh();
  }

  void setPostLoading(bool val) {
    _postLoading.value = val;
  }

  void setNoResult(bool noResult) {
    _noResult.value = noResult;
  }

  void setSelectedPostCategory(String category) {
    _selectedPostCategory.value = category;
  }

  void setShowContentId(int id) {
    _showContentId.value = id.toString();
  }
}
