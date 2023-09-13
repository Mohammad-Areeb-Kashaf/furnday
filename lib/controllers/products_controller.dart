import 'package:furnday/constants.dart';

class ProductsController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final allProductsList = <ProductModel>[].obs;
  var featuredProductsList = <ProductModel>[].obs;
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  List<ProductModel> get products => allProductsList;

  @override
  void onInit() async {
    allProductsList.bindStream(getAllProducts()!);
    getFeaturedProducts();
    super.onInit();
  }

  Stream<List<ProductModel>>? getAllProducts() {
    var stream = _firestore.collection('all_products').snapshots();
    return stream
        .map((qShot) =>
            qShot.docs.map((doc) => ProductModel.fromJson(doc.data())).toList())
        .handleError((e) {
      print("This is the error in stream: ${e.toString()}");
    });
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
        featuredProductsList.add(featuredProduct);
      }
    } catch (e) {
      printError(info: e.toString());
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
      printError(info: e.toString());
      return null;
    }
  }
}
