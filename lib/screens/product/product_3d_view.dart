import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

class Product3dView extends StatefulWidget {
  const Product3dView({Key? key}) : super(key: key);

  @override
  _Product3dViewState createState() => _Product3dViewState();
}

class _Product3dViewState extends State<Product3dView> {
  List<ImageProvider> imageList = <ImageProvider>[];
  int rotationCount = 22;
  int swipeSensitivity = 1;
  bool allowSwipeToRotate = true;
  bool imagePrecached = true;

  @override
  void initState() {
    super.initState();
    updateImageList(context);
  }

  void updateImageList(BuildContext context) {
    for (int i = 1; i <= 21; i++) {
      imageList.add(AssetImage('assets/s$i.png'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ImageView360(
          key: UniqueKey(),
          imageList: imageList,
          autoRotate: false,
          rotationCount: rotationCount,
          swipeSensitivity: swipeSensitivity,
          allowSwipeToRotate: allowSwipeToRotate,
          onImageIndexChanged: (currentImageIndex) {
            print("currentImageIndex: $currentImageIndex");
          },
        ),
      ),
    );
  }
}
