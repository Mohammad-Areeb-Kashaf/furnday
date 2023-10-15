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
    featuredProductsList.bindStream(getFeaturedProducts()!);

    super.onInit();
  }

  Stream<List<ProductModel>>? getAllProducts() {
    var stream = _firestore.collection('all_products').snapshots();
    return stream
        .map((qShot) =>
            qShot.docs.map((doc) => ProductModel.fromJson(doc.data())).toList())
        .handleError((e) {
      printError(info: e.toString());
    });
  }

  Stream<List<ProductModel>>? getFeaturedProducts() {
    var stream = _firestore
        .collection('all_products')
        .where("featured", isEqualTo: true)
        .snapshots();
    return stream
        .map((qShot) =>
            qShot.docs.map((doc) => ProductModel.fromJson(doc.data())).toList())
        .handleError((e) {
      printError(info: e.toString());
    });
  }

  List<ProductModel>? getSelectedCategoryProducts(selectedCategory) {
    try {
      List<ProductModel> selectedCategoryProducts = products.where((product) {
        print(selectedCategory);
        print(product.category);
        return product.category!.contains(selectedCategory.toString());
      }).toList();

      return selectedCategoryProducts;
    } catch (e) {
      printError(info: e.toString());
      return null;
    }
  }
}
