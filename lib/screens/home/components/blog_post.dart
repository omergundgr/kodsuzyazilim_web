import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kodulartools/controllers/MenuController.dart';
import 'package:kodulartools/models/post_model.dart';
import '../../../constants.dart';
import '../../../responsive.dart';
import 'dart:js' as js;

class BlogPostCard extends StatelessWidget {
  final Post post;
  final int index;
  final bool showContent;
  BlogPostCard(
      {Key? key,
      required this.post,
      this.showContent = false,
      required this.index})
      : super(key: key);

  final MenuController _menuCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        children: [
          if (post.image != null && !showContent)
            AspectRatio(
              aspectRatio: 1.78,
              child: Image.network(
                post.image!,
                fit: BoxFit.cover,
              ),
            ),
          Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      post.userMail.split("@").first.toUpperCase(),
                      style: const TextStyle(
                        color: kDarkBlackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: kDefaultPadding),
                    Text(
                      post.date,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Text(
                    post.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Responsive.isDesktop(context) ? 32 : 24,
                      fontFamily: "Raleway",
                      color: kDarkBlackColor,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                showContent
                    ? MarkdownBody(
                        data: post.body,
                        selectable: true,
                        onTapLink: (text, href, title) {
                          js.context.callMethod('open', [href]);
                        },
                      )
                    : Text(
                        post.description.length > 320
                            ? post.description.substring(0, 319)
                            : post.description,
                        maxLines: 4,
                        style: const TextStyle(height: 1.5),
                      ),
                const SizedBox(height: kDefaultPadding),
                Row(
                  children: [
                    if (!showContent)
                      TextButton(
                        onPressed: () => _menuCtrl.setShowContentId(index),
                        child: Container(
                          padding: const EdgeInsets.only(
                              bottom: kDefaultPadding / 4),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: kPrimaryColor, width: 3),
                            ),
                          ),
                          child: const Text(
                            "Daha Fazla Göster",
                            style: TextStyle(color: kDarkBlackColor),
                          ),
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      icon: SvgPicture.asset(
                          "assets/icons/feather_thumbs-up.svg"),
                      onPressed: () {},
                    ),
                    const Text(
                      "3 beğeni",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
