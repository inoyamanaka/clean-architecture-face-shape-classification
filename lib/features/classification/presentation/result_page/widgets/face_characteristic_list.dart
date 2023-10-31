import 'package:face_shape/core/models/ciri_wajah.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelines/timelines.dart';

class FaceCharList extends StatelessWidget {
  const FaceCharList(
      {super.key, required this.ciriWajah, required this.bentukWajah});
  final CiriWajah ciriWajah;
  final String bentukWajah;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 15.h),
        Text(
          "Ciri dari wajah",
          style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700),
        ),
        Expanded(
          child: SizedBox(
            child: CiriWajah.faceShapes.containsKey(bentukWajah)
                ? Timeline.tileBuilder(
                    physics: NeverScrollableScrollPhysics(),
                    theme: TimelineTheme.of(context).copyWith(
                      nodePosition: 0.1,
                      connectorTheme: const ConnectorThemeData(
                        thickness: 2,
                      ),
                    ),
                    builder: TimelineTileBuilder.connected(
                      indicatorBuilder: (context, index) {
                        return const DotIndicator(
                          color: Color(0xff989CBC),
                        );
                      },
                      connectorBuilder: (_, index, connectorType) {
                        return SolidLineConnector(
                          indent:
                              connectorType == ConnectorType.start ? 0 : 2.0,
                          endIndent:
                              connectorType == ConnectorType.end ? 0 : 2.0,
                          color: const Color(0xff33363F),
                        );
                      },
                      contentsAlign: ContentsAlign.reverse,
                      oppositeContentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Text(
                          CiriWajah.faceShapes[bentukWajah]![index],
                          style: GoogleFonts.urbanist(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      itemCount: 4,
                    ),
                  )
                : Container(),
          ),
        )
      ]),
    );
  }
}
