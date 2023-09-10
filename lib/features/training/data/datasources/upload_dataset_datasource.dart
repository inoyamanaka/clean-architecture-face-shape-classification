import 'dart:async';

import 'package:dio/dio.dart';
import 'package:face_shape/core/shared/constant/api_path.dart';
import 'package:face_shape/features/training/data/models/request/train_request.dart';
import 'package:face_shape/features/training/data/models/response/upload_dataset_model.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';

abstract class UploadDatasetDataSource {
  Future<UploadDatasetEntity> upload(UploadDatasetFilepathReq filepath);
  Stream<double> get progressStream;
}

class UploadDatasetDataSourceImpl implements UploadDatasetDataSource {
  final Dio client;

  // Deklarasi StreamController untuk kemajuan upload
  final _progressController = StreamController<double>();

  UploadDatasetDataSourceImpl(this.client);

  // Getter untuk mendapatkan Stream kemajuan upload
  Stream<double> get progressStream => _progressController.stream;

  @override
  Future<UploadDatasetEntity> upload(
    UploadDatasetFilepathReq filepath,
  ) async {
    try {
      final formData = FormData.fromMap({
        'file':
            await MultipartFile.fromFile(filepath.filepath, filename: 'file'),
      });

      print(formData);

      final response = await client.post(
        ApiPath.uploadData,
        data: formData,
        onSendProgress: (count, total) {
          double progressPercent = (count / total) * 100;
          _progressController.sink.add(progressPercent);
        },
      );

      print(response);

      return UploadDatasetModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Pastikan untuk menutup StreamController saat tidak lagi digunakan
  void dispose() {
    _progressController.close();
  }
}
