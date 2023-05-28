import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';

class ProductImg extends StatefulWidget {
  const ProductImg({
    super.key,
    this.height,
    this.width,
    this.images,
  });
  final double? height, width;
  final List<String>? images;

  @override
  State<ProductImg> createState() => _ProductImgState();
}

class _ProductImgState extends State<ProductImg> {
  String imageUrl = '';
  final storageRef = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.images![0].toString();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kBorderRadiusCard,
      child: imageUrl.isNotEmpty
          ? CachedNetworkImage(
              fit: BoxFit.cover,
              height: widget.height,
              width: widget.width,
              imageUrl: imageUrl,
            )
          : const SizedBox.shrink(),
    );
  }
}
