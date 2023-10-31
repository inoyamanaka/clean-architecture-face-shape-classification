import 'package:face_shape/features/classification/domain/entities/user_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HairStyleRecommendation extends StatelessWidget {
  const HairStyleRecommendation({
    super.key,
    required this.dataImage,
  });

  final DataImageEntity dataImage;

  @override
  Widget build(BuildContext context) {
    print('masuk');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) => Container(
                      // padding: EdgeInsets.only(top: 20),
                      child: Card(
                          elevation: 4.0,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  dataImage.hairStyle[index],
                                  style: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(Icons.favorite_outline),
                              ),
                              Container(
                                height: 200.0,
                                child: Image.network(
                                  dataImage.hairImage[index],
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 220,
                                        height: 220,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16.0),
                                alignment: Alignment.centerLeft,
                                child: Text(dataImage.hairDescription[index],
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.normal)),
                              ),
                            ],
                          )))),
            ],
          ),
        ),
      ),
    );
  }
}
