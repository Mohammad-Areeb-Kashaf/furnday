import 'package:flutter/material.dart';
import 'package:furnday/widgets/product_photo_view_wrapper.dart';

class ProductScreen extends StatelessWidget {
  final String productName;
  final String productDescription;
  final String productPrice;
  final List<String> productImages;
  final List<Map<String, dynamic>> reviews;

  const ProductScreen({
    Key? key,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImages,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductPhotoViewWrapper(
                  imageProviders:
                      productImages.map((url) => NetworkImage(url)).toList(),
                ),
              ));
            },
            child: Hero(
              tag: productImages[0],
              child: AspectRatio(
                aspectRatio: 1.0,
                child: PhotoView(
                  imageProvider: NetworkImage(productImages[0]),
                  loadingBuilder: (context, event) =>
                      const Center(child: CircularProgressIndicator()),
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Text('Error loading image.')),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  productDescription,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '\$$productPrice',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Reviews',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return ListTile(
                  title: Text(review['user']),
                  subtitle: Text(review['comment']),
                  trailing: Text('${review['rating']} stars'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
