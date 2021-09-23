import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

//import 'package:path_provider/path_provider.dart';
class CartItem {
  String? productId, productName, imagePath;
  double? price, specialPrice;
  int? quantity;
  CartItem(
      {this.imagePath,
      this.price,
      this.productId,
      this.productName,
      this.quantity,
      this.specialPrice});
  Map<String?, dynamic> toJson() {
    Map<String?, dynamic> data = {};
    data['name'] = productName;
    data['id'] = productId;
    data['image'] = imagePath;
    data['price'] = price;
    data['specialPrice'] = specialPrice;
    data['quantity'] = quantity;
    return data;
  }

  CartItem.fromJson(Map<String, dynamic> map) {
    imagePath = map["image"];
    productName = map["name"];
    productId = map["id"];
    price = map["price"];
    specialPrice = map["specialPrice"];
    quantity = map["quantity"];
  }
}

class LocalCart with ChangeNotifier {
  List<CartItem> cartItemList = [];
  String storagePath = "";
  // Future<String> getPath() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String appDocPath = appDocDir.path;
  //   return appDocPath;
  // }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> cartlist = {};
    cartlist["cartItemList"] = cartItemList.map((v) => v.toJson()).toList();

    return cartlist;
  }

  fromJson(Map<String, dynamic> json) {
    if (json['cartItemList'] != null) {
      cartItemList = [];
      json['cartItemList'].forEach((v) {
        cartItemList.add(CartItem.fromJson(v));
      });
    }
  }

  removeProduct(CartItem cartItem) async {
    cartItemList.remove(cartItem);
    await update();
    print(cartItemList);
    notifyListeners();
  }

  updateQuantity(int index, int quantity) async {
    cartItemList[index].quantity = quantity;
    await update();
    print(cartItemList);
    notifyListeners();
  }

  int checkForExistingItem(CartItem item) {
    List<CartItem?> check = cartItemList
        .where((cartItem) => cartItem.productId == item.productId)
        .toList();
    print(check);
    if (check.isNotEmpty) {
      return cartItemList.indexOf(cartItemList
          .where((cartItem) => cartItem.productId == item.productId)
          .first);
    } else {
      return -1;
    }
  }

  addProduct(CartItem cartItem) async {
    int index = checkForExistingItem(cartItem);
    if (index != -1) {
      cartItemList[index].quantity = cartItemList[index].quantity! + 1;
    } else {
      cartItemList.add(cartItem);
    }

    await update();
    // print(cartItemList[index].quantity);
    notifyListeners();
  }

  update() async {
    Map<String?, dynamic> cartItemsMap = toJson();
    String converted = jsonEncode(cartItemsMap);
    await LocalStorage("my_cart.json").setItem("my_cart", converted);
  }

  retrieve() async {
    String convert = await LocalStorage("my_cart.json").getItem("my_cart");
    print(convert);
    fromJson(json.decode(convert));
    notifyListeners();
  }
}
