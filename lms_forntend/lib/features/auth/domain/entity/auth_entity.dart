// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:learn_management_system/features/book/model/book_model.dart';
import 'package:learn_management_system/features/competedbook/data/model/book_completed_model.dart';
import 'package:learn_management_system/features/course/model/course_model.dart';

class AuthEntity extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? fullName;
  final String? email;
  final String? userName;
  final String? phoneNumber;
  final String? password;
  final bool? isAdmin;
  final List<CourseModel>? selectedCourse;
  final String? image;
  final List<BookModel>? books;
  final List<BookCompletedModel>? bookCompleted;

  AuthEntity(
      {this.id,
      this.fullName,
      this.email,
      this.userName,
      this.phoneNumber,
      this.password,
      this.isAdmin,
      this.selectedCourse,
      this.image,
      this.books,
      this.bookCompleted});

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        userName,
        phoneNumber,
        password,
        isAdmin,
        selectedCourse,
        image,
        bookCompleted
      ];

  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      isAdmin: json['isAdmin'],
      selectedCourse: json['selectedCourse'] != null
          ? (json['selectedCourse'] as List<dynamic>)
              .map((courseJson) => CourseModel.fromJson(courseJson))
              .toList()
          : null,
      books: json['books'] != null
          ? (json['books'] as List<dynamic>)
              .map((books) => BookModel.fromJson(books))
              .toList()
          : null,
      bookCompleted: json['bookCompleted'] != null
          ? (json['bookCompleted'] as List<dynamic>)
              .map((bookCompletedJson) =>
                  BookCompletedModel.fromJson(bookCompletedJson))
              .toList()
          : null,
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'password': password,
      'isAdmin': isAdmin,
      'selectedCourse':
          selectedCourse?.map((course) => course.toJson()).toList(),
      'books': books?.map((books) => books.toJson()).toList(),
      'bookCompleted': bookCompleted
          ?.map((bookCompleted) => bookCompleted.toJson())
          .toList(),
      'image': image,
    };
  }

  AuthEntity copyWith({
    String? id,
    String? fullName,
    String? email,
    String? userName,
    String? phoneNumber,
    String? password,
    bool? isAdmin,
    List<CourseModel>? selectedCourse, // Changed to CourseModel
    List<BookModel>? books, // Changed to CourseModel
    List<BookCompletedModel>? bookCompleted, // Changed to CourseModel
    String? image,
  }) {
    return AuthEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      isAdmin: isAdmin ?? this.isAdmin,
      books: books ?? this.books,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      bookCompleted: bookCompleted ?? this.bookCompleted,
      image: image ?? this.image,
    );
  }
}
