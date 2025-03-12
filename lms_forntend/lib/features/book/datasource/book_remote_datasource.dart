import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:learn_management_system/config/common/failure.dart';
import 'package:learn_management_system/config/constant/api_endpoints.dart';
import 'package:learn_management_system/core/network/httpservice.dart';
import 'package:learn_management_system/core/provider/flutter_secure_storage_provider.dart';
import 'package:learn_management_system/features/book/model/book_model.dart';

final bookRemoteDatasourceProvider = Provider<BookRemoteDatasource>((ref) {
  return BookRemoteDatasource(
      flutterSecureStorage: ref.read(flutterSecureStorageProvider),
      dio: ref.read(httpServiceProvider));
});

class BookRemoteDatasource {
  final FlutterSecureStorage flutterSecureStorage;
  final Dio dio;

  BookRemoteDatasource({required this.flutterSecureStorage, required this.dio});

//Book For Beginner level
  Future<Either<Failure, List<BookModel>>> getBeginnerLevelBooks() async {
    try {
      // final url = ApiEndpoints.getBeginnerBook;
      final token = await flutterSecureStorage.read(key: 'token');
      if (token == null) {
        return Left(Failure(error: 'An Unexpected token Error'));
      }
      final decodedToken = JwtDecoder.decode(token);
      final userID = decodedToken['id'];
      if (userID == null) {
        return Left(Failure(error: 'An Unexpected Error Occurred'));
      }
      final url = "${ApiEndpoints.getBeginnerBook}/$userID";
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData['success'] == true &&
            responseData.containsKey('books')) {
          List<BookModel> books = (responseData['books'] as List)
              .map((book) => BookModel.fromJson(book))
              .toList();
          return Right(books);
        } else {
          return Left(Failure(error: 'Books data not found in response'));
        }
      } else {
        return Left(Failure(error: response.data['message']));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  //Easy Level
  Future<Either<Failure, List<BookModel>>> getEasyLevelBooks() async {
    try {
      // final url = ApiEndpoints.getBeginnerBook;
      final token = await flutterSecureStorage.read(key: 'token');
      if (token == null) {
        return Left(Failure(error: 'An Unexpected token Error'));
      }
      final decodedToken = JwtDecoder.decode(token);
      final userID = decodedToken['id'];
      if (userID == null) {
        return Left(Failure(error: 'An Unexpected Error Occurred'));
      }
      final url = "${ApiEndpoints.getEasyBook}/$userID";
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData['success'] == true &&
            responseData.containsKey('books')) {
          List<BookModel> books = (responseData['books'] as List)
              .map((book) => BookModel.fromJson(book))
              .toList();
          return Right(books);
        } else {
          return Left(Failure(error: 'Books data not found in response'));
        }
      } else {
        return Left(Failure(error: response.data['message']));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  //Medium Level
  Future<Either<Failure, List<BookModel>>> getMediumLevelBooks() async {
    try {
      // final url = ApiEndpoints.getBeginnerBook;
      final token = await flutterSecureStorage.read(key: 'token');
      if (token == null) {
        return Left(Failure(error: 'An Unexpected token Error'));
      }
      final decodedToken = JwtDecoder.decode(token);
      final userID = decodedToken['id'];
      if (userID == null) {
        return Left(Failure(error: 'An Unexpected Error Occurred'));
      }
      final url = "${ApiEndpoints.getMediumBook}/$userID";
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData['success'] == true &&
            responseData.containsKey('books')) {

          List<BookModel> books = (responseData['books'] as List)
              .map((book) => BookModel.fromJson(book))
              .toList();
          return Right(books);
        } else {
          return Left(Failure(error: 'Books data not found in response'));
        }
      } else {
        return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  //Hard Level
  Future<Either<Failure, List<BookModel>>> getHardLevelBooks() async {
    try {
      // final url = ApiEndpoints.getBeginnerBook;
      final token = await flutterSecureStorage.read(key: 'token');
      if (token == null) {
        return Left(Failure(error: 'An Unexpected token Error'));
      }
      final decodedToken = JwtDecoder.decode(token);
      final userID = decodedToken['id'];
      if (userID == null) {
        return Left(Failure(error: 'An Unexpected Error Occurred'));
      }
      final url = "${ApiEndpoints.getHardBook}/$userID";
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData['success'] == true &&
            responseData.containsKey('books')) {
          // List<BookModel> books = (responseData['books'] as List)
          //     .map((book) => BookModel(
          //           id: book['_id'],
          //           title: book['title'],
          //           subtitle: book['subtitle'] ?? '',
          //           description: book['description'] ?? '',
          //           image: book['image'] ?? '',
          //           course: book['course'] ?? '',
          //           level: book['level'] ?? '',
          //         ))
          //     .toList();
          List<BookModel> books = (responseData['books'] as List)
              .map((book) => BookModel.fromJson(book))
              .toList();
          return Right(books);
        } else {
          return Left(Failure(error: 'Books data not found in response'));
        }
      } else {
        return Left(Failure(error: response.data['message']));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  //Advance Level
  Future<Either<Failure, List<BookModel>>> getAdvanceLevelBooks() async {
    try {
      // final url = ApiEndpoints.getBeginnerBook;
      final token = await flutterSecureStorage.read(key: 'token');
      if (token == null) {
        return Left(Failure(error: 'An Unexpected token Error'));
      }
      final decodedToken = JwtDecoder.decode(token);
      final userID = decodedToken['id'];
      if (userID == null) {
        return Left(Failure(error: 'An Unexpected Error Occurred'));
      }
      final url = "${ApiEndpoints.getAdvanceBook}/$userID";
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData['success'] == true &&
            responseData.containsKey('books')) {
          List<BookModel> books = (responseData['books'] as List)
              .map((book) => BookModel(
                    id: book['_id'],
                    title: book['title'],
                    subtitle: book['subtitle'] ?? '',
                    description: book['description'] ?? '',
                    image: book['image'] ?? '',
                    course: book['course'] ?? '',
                    level: book['level'] ?? '',
                  ))
              .toList();
          return Right(books);
        } else {
          return Left(Failure(error: 'Books data not found in response'));
        }
      } else {
        return Left(Failure(error: response.data['message']));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<BookModel>>> searchBooks(String keyword) async {
    try {
      final token = await flutterSecureStorage.read(key: 'token');
      if (token == null) {
        return Left(Failure(error: 'An Unexpected token Error'));
      }
      final decodedToken = JwtDecoder.decode(token);
      final userID = decodedToken['id'];
      if (userID == null) {
        return Left(Failure(error: 'An Unexpected Error Occurred'));
      }
      final selectedCourses = decodedToken['selectedCourse'] as List<dynamic>;
      if (selectedCourses.isEmpty) {
        return Left(Failure(error: 'No selected course found'));
      }
      final selectedCourseId = selectedCourses[0]['_id'];
      final url =
          "${ApiEndpoints.searchBook}/$userID/$selectedCourseId/$keyword";

      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['success'] == true &&
            responseData.containsKey('books')) {
          final List<BookModel> books = (responseData['books'] as List)
              .map((book) => BookModel.fromJson(book))
              .toList();
          return Right(books);
        } else {
          return Left(Failure(error: 'Books data not found in response'));
        }
      } else {
        return Left(Failure(
            error:
                'Failed to load books. Status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.toString()));
    } catch (e) {
      return Left(Failure(error: 'Unexpected error: $e'));
    }
  }
}
