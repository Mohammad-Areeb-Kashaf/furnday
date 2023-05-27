class ProductModel {
  List<String>? category;
  List<Description>? description;
  String? discountedPrice;
  bool? featured;
  String? id;
  List<String>? productImagesName;
  String? productImagesPath;
  String? mrp;
  String? name;
  List<String>? product3dImagesName;
  String? product3dImagesPath;
  bool? product3dView;
  List<ProductReviews>? productReviews;
  double? rating;

  ProductModel(
      {this.category,
      this.description,
      this.discountedPrice,
      this.featured,
      this.id,
      this.productImagesName,
      this.productImagesPath,
      this.mrp,
      this.name,
      this.product3dImagesName,
      this.product3dImagesPath,
      this.product3dView,
      this.productReviews,
      this.rating});

  ProductModel.fromJson(Map<String, dynamic> json) {
    category = json['category'].cast<String>();
    if (json['description'] != null) {
      description = [];
      json['description'].forEach((v) {
        description!.add(Description.fromJson(v));
      });
    }
    discountedPrice = json['discountedPrice'];
    featured = json['featured'];
    id = json['id'];
    productImagesName = json['productImagesName'].cast<String>();
    productImagesPath = json['productImagesPath'];
    mrp = json['mrp'];
    name = json['name'];
    product3dImagesName = json['product3dImagesName'].cast<String>();
    product3dImagesPath = json['product3dImagesPath'];
    product3dView = json['product3dView'];
    if (json['productReviews'] != null) {
      productReviews = <ProductReviews>[];
      json['productReviews'].forEach((v) {
        productReviews!.add(ProductReviews.fromJson(v));
      });
    }
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    if (description != null) {
      data['description'] = description!.map((v) => v.toJson()).toList();
    }
    data['discountedPrice'] = discountedPrice;
    data['featured'] = featured;
    data['id'] = id;
    data['productImagesName'] = productImagesName;
    data['productImagesPath'] = productImagesPath;
    data['mrp'] = mrp;
    data['name'] = name;
    data['product3dImagesName'] = product3dImagesName;
    data['product3dImagesPath'] = product3dImagesPath;
    data['product3dView'] = product3dView;
    if (productReviews != null) {
      data['productReviews'] = productReviews!.map((v) => v.toJson()).toList();
    }
    data['rating'] = rating;
    return data;
  }
}

class Description {
  String? title;
  String? desc;

  Description({this.title, this.desc});

  Description.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['desc'] = desc;
    return data;
  }
}

class ProductReviews {
  String? comment;
  String? date;
  String? email;
  double? rating;
  String? username;

  ProductReviews(
      {this.comment, this.date, this.email, this.rating, this.username});

  ProductReviews.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    date = json['date'];
    email = json['email'];
    rating = json['rating'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = comment;
    data['date'] = date;
    data['email'] = email;
    data['rating'] = rating;
    data['username'] = username;
    return data;
  }
}
