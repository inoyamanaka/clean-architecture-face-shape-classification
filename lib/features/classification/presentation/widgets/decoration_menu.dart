import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DecorationMenu extends StatelessWidget {
  const DecorationMenu({super.key, required this.posisi});

  final String posisi;

  @override
  Widget build(BuildContext context) {
    return posisi == 'atas'
        ? Container(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              "assets/Svgs/hiasan_atas.svg",
            ))
        : Container(
            alignment: Alignment.bottomLeft,
            child: SvgPicture.asset(
              "assets/Svgs/hiasan_bawah.svg",
            ),
          );
  }
}
