import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String message;
  const ImageEntity({required this.message});

  @override
  List<Object?> get props => [message];
}

class DataImageEntity extends Equatable {
  final List<String> urls;
  final String bentukWajah;
  final double persen;
  final String gender;
  final List<String> hairStyle;
  final List<String> hairImage;
  final List<String> hairDescription;

  DataImageEntity(
      {required this.urls,
      required this.bentukWajah,
      required this.persen,
      required this.gender,
      required this.hairStyle,
      required this.hairDescription,
      required this.hairImage});

  @override
  List<Object?> get props =>
      [urls, bentukWajah, persen, hairStyle, hairImage, hairDescription];
}
