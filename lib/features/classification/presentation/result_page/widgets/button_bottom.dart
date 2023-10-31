import 'package:face_shape/config/config.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: MyColors.secondary,
              borderRadius: BorderRadius.circular(15)),
          child: IconButton(
              onPressed: () {
                Get.toNamed(Routes.menu);
              },
              icon: Icon(Icons.house)),
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.userMenu);
          },
          child: Container(
            height: 60,
            width: 200,
            decoration: BoxDecoration(
                color: MyColors.secondary,
                borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: Text(
              'main menu',
              style: MyFonts.primary,
            )),
          ),
        ),
      ],
    );
  }
}
