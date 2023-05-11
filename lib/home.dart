import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'galler_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  late final List<CameraDescription> _cameras;
  int? _selectedCamera;
  Future? _cameraInitialization;

  @override
  void initState() {
    super.initState();
    _getCameras();
  }

  void _getCameras() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _selectedCamera = 0;
      _cameraController = CameraController(
        _cameras[_selectedCamera!],
        ResolutionPreset.ultraHigh,
      );
      _cameraInitialization = _cameraController!.initialize();
      setState(() {});
    }
  }

  void _switchCamera() async {
    if (_selectedCamera != null && _cameras.length > 1) {
      _selectedCamera = _selectedCamera == 0 ? 1 : 0;
      _cameraController = CameraController(
        _cameras[_selectedCamera!],
        ResolutionPreset.ultraHigh,
      );
      _cameraInitialization = _cameraController!.initialize();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera"),
      ),
      body: FutureBuilder(
          future: _cameraInitialization,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  CameraPreview(_cameraController!),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: _switchCamera,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.switch_camera_rounded),
                          ),
                        ),
                        GestureDetector(
                          onTap: _captureImage,
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                        ),
                        FutureBuilder<Directory>(
                          future: getTemporaryDirectory(),
                          builder: (context, dir) {
                            if (dir.connectionState == ConnectionState.done) {
                              final list = dir.data!.listSync();
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GalleryScreen(images: list.reversed.toList()),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    shape: BoxShape.circle,
                                    image: list.isNotEmpty
                                        ? DecorationImage(
                                            image:
                                                FileImage(File(list.last.path)),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  void _captureImage() async {
    await _cameraController?.takePicture();
    setState(() {});
  }
}
