import 'package:carousel_slider/carousel_slider.dart';
import 'package:face_shape/config/config.dart';
import 'package:face_shape/core/models/main_menu_att.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/classification/presentation/main_page/widgets/main_menu_widget.dart';
import 'package:face_shape/features/classification/presentation/widgets/card_mode.dart';
import 'package:face_shape/features/classification/presentation/widgets/title_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MenuMode extends StatefulWidget {
  const MenuMode({super.key});

  @override
  State<MenuMode> createState() => _MenuModeState();
}

class _MenuModeState extends State<MenuMode> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
        builder: (context, child) => Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              SystemNavigator.pop();
              return false;
            },
            child: Column(
              children: [
                SizedBox(height: 50.h),
                const TitleApp(
                  textTitle: "Pilih Mode",
                ).animate().slideY(begin: 1, end: 0),
                SizedBox(height: 5.h),
                contentImage()
                    .animate()
                    .fade(duration: GetNumUtils(0.5).seconds),
                sliderIndicator(),
                subDescription().animate().slideY(begin: 1, end: 0),
                buttonRow(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buttonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            _currentIndex == 0
                ? Get.toNamed(Routes.trainMenu)
                : Get.toNamed(Routes.userMenu);
          },
          child: ModeButton(currentIndex: _currentIndex),
        ),
        SizedBox(width: 10.w),
        InkWell(
          onTap: () {},
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: 75.h,
            width: 75.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: _currentIndex == 1 ? MyColors().fourth : MyColors.primary,
              border: Border.all(
                color: Colors.black,
                width: 2.w,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    _currentIndex == 0
                        ? "assets/Icons/user_blue.png"
                        : "assets/Icons/user_black.png",
                    width: 45.w,
                    height: 45.h,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row sliderIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: MainMenuAtt.imageList.asMap().entries.map((entry) {
        int index = entry.key;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: _currentIndex == index ? 25.w : 10.w,
          height: 10.h,
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.w),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            shape: BoxShape.rectangle,
            color: _currentIndex == index ? Colors.black : Colors.grey,
          ),
        );
      }).toList(),
    );
  }

  SizedBox contentImage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 380.h,
      child: CarouselSlider(
        items: MainMenuAtt.imageList.map((image) {
          return CardMode(image: image);
        }).toList(),
        options: CarouselOptions(
          height: 330.h,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Padding subDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Text(MainMenuAtt.deskripsi[_currentIndex],
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500)),
    );
  }
}
