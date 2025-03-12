import 'package:json_annotation/json_annotation.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';
import 'package:learn_management_system/features/book/model/book_model.dart';
import 'package:learn_management_system/features/competedbook/data/model/book_completed_model.dart';
import 'package:learn_management_system/features/course/model/course_model.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  final String? fullName;
  final String? email;
  final String? userName;
  final String? phoneNumber;
  final String? password;
  final List<CourseModel>? selectedCourse;
  final String? image;
  final List<BookModel>? books;
  final List<BookCompletedModel>? bookCompleted;

  AuthApiModel({
    this.fullName,
    this.email,
    this.userName,
    this.phoneNumber,
    this.password,
    this.selectedCourse,
    this.image,
    this.books,
    this.bookCompleted,
  });

  // Convert from AuthEntity to AuthApiModel
  factory AuthApiModel.fromEntity(AuthEntity authEntity) {
    return AuthApiModel(
      fullName: authEntity.fullName,
      email: authEntity.email,
      userName: authEntity.userName,
      phoneNumber: authEntity.phoneNumber,
      password: authEntity.password,
      selectedCourse: authEntity.selectedCourse,
      image: authEntity.image,
      books: authEntity.books,
      bookCompleted: authEntity.bookCompleted,
    );
  }

  // JSON serialization
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // Convert to AuthEntity
  AuthEntity toEntity() {
    return AuthEntity(
      fullName: fullName,
      email: email,
      userName: userName,
      phoneNumber: phoneNumber,
      password: password,
      selectedCourse: selectedCourse,
      image: image,
      books: books,
      bookCompleted: bookCompleted,
    );
  }
}
