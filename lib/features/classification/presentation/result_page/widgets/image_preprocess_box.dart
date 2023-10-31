import 'package:carousel_slider/carousel_slider.dart';
import 'package:face_shape/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:shimmer/shimmer.dart';

class ImagePreprocessBox extends StatefulWidget {
  const ImagePreprocessBox(
      {super.key, required this.imageUrls, required this.gender});

  final List<String> imageUrls;
  final String gender;

  @override
  State<ImagePreprocessBox> createState() => _ImagePreprocessBoxState();
}

ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

List<String> imageName = [
  'Original Image',
  'Face Cropping',
  'Face Landmark',
  'Landmark Extraction'
];

class _ImagePreprocessBoxState extends State<ImagePreprocessBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 230,
          height: 40,
          child: Center(
              child: Text(widget.gender,
                  style: MyFonts.primary.copyWith(color: Colors.white))),
          decoration: BoxDecoration(
              color: MyColors.primary,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        ),
        Container(
          height: 180.h,
          width: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: CarouselSlider(
            items: [
              ImageToShow(imageUrl: widget.imageUrls[0]),
              ImageToShow(imageUrl: widget.imageUrls[1]),
              ImageToShow(imageUrl: widget.imageUrls[2]),
              ImageToShow(imageUrl: widget.imageUrls[3])
            ],
            options: CarouselOptions(
              viewportFraction: 1,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                currentIndex.value = index;
              },
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: currentIndex,
          builder: (context, value, child) => Container(
              width: 230,
              height: 40,
              decoration: BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              child: Center(
                child: Text(imageName[value],
                    style: MyFonts.primary.copyWith(color: Colors.white)),
              )),
        ),
        ValueListenableBuilder(
          valueListenable: currentIndex,
          builder: (context, value, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imageUrls.asMap().entries.map((entry) {
              int index = entry.key;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: value == index ? 25.w : 10.w,
                height: 10.h,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: value == index ? Colors.black : Colors.grey,
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class ImageToShow extends StatelessWidget {
  const ImageToShow({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Stack(children: [
            Container(
              width: 220.w,
              child: Image.network(
                imageUrl,
                // fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
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
              ),
            ),
            ValueListenableBuilder(
              valueListenable: currentIndex,
              builder: (context, value, child) => Container(
                child: GalleryImage(
                  childAspectRatio: 1,
                  minScale: 1,
                  showAppBar: true,
                  imageUrls: [imageUrl],
                  numOfShowImages: 1,
                  titleGallery: "${imageName[value]}",
                ),
              ),
            ),
          ])),
    );
  }
}
