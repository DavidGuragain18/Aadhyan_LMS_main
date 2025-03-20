import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/features/competedbook/presentation/viewmodel/book_complted_view_model.dart';

class BookCompletedView extends ConsumerStatefulWidget {
  const BookCompletedView({Key? key}) : super(key: key);

  @override
  ConsumerState<BookCompletedView> createState() => _BookCompletedViewState();
}

class _BookCompletedViewState extends ConsumerState<BookCompletedView> {
  ImageProvider _getProfileImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    } else {
      // Use a default image for invalid URLs
      return AssetImage('assets/images/logo.png');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(bookCompletedViewModelProvider.notifier).fetchCompletedBooks();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // No shadow
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: ReusableText(
          text: 'Completed Books',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        backgroundColor: Color(kButton.value), // Use your app's primary color
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final state = ref.watch(bookCompletedViewModelProvider);

          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.bookCompletedModel.isEmpty) {
            return Center(child: Text('No completed books found.'));
          } else {
            return ListView.builder(
              itemCount: state.bookCompletedModel.length,
              itemBuilder: (context, index) {
                final book = state.bookCompletedModel[index];
                return Card(
                  color: kButton,
                  elevation: 7,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: InkWell(
                    onTap: () {
                      
                    },
                    child: ListTile(
                      
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      leading: CircleAvatar(
                        backgroundImage:
                            _getProfileImageProvider("${book.image}"),
                        radius: 30,
                      ),
                      title: ReusableText(
                          text: '${book.title}',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kLight),
                     subtitle: ReusableText(
                          text: '${book.subtitle}',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: kLight),
                      onTap: () {
                        // Add navigation or action on tap if needed
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
