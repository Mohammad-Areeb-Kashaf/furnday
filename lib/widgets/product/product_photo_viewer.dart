import 'package:furnday/constants.dart';

class ProductPhotoViewer extends StatelessWidget {
  final List<String> photos;

  const ProductPhotoViewer({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 400,
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
                      bottomLeft: kRadius, bottomRight: kRadius),
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
          loadingBuilder: (context, event) {
            return const Center(
              child: SpinKitFoldingCube(
                color: kYellowColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
