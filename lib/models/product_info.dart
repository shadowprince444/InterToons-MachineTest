import 'package:flutter/cupertino.dart';

class ProductInfo with ChangeNotifier {
  String? name;
  String? id;
  String? sku;
  int? evoucher;
  int? ecard;
  String? description;
  String? shortDescription;
  String? brand;
  List<dynamic>? image;
  int? hasOptions;
  String? productTag;
  String? preorder;
  Preorderinfo? preorderinfo;
  double? price;
  String? rating;
  double? specialPrice;
  int? status;
  Attrs? attrs;

  ProductInfo(
      {this.name,
      this.id,
      this.sku,
      this.evoucher,
      this.ecard,
      this.rating,
      this.specialPrice,
      this.description,
      this.shortDescription,
      this.brand,
      this.image,
      this.hasOptions,
      this.productTag,
      this.preorder,
      this.preorderinfo,
      this.price,
      this.status,
      this.attrs});

  fromJson(Map<String?, dynamic> json) {
    name = json['name'];
    id = json['id'];
    sku = json['sku'];
    evoucher = json['evoucher'];
    ecard = json['ecard'];
    description = json['description'];
    shortDescription = json['short_description'];
    brand = json['brand'];
    image = json['image'];
    hasOptions = json['has_options'];
    productTag = json['product_tag'];
    preorder = json['preorder'].toString();
    preorderinfo = json['preorderinfo'] != null
        ? Preorderinfo.fromJson(json['preorderinfo'])
        : null;
    specialPrice =
        json['special_price'] == null ? null : json['special_price'].toDouble();
    rating = json['rating'];
    price = json['price'] == null ? 0.0 : json['price'].toDouble();
    status = json['status'];
    attrs = json['attrs'] != null ? Attrs.fromJson(json['attrs']) : null;
    notifyListeners();
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = {};
    data['name'] = name;
    data['id'] = id;
    data['sku'] = sku;
    data['evoucher'] = evoucher;
    data['ecard'] = ecard;
    data['description'] = description;
    data['short_description'] = shortDescription;
    data['brand'] = brand;
    data['image'] = image;
    data['has_options'] = hasOptions;
    data['product_tag'] = productTag;
    data['preorder'] = preorder;
    if (preorderinfo != null) {
      data['preorderinfo'] = preorderinfo!.toJson();
    }
    data['price'] = price;
    data['status'] = status;
    if (attrs != null) {
      data['attrs'] = attrs!.toJson();
    }
    return data;
  }
}

class Preorderinfo {
  String? preorderType;
  String? preorderPercentage;
  String? preorderMsg;
  String? freePreorderNote;
  String? preOrderQty;
  String? isPreorderProduct;
  String? availabilityOn;

  Preorderinfo(
      {preorderType,
      preorderPercentage,
      preorderMsg,
      freePreorderNote,
      preOrderQty,
      isPreorderProduct,
      availabilityOn});

  Preorderinfo.fromJson(Map<String?, dynamic> json) {
    preorderType = json['preorderType'];
    preorderPercentage = json['preorderPercentage'];
    preorderMsg = json['preorderMsg'];
    freePreorderNote = json['freePreorderNote'];
    preOrderQty = json['preOrderQty'];
    isPreorderProduct = json['isPreorderProduct'];
    availabilityOn = json['availabilityOn'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = {};
    data['preorderType'] = preorderType;
    data['preorderPercentage'] = preorderPercentage;
    data['preorderMsg'] = preorderMsg;
    data['freePreorderNote'] = freePreorderNote;
    data['preOrderQty'] = preOrderQty;
    data['isPreorderProduct'] = isPreorderProduct;
    data['availabilityOn'] = availabilityOn;
    return data;
  }
}

class Attrs {
  String? color;
  List<Specs>? specs;

  Attrs({color, specs});

  Attrs.fromJson(Map<String?, dynamic> json) {
    color = json['color'];
    if (json['specs'] != null) {
      specs = [];
      json['specs'].forEach((v) {
        specs!.add(Specs.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = {};
    data['color'] = color;
    if (specs != null) {
      data['specs'] = specs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Specs {
  String? value;
  String? icon;
  String? title;

  Specs({value, icon, title});

  Specs.fromJson(Map<String?, dynamic> json) {
    value = json['value'];
    icon = json['icon'];
    title = json['title'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = {};
    data['value'] = value;
    data['icon'] = icon;
    data['title'] = title;
    return data;
  }
}
