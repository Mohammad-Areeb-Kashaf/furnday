class CartModel {
  CartModel(
      {this.id = "0",
      this.qty = 1,
      this.mrp = "0",
      this.discountedPrice = "0",
      this.customisations});

  String? id;
  int? qty;
  String? mrp;
  String? discountedPrice;
  List<String>? customisations;

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    mrp = json['mrp'];
    discountedPrice = json['discountedPrice'];

    customisations = json['customisations'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['qty'] = qty;
    data['mrp'] = mrp;
    data['discountedPrice'] = discountedPrice;
    data['customisations'] = customisations;

    return data;
  }
}
