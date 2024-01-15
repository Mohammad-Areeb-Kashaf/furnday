import 'package:furnday/constants.dart';
import 'package:furnday/widgets/product/product_customisation_section.dart';
import 'package:furnday/widgets/product/product_review_form.dart';

class ProductScreen extends StatefulWidget {
  final String? productId;

  const ProductScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int selectedImage = 0;
  int _qty = 1;
  bool isLoading = false;
  late ProductModel product;
  late CartModel cartProduct;
  String? customisations;

  @override
  Widget build(BuildContext context) {
    return GetX<ProductsController>(builder: (controller) {
      final productIndex = controller.allProductsList.indexWhere(
        (product) => product.id == widget.productId,
      );
      product = controller.allProductsList[productIndex];
      cartProduct = product.toCartModel();
      return InternetChecker(
        child: LoadingOverlay(
          isLoading: isLoading,
          child: Scaffold(
            floatingActionButton: CartItemCountBtn(
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
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
                        photos: product.productImages!.toList(),
                      ),
                      const SizedBox(height: 10),
                      DecoratedCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: AutoSizeText(
                                product.category
                                    .toString()
                                    .replaceAll("[", '')
                                    .replaceAll(']', ''),
                                style: Theme.of(context).textTheme.labelMedium,
                                minFontSize: 14,
                                maxFontSize: 16,
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      product.name.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.black),
                                      minFontSize: 18,
                                      maxFontSize: 24,
                                      maxLines: 2,
                                    ),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: ProductPrice(
                                    mrp: product.mrp.toString(),
                                    discountedPrice:
                                        product.discountedPrice.toString(),
                                    mrpStyle: TextStyle(
                                        color:
                                            Theme.of(context).highlightColor),
                                    discountedPriceStyle: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                                ),
                                product.product3dView == true
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ElevatedButton(
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Product3dViewScreen(
                                                productId:
                                                    product.id.toString(),
                                              ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DecoratedCard(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: List.generate(
                                    product.description!.length,
                                    (index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              product.description![index].title
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                              minFontSize: 14,
                                              maxFontSize: 24,
                                              maxLines: 1,
                                            ),
                                            AutoSizeText(
                                              product.description![index].desc
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ProductCustomisationSection(
                                customisations: product.customisations,
                                onValueChanged: (String? value) {
                                  setState(() {
                                    customisations = value;
                                  });
                                },
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton.icon(
                              label: const Text(
                                'Add to Cart',
                              ),
                              onPressed: () async {
                                var cartController = Get.find<CartController>();
                                setState(() {
                                  isLoading = true;
                                });
                                cartProduct.customisations = customisations;
                                cartProduct.qty = _qty.toInt();
                                cartController.addToCart(
                                  cartProduct,
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
                                cartProduct.customisations = customisations;
                                cartController.addToCart(product.toCartModel());

                                setState(() {
                                  isLoading = false;
                                });
                                if (context.mounted) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyCartScreen()));
                                }
                              },
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      (product.productReviews!.toList().any((element) =>
                                  element.email ==
                                  FirebaseAuth.instance.currentUser?.email) ==
                              false)
                          ? ProductReviewForm(
                              productId: product.id.toString(),
                              submitReview: submitReview,
                            )
                          : const SizedBox.shrink(),
                      ProductReviewSection(
                        reviews: product.productReviews,
                        productId: product.id.toString(),
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
    });
  }

  submitReview(formKey, comment, rating, name, email) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        formKey.currentState!.save();
        var productReview = ProductReviews(
            comment: comment,
            rating: rating,
            date:
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            username: name,
            email: email);
        await FirebaseFirestore.instance
            .collection("all_products")
            .doc(widget.productId)
            .set({
          "productReviews": [productReview.toJson()]
        }, SetOptions(merge: true));
        setState(() {
          isLoading = false;
        });
        setState(() {});
      } catch (e) {
        printError(info: e.toString());
        setState(() {
          isLoading = true;
        });
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
