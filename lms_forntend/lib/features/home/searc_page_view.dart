import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/features/book/presentation/view_model/book_view_model.dart';

class SearcPageView extends ConsumerStatefulWidget {
  const SearcPageView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearcPageViewState();
}

class _SearcPageViewState extends ConsumerState<SearcPageView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            ref.read(bookViewModelProvider.notifier).getBeginnerBook();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: ReusableText(
          text: 'Search Books',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        backgroundColor: Color(kButton.value),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: searchController,
              onChanged: (value) {
                ref.read(bookViewModelProvider.notifier).getSearchBooks(value);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    ref
                        .read(bookViewModelProvider.notifier)
                        .getSearchBooks(searchController.text);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: state.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : state.books!.isEmpty
                      ? Center(
                          child: Text('No results found.'),
                        )
                      : ListView.builder(
                          itemCount: state.books!.length,
                          itemBuilder: (context, index) {
                            final book = state.books![index];
                            return ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoute.booksViewRoute,
                                  arguments: book,
                                );
                              },
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: _getImageProvider("${book.image}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              trailing: SizedBox(
                                width: 150,
                                child: ReusableText(
                                  text: book.title!,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 18,
                                  color: Color(kButton.value),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    } else if (imageUrl.startsWith('data:image')) {
      return MemoryImage(base64Decode(imageUrl.split(',').last));
    } else if (imageUrl.isNotEmpty) {
      // Assuming this case handles local file paths.
      return FileImage(File(imageUrl));
    } else {
      // Use a default image for invalid URLs
      return AssetImage('assets/images/logo.png');
    }
  }
}
