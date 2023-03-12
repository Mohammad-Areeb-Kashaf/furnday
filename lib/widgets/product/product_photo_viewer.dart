import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_3/flutter_swiper_3.dart';
import 'package:furnday/constants.dart';
import 'package:photo_view/photo_view.dart';

class ProductPhotoViewer extends StatelessWidget {
  final List<String> photos;

  const ProductPhotoViewer({required this.photos});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 400, // adjust the height according to your requirement
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductPhotoView(
                        photoUrl: photos[index],
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: radius, bottomRight: radius),
                  child: CachedNetworkImage(
                    imageUrl: photos[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            itemCount: photos.length,
            pagination: const SwiperPagination(),
            control: const SwiperControl(
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          child: IconButton(
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      ],
    );
  }
}

class ProductPhotoView extends StatelessWidget {
  final String photoUrl;

  const ProductPhotoView({super.key, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(photoUrl),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.5,
          initialScale: PhotoViewComputedScale.contained,
          loadingBuilder: (context, event) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
