import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
          return Image(
            image: FileImage(
              File(widget.images[index].path),
            ),
            fit: BoxFit.fill,
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

// void _requestAppDocumentsDirectory() {
//   setState(() {
//     _appDocumentsDirectory = getApplicationDocumentsDirectory();
//   });
// }
//
// Widget _buildDirectory(
//     BuildContext context, AsyncSnapshot<Directory?> snapshot) {
//   Text text = const Text('');
//   if (snapshot.connectionState == ConnectionState.done) {
//     if (snapshot.hasError) {
//       text = Text('Error: ${snapshot.error}');
//     } else if (snapshot.hasData) {
//       text = Text('path: ${snapshot.data!.path}');
//     } else {
//       text = const Text('path unavailable');
//     }
//   }
//   return Padding(padding: const EdgeInsets.all(16.0), child: text);
// }
}
