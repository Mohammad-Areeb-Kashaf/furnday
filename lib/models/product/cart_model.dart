class CartModel {
  String? id;
  int? qty;
  String? mrp;
  String? discountedPrice;

  CartModel({
    this.id,
    this.qty,
    this.mrp,
    this.discountedPrice,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    mrp = json['mrp'];
    discountedPrice = json['discountedPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['qty'] = qty;
    data['mrp'] = mrp;
    data['discountedPrice'] = discountedPrice;
    return data;
  }
}
