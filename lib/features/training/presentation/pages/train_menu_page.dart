import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:face_shape/config/config.dart';
import 'package:face_shape/core/di/injection.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:face_shape/features/classification/presentation/widgets/loading.dart';
import 'package:face_shape/features/training/data/models/request/train_request.dart';
import 'package:face_shape/features/training/presentation/bloc/training_bloc.dart';
import 'package:face_shape/features/training/presentation/widgets/dialogue.dart';
import 'package:face_shape/features/training/presentation/widgets/panduan_step.dart';
import 'package:face_shape/features/training/presentation/widgets/title_train.dart';
import 'package:face_shape/features/training/presentation/widgets/top_decoration_train.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:show_up_animation/show_up_animation.dart';

class TrainMenuPage extends StatefulWidget {
  const TrainMenuPage({super.key});

  @override
  State<TrainMenuPage> createState() => _TrainMenuPage();
}

class _TrainMenuPage extends State<TrainMenuPage>
    with SingleTickerProviderStateMixin {
  late AnimationController loadingController;
  late ValueNotifier<double> loadingControllerP;
  late PlatformFile platformFile;

  final uploadBloc = sl<TrainBloc>();
  ValueNotifier<int> pageIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> panduan = [
      "Dataset harus ada dalam format zip",
      "Dataset terdiri dari 6 buah class (diamond, oblong, oval, round, triangle daan square)",
      "Dataset sudah terbagi ke dalam folder training dan testing",
      "Jumlah perbandingan data training dan testing adalah 80:20 dari total dataset yang ada"
    ];
    final Size size = MediaQuery.of(context).size;
    final double height = size.height; // tinggi layar

    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            Get.toNamed(Routes.menu);
            return false;
          },
          child: ScreenUtilInit(
            builder: (context, child) => BlocProvider<TrainBloc>(
              create: (context) => uploadBloc,
              child: BlocConsumer<TrainBloc, TrainState>(
                  listener: (context, state) {
                if (state is UploadDatasetStateSuccess) {
                  successDialogue(context);
                }
              }, builder: (context, state) {
                if (state is UploadDatasetStateLoading) {
                  return StreamBuilder<double>(
                    stream: state.uploadProgress,
                    builder:
                        (BuildContext context, AsyncSnapshot<double> snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        double progressPercent = snapshot.data ?? 0.0;
                        int progressPercentInt = progressPercent.toInt();
                        return LoadingOverlay(
                          text: 'Loading ${progressPercentInt}%',
                          isLoading: true,
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Container();
                      }
                    },
                  );
                }
                return SingleChildScrollView(
                  child: ShowUpAnimation(
                    child: Container(
                      height: height,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TopMenuTrain(ontap: () {
                              Get.toNamed(Routes.menu);
                            }),
                            SizedBox(height: 15.h),
                            const TitlePage(text: 'Panduan Upload'),
                            SizedBox(height: 10.h),
                            PanduanStep(panduan: panduan),
                            SizedBox(height: 10.h),
                            ShowUpAnimation(
                              child: Container(
                                width: double.infinity,
                                // height: 150,
                                decoration: const BoxDecoration(
                                    color: Color(0xffD9D9D9),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                margin: EdgeInsets.symmetric(horizontal: 30),

                                // padding: EdgeInsets.all(10),
                                child: CarouselSlider(
                                  items: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Image.asset(
                                          'assets/Images/first_step.png'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                          'assets/Images/second_step.png'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                          'assets/Images/third_step.png'),
                                    ),
                                  ],
                                  options: CarouselOptions(
                                      // aspectRatio: 1.0,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        pageIndex.value = index;
                                      },
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: false,
                                      padEnds: false),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            ShowUpAnimation(
                              child: ValueListenableBuilder(
                                valueListenable: pageIndex,
                                builder: (context, value, child) => Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,

                                  height: 50,
                                  // child: Text('Test'),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: 3,
                                    itemBuilder: (context, index) => Container(
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 500),
                                        width: 30,
                                        height: 30,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: index == value
                                                ? Color(0xff171C3C)
                                                : Color(0xffD9D9D9)),
                                        child: Center(
                                            child: Text(
                                          '${index + 1}',
                                          style: GoogleFonts.urbanist(
                                              color: index == value
                                                  ? Color(0xffD9D9D9)
                                                  : Color(0xff171C3C)),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10.h),
                            const TitlePage(text: 'Upload Dataset'),
                            SizedBox(height: 10.h),
                            uploadDataButton(),
                            SizedBox(height: 30.h),
                            // uploading(uploadDataSource),
                            // Expanded(
                            //   child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         // TopMenuTrain(ontap: () {
                            //         //   Get.toNamed(Routes.menu);
                            //         // }),
                            //         // SizedBox(height: 15.h),
                            //         // const TitlePage(
                            //         //   text: 'Upload Dataset',
                            //         // ).animate().slideY(begin: 1, end: 0),
                            //         // SizedBox(height: 10.h),
                            //         // const SubTitle(text: "Ketentuan Dataset")
                            //         //     .animate()
                            //         //     .slideY(begin: 1, end: 0),
                            //         // SizedBox(height: 5.h),
                            //         // content1(width, panduan)
                            //         //     .animate()
                            //         //     .slideY(begin: 1, end: 0),
                            //         Expanded(child: PanduanStep(panduan: panduan)),
                            //         SizedBox(height: 10.h),
                            //         // const SubTitle(
                            //         //   text: 'Contoh Folder',
                            //         // ).animate().slideY(begin: 1, end: 0),
                            //         // SizedBox(height: 5.h),
                            //         // content2(width)
                            //         //     .animate()
                            //         //     .slideY(begin: 1, end: 0),
                            //         // SizedBox(height: 10.h),
                            //         // const SubTitle(
                            //         //   text: 'Upload Dataset',
                            //         // ).animate().slideY(begin: 1, end: 0),
                            //         // uploadDataButton()
                            //         //     .animate()
                            //         //     .slideY(begin: 1, end: 0),

                            //         // uploading(uploadDataSource),
                            //         SizedBox(height: 100.h)
                            //       ]),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Center content2(double width) {
    return Center(
      child: Container(
        width: width * 0.9,
        height: 220,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 217, 217, 217),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            "assets/Images/folder_panduan.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  InkWell uploadDataButton() {
    return InkWell(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();
          String? path = result!.files.first.path;
          print(path);
          uploadBloc.add(UploadDatasetEvent(
              filepath: UploadDatasetFilepathReq(filepath: path!)));
        },
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              dashPattern: const [10, 4],
              strokeCap: StrokeCap.round,
              color: MyColors.primary,
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.blue.shade50.withOpacity(.3),
                    borderRadius: BorderRadius.circular(10)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.folder_open,
                      color: Color.fromARGB(255, 19, 21, 34),
                      size: 40,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Select your file',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
            )));
  }
}
