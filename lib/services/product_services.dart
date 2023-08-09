import 'package:furnday/constants.dart';
import 'package:furnday/controllers/products_controller.dart';

class ProductServices {
  final _firestore = FirebaseFirestore.instance;
  var selectedCategory = '';

  Widget getAllProducts(BuildContext context,
      {gridCrossAxisCount, gridChildAspectRatio}) {
    try {
      return GetX<ProductsController>(
        builder: (controller) {
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
            itemCount: controller.products.length,
            itemBuilder: (context, index) =>
                ProductCard(product: controller.products[index]),
          );
        },
      );
    } catch (e) {
      var errorData = {
        "errors": [e.toString()]
      };
      _firestore.collection("app").doc('errors').update(errorData);
      return const Text('Something went wrong');
    }
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
            itemCount: controller.featuredProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(product: controller.featuredProducts[index]);
            },
          );
        },
      );
    } catch (e) {
      var errorData = {
        "errors": [e.toString()]
      };
      _firestore.collection("app").doc('errors').update(errorData);
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
            return const Text("Loading");
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
                                    productGridType: ProductGridType
                                        .selectedCategoryProducts,
                                    productServicesInstance: this,
                                  )
                                ],
                              )),
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
      var errorData = {
        "errors": [e.toString()]
      };
      _firestore.collection("app").doc('errors').update(errorData);
      return const Text('Something went wrong');
    }
  }

  Widget getSelectedCategoryProducts(gridChildAspectRatio, gridCrossAxisCount) {
    var selectedCategoryStream = _firestore
        .collection('all_products')
        .where('category', arrayContains: selectedCategory)
        .snapshots();

    try {
      return StreamBuilder(
        stream: selectedCategoryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          } else if (snapshot.hasData) {
            return snapshot.data!.docs.isNotEmpty
                ? GridView.count(
                    crossAxisCount: gridCrossAxisCount,
                    childAspectRatio: gridChildAspectRatio,
                    physics: kScrollPhysics,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      var product = ProductModel.fromJson(data);
                      return ProductCard(product: product);
                    }).toList())
                : const Text('No products found');
          } else {
            return const Text("Something went wrong");
          }
        },
      );
    } catch (e) {
      var errorData = {
        "errors": [e.toString()]
      };
      _firestore.collection("app").doc('errors').update(errorData);
      return const Text('Something went wrong');
    }
  }

  Widget getRefurbishedProducts(gridChildAspectRatio, gridCrossAxisCount) {
    var refurbishedProductsStream = _firestore
        .collection('all_products')
        .where('category', arrayContains: 'Refurbished')
        .snapshots();

    try {
      return StreamBuilder(
        stream: refurbishedProductsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          } else if (snapshot.hasData) {
            return snapshot.data!.docs.isNotEmpty
                ? GridView.count(
                    crossAxisCount: gridCrossAxisCount,
                    childAspectRatio: gridChildAspectRatio,
                    physics: kScrollPhysics,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      var product = ProductModel.fromJson(data);
                      return ProductCard(product: product);
                    }).toList())
                : const Text('No products found');
          } else {
            return const Text("Something went wrong");
          }
        },
      );
    } catch (e) {
      var errorData = {
        "errors": [e.toString()]
      };
      _firestore.collection("app").doc('errors').update(errorData);
      return const Text('Something went wrong');
    }
  }

  Widget getFurnitureProducts(gridChildAspectRatio, gridCrossAxisCount) {
    var furnitureProductsStream = _firestore
        .collection('all_products')
        .where('category', arrayContains: 'Furniture')
        .snapshots();

    try {
      return StreamBuilder(
        stream: furnitureProductsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          } else if (snapshot.hasData) {
            return snapshot.data!.docs.isNotEmpty
                ? GridView.count(
                    crossAxisCount: gridCrossAxisCount,
                    childAspectRatio: gridChildAspectRatio,
                    physics: kScrollPhysics,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      var product = ProductModel.fromJson(data);
                      return ProductCard(product: product);
                    }).toList())
                : const Text('No products found');
          } else {
            return const Text("Something went wrong");
          }
        },
      );
    } catch (e) {
      var errorData = {
        "errors": [e.toString()]
      };
      _firestore.collection("app").doc('errors').update(errorData);
      return const Text('Something went wrong');
    }
  }

  Widget getHardwareProducts(gridChildAspectRatio, gridCrossAxisCount) {
    var hardwareProductsStream = _firestore
        .collection('all_products')
        .where('category', arrayContains: 'Hardware')
        .snapshots();

    try {
      return StreamBuilder(
        stream: hardwareProductsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          } else if (snapshot.hasData) {
            return snapshot.data!.docs.isNotEmpty
                ? GridView.count(
                    crossAxisCount: gridCrossAxisCount,
                    childAspectRatio: gridChildAspectRatio,
                    physics: kScrollPhysics,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      var product = ProductModel.fromJson(data);
                      return ProductCard(product: product);
                    }).toList())
                : const Text('No products found');
          } else {
            return const Text("Something went wrong");
          }
        },
      );
    } catch (e) {
      var errorData = {
        "errors": [e.toString()]
      };
      _firestore.collection("app").doc('errors').update(errorData);
      return const Text('Something went wrong');
    }
  }
}
