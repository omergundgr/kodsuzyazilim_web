import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../controllers/MenuController.dart';
import '../../../responsive.dart';
import 'social.dart';
import 'web_menu.dart';
import 'dart:js' as js;

class Header extends StatelessWidget {
  final MenuController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kDarkBlackColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: kMaxWidth),
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/blocks.png"),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (!Responsive.isDesktop(context))
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _controller.openOrCloseDrawer();
                          },
                        ),
                      const Text("Kodsuz Yazılım",
                          style: TextStyle(color: Colors.white, fontSize: 23)),
                      const Spacer(),
                      if (Responsive.isDesktop(context)) WebMenu(),
                      const Spacer(),
                      // Socal
                      Social(),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  const Text(
                    "Kodsuz Yazılıma Hoşgeldin!",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                    child: Text(
                      "Gerekli olan bilgileri hızlıca edinebilmek için Udemy üzerindeki kursumuza katılım sağlayabilirsin.\nKod Yazmadan aklındaki yazılımı hayata geçir, işlerini kolaylaştır veya para kazan.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        height: 1.5,
                      ),
                    ),
                  ),
                  FittedBox(
                    child: TextButton(
                      onPressed: () => js.context.callMethod('open', [
                        'https://www.udemy.com/course/kod-yazmadan-mobil-uygulama-yapma-kodular-egitim-seti/?referralCode=EE0593158751038375D3'
                      ]),
                      child: Row(
                        children: const [
                          Text(
                            "Udemy Kursuna Git",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "Raleway"),
                          ),
                          SizedBox(width: kDefaultPadding / 2),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (Responsive.isDesktop(context))
                    const SizedBox(height: kDefaultPadding),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
