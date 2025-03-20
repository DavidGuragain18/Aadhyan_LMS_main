import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/scroll_view.dart';
import 'package:learn_management_system/features/book/model/book_model.dart';
import 'package:learn_management_system/features/competedbook/data/model/book_completed_model.dart';

class BookCompltedState {
  final bool isLoading;
  final bool? isBookCompleted;
  final String? error;
  final bool showMessage;
  final List<BookCompletedModel> bookCompletedModel;

  BookCompltedState({
    required this.isLoading,
    this.error,
    this.isBookCompleted,
    this.showMessage = false,
    required this.bookCompletedModel,
  });

  factory BookCompltedState.initial() {
    return BookCompltedState(
      isLoading: false,
      isBookCompleted: false,
      error: null,
      bookCompletedModel: [],
    );
  }

  BookCompltedState copyWith({
    bool? isLoading,
    bool? isBookCompleted,
    String? error,
    bool? showMessage,
     List<BookCompletedModel>? bookCompletedModel,
  }) {
    return BookCompltedState(
      isLoading: isLoading ?? this.isLoading,
      isBookCompleted: isBookCompleted ?? this.isBookCompleted,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
      bookCompletedModel: bookCompletedModel ?? this.bookCompletedModel,
    );
  }


}
