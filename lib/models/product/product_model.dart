class ProductModel {
  List<String>? category;
  List<Description>? description;
  String? discountedPrice;
  bool? featured;
  String? id;
  List<String>? imagesIds;
  String? mrp;
  String? name;
  List<String>? product3dImagesIds;
  bool? product3dView;
  List<ProductReviews>? productReviews;
  double? rating;

  ProductModel(
      {this.category,
      this.description,
      this.discountedPrice,
      this.featured,
      this.id,
      this.imagesIds,
      this.mrp,
      this.name,
      this.product3dImagesIds,
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
    imagesIds = json['images_ids'].cast<String>();
    mrp = json['mrp'];
    name = json['name'];
    product3dImagesIds = json['product_3d_images_ids'].cast<String>();
    product3dView = json['product_3d_view'];
    if (json['product_reviews'] != null) {
      productReviews = <ProductReviews>[];
      json['product_reviews'].forEach((v) {
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
    data['images_ids'] = imagesIds;
    data['mrp'] = mrp;
    data['name'] = name;
    data['product_3d_images_ids'] = product3dImagesIds;
    data['product_3d_view'] = product3dView;
    if (productReviews != null) {
      data['product_reviews'] = productReviews!.map((v) => v.toJson()).toList();
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
