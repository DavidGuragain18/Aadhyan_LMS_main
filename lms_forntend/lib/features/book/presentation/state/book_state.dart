import 'package:learn_management_system/features/book/model/book_model.dart';

class BookState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final List<BookModel>? books;

  BookState({
    required this.isLoading,
    this.error,
    this.showMessage = false,
     this.books,
  });

  factory BookState.initial() {
    return BookState(
      isLoading: false,
      error: null,
      // books: [],
    );
  }

  BookState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    List<BookModel>? books,
  }) {
    return BookState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
      books: books ?? this.books,
    );
  }
}
