import 'package:furnday/constants.dart';

class ProductReviewForm extends StatefulWidget {
  const ProductReviewForm(
      {super.key, required this.productId, required this.submitReview});
  final String productId;
  final Function submitReview;

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
                maxLines: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              const AutoSizeText(
                "Your email address will not be published.",
                minFontSize: 10,
                maxFontSize: 18,
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const AutoSizeText(
                    "Your rating",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    minFontSize: 14,
                    maxFontSize: 24,
                    maxLines: 1,
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
              const SizedBox(
                height: 10,
              ),
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
                        name = value.toString().capitalize.toString();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
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
              const SizedBox(height: 10),
              TextFormField(
                controller: commentController,
                keyboardType: TextInputType.name,
                minLines: 5,
                maxLines: 50,
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
              const SizedBox(height: 10),
              MaterialButton(
                height: 48,
                shape: RoundedRectangleBorder(borderRadius: kBorderRadiusCard),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  comment = commentController.text.toString();
                  name = nameController.text.toString().capitalize.toString();
                  email = emailController.text.toString().toLowerCase();
                  widget.submitReview(_formKey, comment, rating, name, email);
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
