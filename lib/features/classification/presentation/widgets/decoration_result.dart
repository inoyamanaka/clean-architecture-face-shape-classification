import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DecorationBG extends StatelessWidget {
  const DecorationBG({super.key, required this.posisi});

  final String posisi;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: posisi == 'atas'
          ? SvgPicture.asset(
              "assets/Svgs/result_atas_decoration.svg",
            )
          : Stack(children: [
              Column(
                children: [
                  SvgPicture.asset(
                    "assets/Svgs/result_bawah_decoration.svg",
                  ),
                ],
              ),
            ]),
    );
  }
}
