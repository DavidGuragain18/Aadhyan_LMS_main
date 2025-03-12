import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/features/competedbook/data/datasource/book_complter_remote_datasource.dart';
import 'package:learn_management_system/features/competedbook/presentation/state/book_complted_state.dart';

final bookCompletedViewModelProvider =
    StateNotifierProvider<BookCompletedViewModel, BookCompltedState>((ref) {
  return BookCompletedViewModel(
      bookComplterRemoteDatasource:
          ref.read(bookComplterRemoteDatasourceProvider));
});

class BookCompletedViewModel extends StateNotifier<BookCompltedState> {
  final BookComplterRemoteDatasource bookComplterRemoteDatasource;
  BookCompletedViewModel({required this.bookComplterRemoteDatasource})
      : super(BookCompltedState.initial());

  Future<void> fetchCompletedBooks() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );
    final result = await bookComplterRemoteDatasource.getCompletedBook();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (books) {
        state = state.copyWith(isLoading: false, bookCompletedModel: books);
      },
    );
  }

  Future<void> markAsComplete(String bookId) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );
    final result = await bookComplterRemoteDatasource.markasComplete(bookId);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        EasyLoading.showError(failure.error);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
        );
        EasyLoading.showSuccess('Completed');
        // fetchCompletedBooks();
      },
    );
  }

   // Simulated method to mark a book as completed locally
  Future<void> isBookCompleted(String bookId) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );
    
    // Simulating a delay to mimic network call
    await Future.delayed(Duration(seconds: 2));

    state = state.copyWith(
      isLoading: false,
      isBookCompleted: true,
    );

    EasyLoading.showSuccess('Marked as Completed');
  }

  // Method to check if the book is completed locally
  // bool isBookCompleted(String bookId) {
  //   return state.isBookCompleted;
  // }
}
