// ignore_for_file: non_constant_identifier_names

import 'package:face_shape/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultCard extends StatelessWidget {
  final String bentuk_wajah;
  final double persentase;

  const ResultCard(
      {super.key, required this.bentuk_wajah, required this.persentase});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 290,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
          color: MyColors.primary,
          border: Border.all(
            color: Colors.black,
            width: 2.w,
          ),
        ),
        child: Column(children: [
          Row(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 33),
                  child: SizedBox(
                    width: 223,
                    child: Text(
                      'Berdasarkan hasil deteksi bentuk wajah yang telah dilakukan anda mempunyai bentuk wajah dengan jenis $bentuk_wajah dengan persentase kecocokan sebesar $persentase%.',
                      style: TextStyle(
                        color: Color(0xFFFFFCFC),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.52,
                        letterSpacing: 0.7,
                      ),
                    ),
                  )),
              SizedBox(width: 5.w),
            ],
          ),
        ]),
      ),
      Positioned(
        top: 0,
        bottom: 0,
        right: 10,
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircularPercentIndicator(
            radius: 50.0,
            lineWidth: 12.0,
            percent: (persentase / 100),
            center: CircleAvatar(
                radius: 40,
                backgroundColor: MyColors.secondary,
                child: Text("$persentase%",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black))),
            progressColor: MyColors.fifth,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    ]);
  }
}
