import 'package:furnday/constants.dart';

class ProductImg extends StatefulWidget {
  const ProductImg({
    super.key,
    this.height,
    this.width,
    this.image,
  });
  final double? height, width;
  final String? image;

  @override
  State<ProductImg> createState() => _ProductImgState();
}

class _ProductImgState extends State<ProductImg> {
  String imageUrl = '';
  final storageRef = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.image.toString();
  }

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: kBorderRadiusCard,
      child: imageUrl.isNotEmpty
          ? CachedNetworkImage(
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
              ),
              fit: BoxFit.fill,
              height: widget.height,
              width: widget.width,
              imageUrl: imageUrl,
            )
          : const SizedBox.shrink(),
    );
  }
}
