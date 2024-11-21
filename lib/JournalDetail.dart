import'package:flutter/material.dart';
import 'package:untitled/journal_entry.dart';
import'dart:io';

class JournalDetail extends StatelessWidget {
  final JournalEntry entry;

  const JournalDetail({Key? key, required this.entry}) : super(key: key);

  Widget _buildImageGallery(List<String> imagePaths) {
    if (imagePaths.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Scroll horizontally
        itemCount: imagePaths.length,
        itemBuilder: (context, imageIndex) {
          return Container(
            width: 150, // Fixed width for each image
            margin: const EdgeInsets.symmetric(horizontal: 8.0), // Spacing between images
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(imagePaths[imageIndex])),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
              border: Border.all(color: Colors.grey.shade300), // Optional: Border
            ),
          );
        },
      ),
    );
  }

  // Widget _buildImageGallery(List<String> imagePaths) {
  //   if (imagePaths.isEmpty) return const SizedBox.shrink();
  //
  //   return Container(
  //     height: 200,
  //     child: PageView.builder(
  //       itemCount: imagePaths.length,
  //       itemBuilder: (context, imageIndex) {
  //         return Container(
  //           width: double.infinity,
  //           decoration: BoxDecoration(
  //             image: DecorationImage(
  //               image: FileImage(File(imagePaths[imageIndex])),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(entry.title, style: const TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (entry.imagePaths.isNotEmpty)
                _buildImageGallery(entry.imagePaths),
              const SizedBox(height: 16),

              // Container(
              //     width: double.infinity,
              //     height: 300,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: FileImage(File(entry.imagePaths[0])),
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              const SizedBox(height: 16),
              Text(
                entry.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                entry.content,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
