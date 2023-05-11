import 'dart:io';

import 'package:camera_video_demo/photo_view.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  final List<FileSystemEntity> images;

  const GalleryScreen({Key? key, required this.images}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PhotoViewScreen(images: widget.images, index: index),
                ),
              );
            },
            child: Image(
              image: FileImage(
                File(widget.images[index].path),
              ),
              fit: BoxFit.fill,
            ),
          );
        },
      ),
      // body: GridView.count(
      //     crossAxisCount: 3,
      //     mainAxisSpacing: 1,
      //     crossAxisSpacing: 1,
      //     children: widget.images
      //         .map(
      //           (e) => Image(
      //             image: FileImage(
      //               File(e.path),
      //             ),
      //           ),
      //         )
      //         .toList()),
    );
  }
}
