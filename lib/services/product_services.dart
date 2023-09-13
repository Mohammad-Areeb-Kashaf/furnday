import 'package:furnday/constants.dart';
import 'package:furnday/controllers/products_controller.dart';

class ProductServices {
  final _firestore = FirebaseFirestore.instance;
  var selectedCategory = '';
  var isLoading = false;

  Widget getAllProducts(BuildContext context,
      {gridCrossAxisCount, gridChildAspectRatio}) {
    return GetX<ProductsController>(
      builder: (controller) {
        if (controller.allProductsList.value.isNotEmpty) {
          var gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCrossAxisCount,
            childAspectRatio: gridChildAspectRatio,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          );
          return GridView.builder(
            gridDelegate: gridDelegate,
            physics: kScrollPhysics,
            shrinkWrap: true,
            itemCount: controller.allProductsList.value.length,
            itemBuilder: (context, index) =>
                ProductCard(product: controller.allProductsList.value[index]),
          );
        } else {
          return const CircularProgressIndicator(
            color: kYellowColor,
          );
        }
      },
    );
  }

  Widget getFeaturedProducts(BuildContext context,
      {required gridCrossAxisCount, required gridChildAspectRatio}) {
    try {
      return GetX<ProductsController>(
        builder: (controller) {
          var gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCrossAxisCount,
              childAspectRatio: gridChildAspectRatio,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10);
          return GridView.builder(
            gridDelegate: gridDelegate,
            physics: kScrollPhysics,
            shrinkWrap: true,
            itemCount: controller.featuredProductsList.length,
            itemBuilder: (context, index) {
              return ProductCard(
                  product: controller.featuredProductsList[index]);
            },
          );
        },
      );
    } catch (e) {
      printError(info: e.toString());
      return const Text('Something went wrong');
    }
  }

  Widget getCategories() {
    var categoriesStream =
        _firestore.collection("app").doc('app_data').get().asStream();

    try {
      return StreamBuilder(
        stream: categoriesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: kYellowColor,
            );
          } else if (snapshot.hasData) {
            List data = snapshot.data!.data()!['categories'];
            return ListView(
              physics: kScrollPhysics,
              shrinkWrap: true,
              children: List.generate(
                data.length,
                (index) => ListTile(
                  onTap: () {
                    selectedCategory = data[index].toString();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => Scaffold(
                          appBar: myAppBar(context),
                          body: SingleChildScrollView(
                            physics: kScrollPhysics,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProductSection(
                                  headingText: selectedCategory,
                                  productGridType:
                                      ProductGridType.selectedCategoryProducts,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  title: Text(data[index].toString()),
                ),
              ),
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      );
    } catch (e) {
      printError(info: e.toString());
      return const Text('Something went wrong');
    }
  }

  Widget getSelectedCategoryProducts(gridChildAspectRatio, gridCrossAxisCount) {
    try {
      return GetX<ProductsController>(
        builder: (controller) {
          var selectedCategoryProducts =
              controller.getSelectedCategoryProducts(selectedCategory);
          return selectedCategoryProducts!.isNotEmpty
              ? GridView.count(
                  crossAxisCount: gridCrossAxisCount,
                  childAspectRatio: gridChildAspectRatio,
                  physics: kScrollPhysics,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  children: List.generate(
                      selectedCategoryProducts.length,
                      (index) => ProductCard(
                          product: selectedCategoryProducts[index])),
                )
              : const Text('There is no product in this category');
        },
      );
    } catch (e) {
      printError(info: e.toString());
      return const Text('Something went wrong');
    }
  }

  Widget getRefurbishedProducts(gridChildAspectRatio, gridCrossAxisCount) {
    try {
      selectedCategory = "Refurbished";
      return GetX<ProductsController>(
        builder: (controller) {
          var selectedCategoryProducts =
              controller.getSelectedCategoryProducts(selectedCategory);
          return selectedCategoryProducts!.isNotEmpty
              ? GridView.count(
                  crossAxisCount: gridCrossAxisCount,
                  childAspectRatio: gridChildAspectRatio,
                  physics: kScrollPhysics,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  children: List.generate(
                      selectedCategoryProducts.length,
                      (index) => ProductCard(
                          product: selectedCategoryProducts[index])),
                )
              : const Text('There is no product in this category');
        },
      );
    } catch (e) {
      printError(info: e.toString());
      return const Text('Something went wrong');
    }
  }

  Widget getFurnitureProducts(gridChildAspectRatio, gridCrossAxisCount) {
    try {
      selectedCategory = "Furniture";
      return GetX<ProductsController>(
        builder: (controller) {
          var selectedCategoryProducts =
              controller.getSelectedCategoryProducts(selectedCategory);
          return selectedCategoryProducts!.isNotEmpty
              ? GridView.count(
                  crossAxisCount: gridCrossAxisCount,
                  childAspectRatio: gridChildAspectRatio,
                  physics: kScrollPhysics,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  children: List.generate(
                      selectedCategoryProducts.length,
                      (index) => ProductCard(
                          product: selectedCategoryProducts[index])),
                )
              : const Text('There is no product in this category');
        },
      );
    } catch (e) {
      printError(info: e.toString());
      return const Text('Something went wrong');
    }
  }

  Widget getHardwareProducts(gridChildAspectRatio, gridCrossAxisCount) {
    try {
      selectedCategory = "Hardware";
      return GetX<ProductsController>(
        builder: (controller) {
          var selectedCategoryProducts =
              controller.getSelectedCategoryProducts(selectedCategory);
          return selectedCategoryProducts!.isNotEmpty
              ? GridView.count(
                  crossAxisCount: gridCrossAxisCount,
                  childAspectRatio: gridChildAspectRatio,
                  physics: kScrollPhysics,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  children: List.generate(
                      selectedCategoryProducts.length,
                      (index) => ProductCard(
                          product: selectedCategoryProducts[index])),
                )
              : const Text('There is no product in this category');
        },
      );
    } catch (e) {
      printError(info: e.toString());
      return const Text('Something went wrong');
    }
  }
}
