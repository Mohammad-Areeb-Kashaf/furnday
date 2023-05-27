import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';

class ProductImg extends StatefulWidget {
  const ProductImg({
    super.key,
    this.height,
    this.width,
    this.imagePath = '',
    this.imageName = '',
  });
  final double? height, width;
  final String imagePath;
  final String imageName;

  @override
  State<ProductImg> createState() => _ProductImgState();
}

class _ProductImgState extends State<ProductImg> {
  late String imageUrl;
  final _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    imageUrl = '';
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    print('imagePath: ${widget.imagePath}');
    print('imageName: ${widget.imageName}');

    final ref = _storage.ref();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kBorderRadiusCard,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        height: widget.height,
        width: widget.width,
        imageUrl: "https://shop.furnday.com/wp-content/uploads/2022/09/Bed.jpg",
      ),
    );
  }
}
