import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:learn_management_system/config/common/failure.dart';
import 'package:learn_management_system/config/constant/api_endpoints.dart';
import 'package:learn_management_system/core/network/httpservice.dart';
import 'package:learn_management_system/core/provider/flutter_secure_storage_provider.dart';
import 'package:learn_management_system/features/course/model/course_model.dart';

final courseRemoteDatasourceProvider = Provider<CourseRemoteDatasource>((ref) {
  return CourseRemoteDatasource(
      flutterSecureStorage: ref.read(flutterSecureStorageProvider),
      dio: ref.read(httpServiceProvider));
});

class CourseRemoteDatasource {
  final FlutterSecureStorage flutterSecureStorage;
  final Dio dio;
  CourseRemoteDatasource({
    required this.flutterSecureStorage,
    required this.dio,
  });

  Future<Either<Failure, List<CourseModel>>> getAllCourse() async {
    try {
      final url = ApiEndpoints.getAllCourse;
      Response response = await dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> courseJsonList = response.data['allCourse'];
        List<CourseModel> courses =
            courseJsonList.map((json) => CourseModel.fromJson(json)).toList();
        return Right(courses);
      } else {
        return Left(Failure(error: 'Failed to fetch courses'));
      }
    } on DioException catch (e) {
      return Left(
          Failure(error: e.response?.data['message'] ?? 'Unknown error'));
    }
  }

  Future<Either<Failure, bool>> selectCourse(String courseId) async {
    try {
      final url = ApiEndpoints.selectCourse;
      final token = await flutterSecureStorage.read(key: 'token');
      if (token == null) {
        return Left(Failure(error: 'An Unexpected error occurred'));
      }
      final decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['id'];
      if (userId == null) {
        return Left(Failure(error: 'An Unexpected error occurred'));
      }

      final response = await dio.put(url, data: {
        'userId': userId,
        'courseId': courseId,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(true);
      } else {
        return Left(Failure(error: 'Failed to select course'));
      }
    } on DioException catch (e) {
      return Left(
          Failure(error: e.response?.data['message'] ?? 'Unknown error'));
    }
  }
}
