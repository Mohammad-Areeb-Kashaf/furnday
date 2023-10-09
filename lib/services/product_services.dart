import 'package:furnday/constants.dart';

class ProductServices {
  final _firestore = FirebaseFirestore.instance;
  var selectedCategory = '';
  var isLoading = false;

  Widget getAllProducts(BuildContext context, {gridCrossAxisCount}) {
    return GetX<ProductsController>(
      builder: (controller) {
        if (controller.allProductsList.isNotEmpty) {
          return DynamicHeightGridView(
            crossAxisCount: gridCrossAxisCount,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            physics: kScrollPhysics,
            shrinkWrap: true,
            itemCount: controller.allProductsList.length,
            builder: (context, index) =>
                ProductCard(product: controller.allProductsList[index]),
          );
        } else {
          return const CircularProgressIndicator(
            color: kYellowColor,
          );
        }
      },
    );
  }

  Widget getFeaturedProducts(
    BuildContext context, {
    required gridCrossAxisCount,
  }) {
    try {
      return GetX<ProductsController>(
        builder: (controller) {
          return DynamicHeightGridView(
            crossAxisCount: gridCrossAxisCount,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            physics: kScrollPhysics,
            shrinkWrap: true,
            itemCount: controller.featuredProductsList.length,
            builder: (context, index) =>
                ProductCard(product: controller.featuredProductsList[index]),
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
                                  selectedCategory: data[index].toString(),
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

  Widget getSelectedCategoryProducts(gridCrossAxisCount, selectedCategory) {
    try {
      return GetX<ProductsController>(
        builder: (controller) {
          var selectedCategoryProducts =
              controller.getSelectedCategoryProducts(selectedCategory);
          return selectedCategoryProducts!.isNotEmpty
              ? DynamicHeightGridView(
                  crossAxisCount: gridCrossAxisCount,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  physics: kScrollPhysics,
                  shrinkWrap: true,
                  itemCount: selectedCategoryProducts.length,
                  builder: (context, index) =>
                      ProductCard(product: selectedCategoryProducts[index]),
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
              ? DynamicHeightGridView(
                  crossAxisCount: gridCrossAxisCount,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  physics: kScrollPhysics,
                  shrinkWrap: true,
                  itemCount: selectedCategoryProducts.length,
                  builder: (context, index) =>
                      ProductCard(product: selectedCategoryProducts[index]),
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
              ? DynamicHeightGridView(
                  crossAxisCount: gridCrossAxisCount,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  physics: kScrollPhysics,
                  shrinkWrap: true,
                  itemCount: selectedCategoryProducts.length,
                  builder: (context, index) =>
                      ProductCard(product: selectedCategoryProducts[index]),
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
              ? DynamicHeightGridView(
                  crossAxisCount: gridCrossAxisCount,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  physics: kScrollPhysics,
                  shrinkWrap: true,
                  itemCount: selectedCategoryProducts.length,
                  builder: (context, index) =>
                      ProductCard(product: selectedCategoryProducts[index]),
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
