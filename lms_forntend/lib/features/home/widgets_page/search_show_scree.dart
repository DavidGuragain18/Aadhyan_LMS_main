import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/features/book/model/book_model.dart';

class SearchShowScree extends ConsumerStatefulWidget {
  final BookModel bookModel;
  const SearchShowScree({super.key, required this.bookModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchShowScreeState();
}

class _SearchShowScreeState extends ConsumerState<SearchShowScree> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kLight,
            )),
        title: ReusableText(
            text: 'Books Details',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: kLight),
        backgroundColor: kButton,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 3, color: kButton),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 150,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: _getImageProvider("${widget.bookModel.image}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: ReusableText(
                          text: '${widget.bookModel.title}',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kButton,
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          '${widget.bookModel.subtitle}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kButton,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${widget.bookModel.description}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          color: kDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kButton,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Mark as Complete',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
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