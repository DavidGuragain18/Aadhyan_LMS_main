import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn_management_system/config/common/failure.dart';
import 'package:learn_management_system/config/constant/api_endpoints.dart';
import 'package:learn_management_system/core/network/httpservice.dart';
import 'package:learn_management_system/core/provider/flutter_secure_storage_provider.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';
import 'package:learn_management_system/features/book/model/book_model.dart';
import 'package:learn_management_system/features/competedbook/data/model/book_completed_model.dart';
import 'package:learn_management_system/features/course/model/course_model.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDatasource>((ref) =>
    AuthRemoteDatasource(
        dio: ref.read(httpServiceProvider),
        flutterSecureStorage: ref.read(flutterSecureStorageProvider)));

class AuthRemoteDatasource {
  final Dio dio;
  final FlutterSecureStorage flutterSecureStorage;
  AuthRemoteDatasource({required this.dio, required this.flutterSecureStorage});

  Future<Either<Failure, bool>> register(AuthEntity authEntity) async {
    try {
      final url = ApiEndpoints.register;
      final response = await dio.post(url, data: authEntity.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(true);
      } else {
        return Left(Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response!.data['message']));
    }
  }

  Future<Either<Failure, AuthEntity>> login(
      String userName, String password) async {
    try {
      final url = ApiEndpoints.login;
      Response response = await dio.post(url, data: {
        "userName": userName,
        "password": password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data['token'];
        final userData = response.data['userData'];

        // Map selectedCourse to CourseModel objects
        List<CourseModel> selectedCourses = [];
        if (userData.containsKey('selectedCourse') &&
            userData['selectedCourse'] is List) {
          selectedCourses = (userData['selectedCourse'] as List)
              .map((course) => CourseModel(
                    id: course['_id'],
                    name: course['name'],
                    description: course['description'],
                    image: course['image'],
                  ))
              .toList();
        }

        // Map books to BookModel objects
        List<BookModel> books = [];
        if (response.data.containsKey('books') &&
            response.data['books'] is List) {
          books = (response.data['books'] as List)
              .map((book) => BookModel(
                  id: book['_id'],
                  title: book['title'],
                  subtitle: book['subtitle'] ?? "",
                  description: book['description'] ?? "",
                  image: book['image'] ?? "",
                  course: book['course'] ?? "",
                  level: book['level'] ?? ""))
              .toList();
        }

        // Map bookCompleted to BookCompletedModel objects
        List<BookCompletedModel> bookCompletedModel = [];
        if (userData.containsKey('bookCompleted') &&
            userData['bookCompleted'] is List) {
          bookCompletedModel = (userData['bookCompleted'] as List)
              .map((bookCompleted) => BookCompletedModel(
                  id: bookCompleted['_id'],
                  title: bookCompleted['title'],
                  subtitle: bookCompleted['subtitle'] ?? "",
                  description: bookCompleted['description'] ?? "",
                  image: bookCompleted['image'] ?? "",
                  course: bookCompleted['course'] ?? "",
                  level: bookCompleted['level'] ?? ""))
              .toList();
        }

        final authEntity = AuthEntity(
          id: userData['_id'],
          fullName: userData['fullName'],
          email: userData['email'],
          userName: userData['userName'],
          phoneNumber: userData['phoneNumber'],
          password: userData['password'],
          selectedCourse: selectedCourses,
          image: userData['image'],
          books: books, 
          bookCompleted:
              bookCompletedModel,
        );

        await flutterSecureStorage.write(key: "token", value: token);
        await flutterSecureStorage.write(key: 'userName', value: userName);
        await flutterSecureStorage.write(key: 'password', value: password);

        return Right(authEntity);
      } else {
        return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response!.data['message']));
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  
}
