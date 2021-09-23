import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:omanphones/constants.dart';
import 'package:omanphones/models/banner_list.dart';
import 'package:omanphones/models/product_list.dart';
import 'package:provider/provider.dart';

class HomeScreenRepo {
  Future<void> fetchCaroselBanner(BuildContext context) async {
    Uri uri = Uri.http(Constants.authority, Constants.bannerString);
    try {
      await http.get(uri).then((value) {
        BannerModel bannerModel = BannerModel.fromJson(json.decode(value.body));
        Provider.of<BannerList>(context, listen: false)
            .updateSlider(bannerModel.data!.slider!, bannerModel.data!.noimg!);
      });
    } on SocketException catch (e) {
      rethrow;
    }
  }

  Future<void> fetchProducts(BuildContext context) async {
    Uri uri = Uri.http(Constants.authority, Constants.homeScreenProduct);
    try {
      await http.get(uri).then((value) {
        if (value.statusCode == 200) {
          List<dynamic> mapItems = json.decode(value.body);
          List<Product> productList = [];
          for (dynamic item in mapItems) {
            productList.add(Product.fromJson(item));
          }
          Provider.of<ProductList>(context, listen: false)
              .updateProductList(productList);
        }
      });
    } on SocketException catch (e) {
      rethrow;
    }
  }
}
