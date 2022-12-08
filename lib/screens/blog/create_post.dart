import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:kodulartools/constants.dart';
import 'package:kodulartools/controllers/MenuController.dart';
import 'package:kodulartools/controllers/UserController.dart';
import 'package:kodulartools/services/post_service.dart';
import 'package:kodulartools/services/widget_service.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'dart:js' as js;

class CreatePost extends StatefulWidget {
  CreatePost({super.key});
  static final t1 = TextEditingController();

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final MenuController _menuCtrl = Get.find();
  final UserController _userCtrl = Get.find();

  final _t2 = TextEditingController();
  bool _t2Error = false;

  String _description = '';
  List<String> _category = [];
  String _infoText =
      "Paylaşımlarınız yönetim tarafından incelendikten sonra yayınlanacaktır.";

  bool _waitForUpload = false;

  void _callFileReplacer(String value) {
    if (value.contains("![]()")) {
      if (!_waitForUpload) {
        setState(() => _waitForUpload = true);
        UploadService().uploadImage(event: (e) {
          if (e == null) {
            CreatePost.t1.text =
                CreatePost.t1.text.replaceAll("![]()", "![alt](imageUrl)");
          } else {
            CreatePost.t1.text = CreatePost.t1.text
                .replaceAll("![]()", "![kodsuzyazilim]($kHostAdress/$e)");
          }
        });
      } else {
        Future.delayed(const Duration(seconds: 2))
            .then((_) => setState(() => _waitForUpload = false));
      }
    } else if (value.contains("[]()")) {
      if (!_waitForUpload) {
        setState(() => _waitForUpload = true);
        UploadService().uploadFile(event: (e) {
          if (e == null) {
            CreatePost.t1.text =
                CreatePost.t1.text.replaceAll("[]()", "[file](fileUrl)");
          } else {
            String filePath = e['path'];
            String fileName = filePath.split("_").last;
            String fileSize = e['size'];
            CreatePost.t1.text = CreatePost.t1.text.replaceAll(
                "[]()", "[$fileName ($fileSize kb)]($kHostAdress/$filePath)");
          }
        });
      } else {
        Future.delayed(const Duration(seconds: 2))
            .then((_) => setState(() => _waitForUpload = false));
      }
    }
  }

  void _publishCheck() async {
    if (_t2.text.isEmpty) {
      setState(() => _t2Error = true);
    } else {
      await PublishService(
              categories: _category,
              post: CreatePost.t1.text,
              title: _t2.text,
              userMail: _userCtrl.mail.value,
              postType: _menuCtrl.selectedTopic)
          .postBlog();
      CreatePost.t1.clear();
      _t2.clear();
      _category.clear();
      setState(() => _infoText = "Başarıyla gönderildi.");
      WidgetService().scrollBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => _headText(_menuCtrl.selectedTopic)),
            ElevatedButton(
              onPressed: () => _publishCheck(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryAccentColor),
              child: const Text(
                "Konuyu Paylaş",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Raleway", fontSize: 18),
              ),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(top: 10, bottom: 15),
          child: TextField(
            controller: _t2,
            style: const TextStyle(fontFamily: "Raleway"),
            decoration: InputDecoration(
                hintText: "Konu Başlığı",
                errorText: _t2Error ? "Burayı boş bırakamazsın" : null),
          ),
        ),
        MarkdownTextInput(
          (String value) {
            _callFileReplacer(value);
            setState(() => _description = CreatePost.t1.text);
          },
          _description,
          label: 'Konu ile alakalı birşeyler yazın..',
          actions: MarkdownType.values,
          controller: CreatePost.t1,
          maxLines: 20,
          textStyle: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 15),
        Text(
          _description.isEmpty ? "" : "Önizleme",
          style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
              fontFamily: "Raleway",
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        MarkdownBody(
          data: _description.replaceAll("\n", "\n\n"),
          shrinkWrap: true,
          selectable: true,
          onTapLink: (text, href, title) {
            js.context.callMethod('open', [href]);
          },
        ),
        Obx(() => _menuCtrl.selectedTopic == "Blog Yaz"
            ? _blogAddons()
            : const SizedBox()),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          margin: const EdgeInsets.only(top: 15, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(_infoText),
        )
      ],
    );
  }

  Text _headText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 25,
          color: Colors.black54,
          fontFamily: "Raleway",
          fontWeight: FontWeight.bold),
    );
  }

  Column _blogAddons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_description.isNotEmpty)
          const Divider(color: kBodyTextColor, height: 30),
        _headText("Kategori Seç"),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              "Eklenti Dökümantasyon",
              "Faydalı Araçlar",
              "Kodular Yenilikleri",
              "Sorulara Cevaplar",
              "Nasıl Yapılır?",
              "Ücretsiz Paylaşımlar"
            ]
                .map((e) => InkWell(
                      onTap: () => setState(() => _category.contains(e)
                          ? _category.removeWhere((element) => element == e)
                          : _category.add(e)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: kBodyTextColor),
                            borderRadius: BorderRadius.circular(5),
                            color: _category.contains(e)
                                ? kPrimaryAccentColor
                                : null),
                        child: Text(
                          e,
                          style: TextStyle(
                              color:
                                  _category.contains(e) ? Colors.white : null),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
