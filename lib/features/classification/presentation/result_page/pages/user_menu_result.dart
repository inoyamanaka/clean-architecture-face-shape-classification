import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:face_shape/config/config.dart';
import 'package:face_shape/core/di/injection.dart';
import 'package:face_shape/core/models/ciri_wajah.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/classification/presentation/bloc/classification_bloc.dart';
import 'package:face_shape/features/classification/presentation/result_page/widgets/button_bottom.dart';
import 'package:face_shape/features/classification/presentation/result_page/widgets/face_characteristic_list.dart';
import 'package:face_shape/features/classification/presentation/result_page/widgets/hairstyle_recommendation.dart';
import 'package:face_shape/features/classification/presentation/result_page/widgets/image_preprocess_box.dart';
import 'package:face_shape/features/classification/presentation/widgets/custom_button.dart';
import 'package:face_shape/features/classification/presentation/widgets/decoration_result.dart';
import 'package:face_shape/features/classification/presentation/widgets/loading.dart';
import 'package:face_shape/features/classification/presentation/widgets/title_page.dart';
import 'package:face_shape/features/classification/presentation/widgets/user_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:show_up_animation/show_up_animation.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  PageController pageController = PageController(viewportFraction: 0.7);
  ValueNotifier<int> dynamicHeight = ValueNotifier<int>(250);

  final getBloc = sl<ClassificationBlocGet>();

  final List<String> imageDes = [
    "Original Image",
    "Face Cropping",
    "Facial Landmark",
    "Landmark Extraction"
  ];

  @override
  void initState() {
    super.initState();
    getBloc.add(GetEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    return BlocProvider(
      create: (context) => getBloc,
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            Get.toNamed(Routes.userMenu);
            return false;
          },
          child: BlocConsumer<ClassificationBlocGet, GetClassificationState>(
            listener: (context, state) {
              if (state is GetClassificationFailure) {
                Get.back();
              }
            },
            builder: (context, state) {
              if (state is GetClassificationLoading ||
                  state is GetClassificationInitial) {
                return const LoadingOverlay(
                  isLoading: true,
                  text: "Menampilkan Hasil.......",
                );
              }

              if (state is GetClassificationSuccess) {
                print(state.dataImageEntity.urls);
                print(state.dataImageEntity.hairImage);
                return ScreenUtilInit(
                  builder: (context, child) => Stack(children: [
                    SingleChildScrollView(
                      child: ValueListenableBuilder(
                        valueListenable: dynamicHeight,
                        builder: (context, value, child) => Container(
                          height: height + value,
                          width: size.width,
                          child: Column(
                            children: [
                              SizedBox(
                                child: Column(children: [
                                  DecorationBG(posisi: 'atas'),
                                  const TitleApp(
                                      textTitle: "Hasil Deteksi Wajah"),
                                  SizedBox(height: 15.h),
                                  imageResult(state.dataImageEntity.urls,
                                          state.dataImageEntity.gender)
                                      .animate()
                                      .slideY(begin: 1, end: 0),
                                  SizedBox(height: 15.h),
                                  Container(
                                    height: value.toDouble(),
                                    child: ContainedTabBarView(
                                      onChange: (p0) {
                                        if (p0 == 0) {
                                          dynamicHeight.value = 250;
                                        }
                                        if (p0 == 1) {
                                          dynamicHeight.value = 400;
                                        }
                                        if (p0 == 2) {
                                          dynamicHeight.value = 1300;
                                        }
                                      },
                                      tabBarProperties: TabBarProperties(
                                        indicator: ContainerTabIndicator(
                                            radius: BorderRadius.circular(16),
                                            color: MyColors.primary),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        labelColor: Colors.white,
                                        unselectedLabelColor: MyColors.primary,
                                        height: 35,
                                      ),
                                      tabs: [
                                        Text('Result'),
                                        Text('Detail'),
                                        Text('Style'),
                                      ],
                                      views: [
                                        resultTab(state),
                                        detailTab(state),
                                        ShowUpAnimation(
                                          child: HairStyleRecommendation(
                                            dataImage: state.dataImageEntity,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: -10,
                        right: 0,
                        left: 0,
                        child: Column(
                          children: [
                            DecorationBG(posisi: 'bawah'),
                          ],
                        )),
                    Positioned(
                        bottom: 20,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: BottomButton(),
                        )),
                  ]),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Padding detailTab(GetClassificationSuccess state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FaceCharList(
              ciriWajah: CiriWajah(),
              bentukWajah: state.dataImageEntity.bentukWajah)
          .animate()
          .slideY(begin: 1, end: 0),
    );
  }

  Padding resultTab(GetClassificationSuccess state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ResultCard(
              bentuk_wajah: state.dataImageEntity.bentukWajah,
              persentase: state.dataImageEntity.persen)
          .animate()
          .slideY(begin: 1, end: 0, delay: const Duration(milliseconds: 500)),
    );
  }

  Positioned backButtonUser(BuildContext context) {
    return Positioned(
      left: 20.w,
      right: 20.w,
      bottom: 10.h,
      child: CustomButton(
        onTap: () async {
          Get.toNamed(Routes.menu);
        },
        text: "main menu",
        imageAsset: "assets/Icons/main-menu.png",
        width: 50.w,
        height: 40.h,
      ),
    );
  }

  SizedBox imageResult(List<String> imageUrls, String gender) {
    return SizedBox(
      width: 280.w,
      child: Column(children: [
        ImagePreprocessBox(
          imageUrls: imageUrls,
          gender: gender,
        )
      ]),
    );
  }
}
