import 'package:furnday/constants.dart';

class ProductsController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  var products = <ProductModel>[].obs;
  var featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    getAllProducts();
    getFeaturedProducts();
  }

  void getAllProducts() async {
    try {
      var allProductsResponse =
          await _firestore.collection('all_products').get();
      for (var doc in allProductsResponse.docs) {
        var data = doc.data();
        var product = ProductModel.fromJson(data);
        products.add(product);
      }

      print(products);
    } catch (e) {
      print("error in products controller");
      print(e);
    }
  }

  void getFeaturedProducts() async {
    try {
      var allProductsResponse = await _firestore
          .collection('all_products')
          .where("featured", isEqualTo: true)
          .get();
      for (var doc in allProductsResponse.docs) {
        var data = doc.data();
        var featuredProduct = ProductModel.fromJson(data);
        featuredProducts.add(featuredProduct);
      }
    } catch (e) {
      print(e);
    }
  }

  List<ProductModel>? getSelectedCategoryProducts(selectedCategory) {
    try {
      List<ProductModel> selectedCategoryProducts = products
          .where((product) => product.category!.contains(selectedCategory))
          .toList();
      print('$selectedCategory: $selectedCategoryProducts');
      return selectedCategoryProducts;
    } catch (e) {
      print(e);
      var errorData = {
        "errors": [e.toString()]
      };
      _firestore.collection("app").doc('errors').update(errorData);
      return null;
    }
  }
}
