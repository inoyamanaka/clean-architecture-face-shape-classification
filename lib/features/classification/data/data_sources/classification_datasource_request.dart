// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:face_shape/core/shared/constant/api_path.dart';
import 'package:face_shape/features/classification/data/models/request/upload_image_model.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';

abstract class ReqClassificationRemoteDataSource {
  Future<ImageEntity> uploadImage(UploadImageModel filepath);
}

class ReqClassificationRemoteDataSourceImpl
    implements ReqClassificationRemoteDataSource {
  final Dio client;

  ReqClassificationRemoteDataSourceImpl(this.client);

  @override
  Future<ImageEntity> uploadImage(UploadImageModel filePath) async {
    try {
      print(filePath.message);
      final file = File(filePath.message);
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        'picture': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });
      final response = await client.post(
        ApiPath.upload,
        data: formData,
      );

      

      return UploadImageModel.fromJson(
          response.data!); // Placeholder return value, modify as needed
    } catch (error) {
      // Handle errors here
      rethrow;
    }
  }
}
