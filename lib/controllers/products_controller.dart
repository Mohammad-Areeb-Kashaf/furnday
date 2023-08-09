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
      var itemProducts = <ProductModel>[];
      var allProductsResponse =
          await _firestore.collection('all_products').get();
      var data = allProductsResponse.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        var product = ProductModel.fromJson(data);
        itemProducts.add(product);
        return itemProducts;
      });
      products.value = data.toList()[0];
      print(products);
    } catch (e) {
      print(e);
    }
  }

  void getFeaturedProducts() async {
    try {
      var itemProducts = <ProductModel>[];
      var allProductsResponse = await _firestore
          .collection('all_products')
          .where("featured", isEqualTo: true)
          .get();
      var data = allProductsResponse.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        var product = ProductModel.fromJson(data);
        itemProducts.add(product);
        return itemProducts;
      });
      featuredProducts.value = data.toList()[0];
      print(products);
    } catch (e) {
      print(e);
    }
  }
}
