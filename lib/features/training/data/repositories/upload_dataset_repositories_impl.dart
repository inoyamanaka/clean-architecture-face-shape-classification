// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:face_shape/core/error/failures.dart';
import 'package:face_shape/features/training/data/datasources/upload_dataset_datasource.dart';
import 'package:face_shape/features/training/data/models/request/train_request.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';
import 'package:face_shape/features/training/domain/repositories/upload_dataset_repositories.dart';

class UploadDatasetRepositoryImpl implements UploadDatasetRepository {
  final UploadDatasetDataSource uploadDatasetDataSource;

  UploadDatasetRepositoryImpl(this.uploadDatasetDataSource);

  // Deklarasi StreamController untuk kemajuan upload
  final _progressController = StreamController<double>();

  // Getter untuk mendapatkan Stream kemajuan upload
  Stream<double> get progressStream => _progressController.stream;

  @override
  Future<Either<Failure, UploadDatasetEntity>> upload(
      UploadDatasetFilepathReq filepath) async {
    final remoteUploadMessage = await uploadDatasetDataSource.upload(filepath);
    return Right(remoteUploadMessage);
  }

  Stream<double> listenToUploadProgress() {
    // Menggunakan Completer untuk membuat Future yang akan diisi dengan progressPercent
    final ap = uploadDatasetDataSource.progressStream;

    // Mengembalikan Future yang akan diisi dengan progressPercent
    return ap;
  }

  void dispose() {
    _progressController.close();
  }
}
