import 'package:dio/dio.dart';
import 'package:face_shape/core/shared/constant/api_path.dart';
import 'package:face_shape/features/classification/data/models/response/get_image_model.dart';
import 'package:face_shape/features/classification/domain/entities/user_image.dart';

abstract class ResClassificationRemoteDataSource {
  Future<DataImageEntity> getImageAtt();
}

class ResClassificationRemoteDataSourceImpl
    implements ResClassificationRemoteDataSource {
  final Dio client;

  ResClassificationRemoteDataSourceImpl(this.client);

  @override
  Future<DataImageEntity> getImageAtt() async {
    try {
      final response = await client.get<Map<String, dynamic>>(ApiPath.image,
          options: Options(headers: {}));
      print(response);
      return GetImageModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        error: e.error,
        response: e.response,
      );
    } catch (e) {
      throw ();
    }
  }
}
