import 'package:dio/dio.dart';
import 'package:face_shape/core/shared/constant/api_path.dart';
import 'package:face_shape/features/training/data/models/response/result_data_model.dart';
import 'package:face_shape/features/training/domain/entities/train_entitiy.dart';

abstract class TrainPreprocessDataSource {
  Future<TrainPreprocessEntity> getImagePreprocess();
}

abstract class TrainResultDataSource {
  Future<TrainResultEntity> getTrainResult();
}

class TrainPreprocessDataSourceImpl implements TrainPreprocessDataSource {
  final Dio _client;

  TrainPreprocessDataSourceImpl(this._client);
  @override
  Future<TrainPreprocessEntity> getImagePreprocess() async {
    try {
      // await _client.get(
      //   ApiUrl.Url_preprocessing,
      //   options: Options(headers: {}),
      // );
      final result = await _client.get(
        ApiPath.imageRandom,
        options: Options(headers: {}),
      );
      return TrainPreprocessModel.fromJson(result.data!);
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        error: e.error,
        response: e.response,
      );
    } catch (e) {
      rethrow;
    }
  }
}

class TrainResultDataSourceImpl implements TrainResultDataSource {
  final Dio _client;

  TrainResultDataSourceImpl(this._client);

  @override
  Future<TrainResultEntity> getTrainResult() async {
    try {
      final result = await _client.get(
        ApiPath.training,
        options: Options(headers: {}),
      );
      return TrainResultModel.fromJson(result.data!);
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        error: e.error,
        response: e.response,
      );
    } catch (e) {
      rethrow;
    }
  }
}
