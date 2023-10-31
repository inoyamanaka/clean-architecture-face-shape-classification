import 'package:face_shape/features/classification/domain/entities/user_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_image_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class GetImageModel extends DataImageEntity {
  GetImageModel(
      {required super.urls,
      required super.bentukWajah,
      required super.persen,
      required super.hairStyle,
      required super.hairImage,
      required super.hairDescription,
      required super.gender});

  factory GetImageModel.fromJson(Map<String, dynamic> json) =>
      _$GetImageModelFromJson(json);
}
