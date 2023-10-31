import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:timelines/timelines.dart';

class PanduanStep extends StatelessWidget {
  const PanduanStep({super.key, required this.panduan});

  final List<String> panduan;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 200 + (15 * panduan.length.toDouble()),
      // color: Colors.amber,
      child: Timeline.tileBuilder(
        physics: NeverScrollableScrollPhysics(),
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0.1,
          connectorTheme: const ConnectorThemeData(
            thickness: 2,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          indicatorBuilder: (context, index) {
            return ShowUpAnimation(
              child: const DotIndicator(
                color: Color(0xff989CBC),
              ),
            );
          },
          connectorBuilder: (_, index, connectorType) {
            return ShowUpAnimation(
              child: SolidLineConnector(
                indent: connectorType == ConnectorType.start ? 0 : 2.0,
                endIndent: connectorType == ConnectorType.end ? 0 : 2.0,
                color: const Color(0xff33363F),
              ),
            );
          },
          contentsAlign: ContentsAlign.reverse,
          oppositeContentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: ShowUpAnimation(
                delayStart: Duration(milliseconds: 80 * index),
                child: Text(
                  panduan[index],
                  style: GoogleFonts.urbanist(
                      fontSize: 12, fontWeight: FontWeight.bold),
                )),
          ),
          itemCount: panduan.length,
        ),
      ),
    ));
  }
}
