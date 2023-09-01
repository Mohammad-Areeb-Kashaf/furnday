import 'package:furnday/constants.dart';
import 'package:furnday/widgets/product/product_review_form.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel product;

  const ProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int selectedImage = 0;
  int _qty = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: LoadingOverlay(
        isLoading: isLoading,
        child: Scaffold(
          floatingActionButton: CartItemCountBtn(
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const MyCartScreen(),
                ),
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: kWhiteBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: kScrollPhysics,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProductPhotoViewer(
                      photos: widget.product.productImages!.toList(),
                    ),
                    const SizedBox(height: 10),
                    DecoratedCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: AutoSizeText(
                              widget.product.category
                                  .toString()
                                  .replaceAll("[", '')
                                  .replaceAll(']', ''),
                              style: Theme.of(context).textTheme.labelMedium,
                              maxFontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  widget.product.name.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.black),
                                  maxFontSize: 24,
                                ),
                                const StarRating(
                                  rating: 4.5,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ProductPrice(
                                  mrp: widget.product.mrp.toString(),
                                  discountedPrice:
                                      widget.product.discountedPrice.toString(),
                                  mrpStyle: TextStyle(
                                      color: Theme.of(context).highlightColor),
                                  discountedPriceStyle: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              ),
                              widget.product.product3dView == true
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: ElevatedButton(
                                        onPressed: () => Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const Product3dViewScreen(),
                                          ),
                                        ),
                                        child: const Text(
                                          "View in 3D",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DecoratedCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: List.generate(
                                  widget.product.description!.length,
                                  (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            widget.product.description![index]
                                                .title
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                            maxFontSize: 24,
                                          ),
                                          AutoSizeText(
                                            widget.product.description![index]
                                                .desc
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ProductQuantity(
                              qty: _qty,
                              valueChanged: valueChanged,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const AutoSizeText(
                          'Customize',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          maxFontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton.icon(
                            label: const AutoSizeText(
                              'Add to Cart',
                            ),
                            onPressed: () async {
                              var cartController = Get.find<CartController>();
                              setState(() {
                                isLoading = true;
                              });
                              await cartController.addToCart(
                                productCartItem: widget.product.toCartModel(),
                                qty: _qty,
                              );
                              setState(() {
                                isLoading = false;
                              });
                            },
                            icon: Icon(
                              Icons.add_shopping_cart,
                              size: 32,
                              color: Theme.of(context).primaryColor,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                kWhiteBackground,
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: kBorderRadiusCard,
                                ),
                              ),
                              side: MaterialStateProperty.all(
                                BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: kBorderRadiusCard,
                            ),
                            color: Theme.of(context).primaryColor,
                            onPressed: () async {
                              var cartController = Get.find<CartController>();
                              setState(() {
                                isLoading = true;
                              });
                              await cartController.addToCart(
                                productCartItem: widget.product.toCartModel(),
                                qty: _qty,
                              );
                              setState(() {
                                isLoading = false;
                              });
                              if (context.mounted) {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const MyCartScreen()));
                              }
                            },
                            child: AutoSizeText(
                              'Buy Now',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              maxFontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    (widget.product.productReviews!.toList().any((element) =>
                                element.email ==
                                FirebaseAuth.instance.currentUser!.email) ==
                            false)
                        ? ProductReviewForm(
                            productId: widget.product.id.toString(),
                            submitReview: submitReview,
                          )
                        : const SizedBox.shrink(),
                    ProductReviewSection(
                      reviews: widget.product.productReviews,
                      productId: widget.product.id.toString(),
                    ),
                    const SizedBox(height: 10),
                    const ProductSection(
                      headingText: "You might also like",
                      productGridType: ProductGridType.allProducts,
                    ),
                    const SizedBox(height: 10),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  submitReview(formKey, comment, rating, name, email) async {
    if (!formKey.currentState!.validate()) {
    } else {
      setState(() {
        isLoading = true;
      });
      formKey.currentState!.save();
      try {
        var productReview = ProductReviews(
            comment: comment,
            rating: rating,
            date:
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            username: name,
            email: email);
        await FirebaseFirestore.instance
            .collection("all_products")
            .doc(widget.product.id)
            .update(
          {
            "productReviews": [productReview.toJson()]
          },
        );
        setState(() {
          isLoading = false;
        });
        setState(() {});
      } catch (e) {
        setState(() {
          isLoading = true;
        });
        var errorData = {
          "errors": [e.toString()]
        };
        await FirebaseFirestore.instance
            .collection("app")
            .doc('errors')
            .update(errorData);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  valueChanged(int qty) {
    setState(() {
      _qty = qty;
    });
  }
}
