import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnday/constants.dart';
import 'package:furnday/models/product/product_model.dart';
import 'package:furnday/widgets/product/product_card.dart';

class ProductServices {
  final _firestore = FirebaseFirestore.instance;

  Widget getAllProducts(BuildContext context,
      {gridCrossAxisCount, gridChildAspectRatio}) {
    final productsStream = _firestore.collection('all_products').snapshots();

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
  }

  Widget getFeaturedProducts(BuildContext context,
      {gridCrossAxisCount, gridChildAspectRatio}) {
    final featuredProductsStream = _firestore
        .collection('all_products')
        .where("featured", isEqualTo: true)
        .snapshots();

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
  }
}
