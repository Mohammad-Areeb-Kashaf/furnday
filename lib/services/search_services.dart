import 'package:furnday/constants.dart';

class SearchServices extends SearchDelegate {
  final products = Get.find<ProductsController>().allProductsList;
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

      return DynamicHeightGridView(
        crossAxisCount: gridCrossAxisCount,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        physics: kScrollPhysics,
        shrinkWrap: true,
        itemCount: matchQuery.length,
        builder: (context, index) => ProductCard(product: matchQuery[index]),
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
