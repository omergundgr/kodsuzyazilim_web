import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import 'sidebar_container.dart';

class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidebarContainer(
      title: "Bloglarda Ara",
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          hintText: "Bir konu yaz ...",
          suffixIcon: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: InkWell(
                onTap: () {},
                child: SvgPicture.asset("assets/icons/feather_search.svg")),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(kDefaultPadding / 2),
            ),
            borderSide: BorderSide(color: Color(0xFFCCCCCC)),
          ),
        ),
      ),
    );
  }
}
