import 'package:flutter/cupertino.dart';
import 'package:omanphones/models/product_list.dart';

class SimilarProducts with ChangeNotifier {
  String? currency;
  String? status;
  List<Items>? productItems = [];

  SimilarProducts({currency, status, productItems});

  fromJson(Map<String?, dynamic> json) {
    currency = json['currency'];
    status = json['status'];
    if (json['items'] != null) {
      productItems = [];
      json['items'].forEach((v) {
        productItems!.add(Items.fromJson(v));
      });
    }
    print(productItems);
    notifyListeners();
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['currency'] = currency;
    data['status'] = status;
    if (productItems != null) {
      data['items'] = productItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  String? id;
  String? sku;
  String? storage;
  String? productTag;
  String? preorder;
  String? image;
  int? isNew;
  int? price;
  int? specialPrice;

  Items(
      {this.name,
      this.id,
      this.sku,
      this.storage,
      this.productTag,
      this.preorder,
      this.image,
      this.specialPrice,
      this.isNew,
      this.price});

  Items.fromJson(Map<String?, dynamic> json) {
    name = json['name'];
    id = json['id'];
    sku = json['sku'];
    storage = json['storage'].toString();
    productTag = json['product_tag'];
    preorder = json['preorder'];
    specialPrice = json['special_price'];
    image = json['image'];
    isNew = json['is_new'];
    price = json['price'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['name'] = name;
    data['id'] = id;
    data['sku'] = sku;
    data['storage'] = storage;
    data['product_tag'] = productTag;
    data['preorder'] = preorder;
    data['image'] = image;
    data['is_new'] = isNew;

    data['price'] = price;
    return data;
  }
}
