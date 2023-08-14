import 'package:furnday/constants.dart';
import 'package:furnday/controllers/products_controller.dart';

class ProductReviewForm extends StatefulWidget {
  const ProductReviewForm({super.key, required this.productId});
  final String productId;

  @override
  State<ProductReviewForm> createState() => _ProductReviewFormState();
}

class _ProductReviewFormState extends State<ProductReviewForm> {
  String name = '', email = '', comment = '';
  double rating = 0.0;
  final TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      commentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    return DecoratedCard(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AutoSizeText(
                "Review this product",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                minFontSize: 16,
                maxFontSize: 26,
              ),
              const Spacer(),
              const AutoSizeText(
                "Your email address will not be published.",
                minFontSize: 10,
                maxFontSize: 18,
              ),
              const Spacer(),
              Row(
                children: [
                  const AutoSizeText(
                    "Your rating",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    minFontSize: 14,
                    maxFontSize: 24,
                  ),
                  StarRating(
                    rating: rating,
                    onRatingChanged: (starRating) => setState(
                      () {
                        rating = starRating;
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: kBorderRadiusCard,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: kBorderRadiusCard,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name is Required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        name = value.toString().trim();
                      },
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: kBorderRadiusCard,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: kBorderRadiusCard,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email Address is Required';
                        } else if (value !=
                            FirebaseAuth.instance.currentUser!.email) {
                          return 'You are signed in with different email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value.toString().trim();
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              TextFormField(
                controller: commentController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Your Review',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: kBorderRadiusCard,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: kBorderRadiusCard,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Review is Required';
                  }
                  return null;
                },
                onSaved: (value) {
                  comment = value.toString().trim();
                },
              ),
              ElevatedButton(
                onPressed: () => submitReview(),
                child: AutoSizeText(
                  'Submit',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  maxFontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  submitReview() async {
    if (!_formKey.currentState!.validate()) {
    } else {
      _formKey.currentState!.save();
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
            .doc(widget.productId)
            .update(
          {
            "productReviews": [productReview.toJson()]
          },
        );
        productsController.update();
      } catch (e) {
        var errorData = {
          "errors": [e.toString()]
        };
        await FirebaseFirestore.instance
            .collection("app")
            .doc('errors')
            .update(errorData);
      }
    }
  }
}
