import 'package:furnday/constants.dart';

class Product3dViewScreen extends StatefulWidget {
  const Product3dViewScreen({Key? key, required this.productId})
      : super(key: key);
  final String productId;

  @override
  Product3dViewScreenState createState() => Product3dViewScreenState();
}

class Product3dViewScreenState extends State<Product3dViewScreen> {
  List<ImageProvider> imageList = <ImageProvider>[];
  int rotationCount = 22;
  int swipeSensitivity = 1;
  bool allowSwipeToRotate = true;
  bool imagePrecached = true;

  void updateImageList(List<String> product3dImage) {
    for (int i = 1; i <= product3dImage.length; i++) {
      imageList.add(NetworkImage(product3dImage[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: GetX<ProductsController>(builder: (controller) {
        final productIndex = controller.allProductsList.indexWhere(
          (product) => product.id == widget.productId,
        );
        var product = controller.allProductsList[productIndex];
        updateImageList(product.product3dImages!.toList());
        return Scaffold(
          body: Center(
            child: ImageView360(
              key: UniqueKey(),
              imageList: imageList,
              autoRotate: false,
              rotationCount: rotationCount,
              swipeSensitivity: swipeSensitivity,
              allowSwipeToRotate: allowSwipeToRotate,
              onImageIndexChanged: (currentImageIndex) {},
            ),
          ),
        );
      }),
    );
  }
}
