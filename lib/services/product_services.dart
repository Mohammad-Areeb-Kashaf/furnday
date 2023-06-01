import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/models/product/product_model.dart';
import 'package:furnday/widgets/my_appbar.dart';
import 'package:furnday/widgets/product/product_card.dart';
import 'package:furnday/widgets/product/product_grid_type.dart';
import 'package:furnday/widgets/product/product_section.dart';

class ProductServices {
  final _firestore = FirebaseFirestore.instance;
  var selectedCategory = '';

  Widget getAllProducts(BuildContext context,
      {gridCrossAxisCount, gridChildAspectRatio}) {
    final productsStream = _firestore.collection('all_products').snapshots();

    try {
      return StreamBuilder(
        stream: productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          } else if (snapshot.hasData) {
            return GridView.count(
                crossAxisCount: gridCrossAxisCount,
                childAspectRatio: gridChildAspectRatio,
                physics: kScrollPhysics,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  var product = ProductModel.fromJson(data);
                  return ProductCard(product: product);
                }).toList());
          } else {
            return const Text("Something went wrong");
          }
        },
      );
    } catch (e) {
      return const Text('Something went wrong');
    }
  }

  Widget getFeaturedProducts(BuildContext context,
      {required gridCrossAxisCount, required gridChildAspectRatio}) {
    final featuredProductsStream = _firestore
        .collection('all_products')
        .where("featured", isEqualTo: true)
        .snapshots();

    try {
      return StreamBuilder(
        stream: featuredProductsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          } else if (snapshot.hasData) {
            return GridView.count(
                crossAxisCount: gridCrossAxisCount,
                childAspectRatio: gridChildAspectRatio,
                physics: kScrollPhysics,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  var product = ProductModel.fromJson(data);
                  return ProductCard(product: product);
                }).toList());
          } else {
            return const Text("Something went wrong");
          }
        },
      );
    } catch (e) {
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
      return const Text('Something went wrong');
    }
  }
}
