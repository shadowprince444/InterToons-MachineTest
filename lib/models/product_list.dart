import 'package:flutter/widgets.dart';

class ProductList with ChangeNotifier {
  List<Product>? listOfProduct;
  updateProductList(List<Product> list) {
    listOfProduct = list;
    notifyListeners();
  }

  List<ProductItems> getSuggestions(String query) =>
      List.of(listOfProduct!.iterator.current.homepageProductData!.productItems)
          .where((user) {
        final userLower = user.name!.toLowerCase();
        final queryLower = query.toLowerCase();

        return userLower.contains(queryLower);
      }).toList();
}

class Product {
  String? type;
  HomepageProductData? homepageProductData;
  String? subtype;
  SecondaryBannerModel? secondaryBannerModel;

  Product(
      {this.type,
      this.secondaryBannerModel,
      this.homepageProductData,
      this.subtype});

  Product.fromJson(Map<String?, dynamic> json) {
    type = json['type'];
    if (type == "banner") {
      secondaryBannerModel = json['data'] != null
          ? SecondaryBannerModel.fromJson(json['data'])
          : null;
    } else {
      homepageProductData = json['data'] != null
          ? HomepageProductData.fromJson(json['data'])
          : null;
    }
    subtype = json['subtype'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = {};
    data['type'] = type;
    if (homepageProductData != null) {
      data['data'] = homepageProductData!.toJson();
    }
    data['subtype'] = subtype;
    return data;
  }
}

class HomepageProductData {
  String? id;
  String? title;
  List<ProductItems> productItems = [];

  HomepageProductData({this.id, this.title, required this.productItems});

  HomepageProductData.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['items'] != null) {
      productItems = [];
      json['items'].forEach((v) {
        productItems.add(ProductItems.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;

    data['items'] = productItems.map((v) => v.toJson()).toList();

    return data;
  }
}

class ProductItems {
  String? name;
  String? id;
  String? sku;
  String? image;
  double? price;
  String? storage;
  String? productTag;
  String? preorder;
  int? specialPrice;
  String? rating;

  ProductItems(
      {this.name,
      this.id,
      this.sku,
      this.image,
      this.price,
      this.storage,
      this.productTag,
      this.preorder,
      this.specialPrice,
      this.rating});

  ProductItems.fromJson(Map<String?, dynamic> json) {
    name = json['name'];
    id = json['id'];
    sku = json['sku'];
    image = json['image'];
    price = json['price'].toDouble();
    storage = json['storage'].toString();
    productTag = json['product_tag'];
    preorder = json['preorder'];
    specialPrice = json['special_price'];
    rating = json['rating'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = {};
    data['name'] = name;
    data['id'] = id;
    data['sku'] = sku;
    data['image'] = image;
    data['price'] = price;
    data['storage'] = storage;
    data['product_tag'] = productTag;
    data['preorder'] = preorder;
    data['special_price'] = specialPrice;
    data['rating'] = rating;
    return data;
  }
}

class SecondaryBannerModel {
  String? type;
  String? id;
  String? file;

  SecondaryBannerModel({this.type, this.id, this.file});

  SecondaryBannerModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    file = json["file"];

    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data["id"] = id!;
    return data;
  }
}

class SecondaryData {
  String? id;
  String? type;
  String? file;

  SecondaryData({this.id, this.type, this.file});

  SecondaryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type'] = type;
    data['file'] = file;
    return data;
  }
}
