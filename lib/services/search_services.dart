import 'package:furnday/constants.dart';
import 'package:furnday/controllers/products_controller.dart';
import 'package:furnday/helpers/grid_determiners.dart';

class SearchServices extends SearchDelegate {
  final products = Get.find<ProductsController>().allProductsList.value;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    try {
      List<ProductModel> matchQuery = [];
      for (var product in products) {
        if (product.name
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          matchQuery.add(product);
        }
      }
      var gridCrossAxisCount = gridCrossAxisCountDeterminer(context);
      var gridChildAspectRatio =
          gridChildAspectRatioDeterminer(context, gridCrossAxisCount);
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
        itemCount: matchQuery.length,
        itemBuilder: (context, index) =>
            ProductCard(product: matchQuery[index]),
      );
    } catch (e) {
      return const Text('There is something wrong, Please try again later');
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    try {
      List<ProductModel> matchQuery = [];
      for (var product in products) {
        if (product.name
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          matchQuery.add(product);
        }
      }
      return ListView.builder(
        physics: kScrollPhysics,
        shrinkWrap: true,
        itemCount: matchQuery.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            matchQuery[index].name.toString(),
          ),
          onTap: () {
            query = matchQuery[index].name.toString();
            showResults(context);
          },
        ),
      );
    } catch (e) {
      return const Text('There is something wrong, Please try again later');
    }
  }
}
