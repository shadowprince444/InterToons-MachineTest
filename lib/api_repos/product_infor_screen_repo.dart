import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:omanphones/constants.dart';
import 'package:http/http.dart' as http;
import 'package:omanphones/models/product_info.dart';
import 'package:omanphones/models/similar_products.dart';
import 'package:provider/provider.dart';

class ProductInfoScreenRepo {
  Future<void> fetchProductInfo(BuildContext context, String id) async {
    Uri uri = Uri.http(Constants.authority, Constants.productInfo, {"id": id});
    await http.get(uri).then((value) async {
      var res = value;
      if (res.statusCode == 200) {
        Map<String, dynamic> decodedResponse = json.decode(res.body);
        Provider.of<ProductInfo>(context, listen: false)
            .fromJson(decodedResponse);
        await fetchSimilarProduct(context, id);
      }
    });
  }

  Future<void> fetchSimilarProduct(BuildContext context, String id) async {
    Uri uri =
        Uri.http(Constants.authority, Constants.similarProduct, {"id": id});
    await http.get(uri).then((value) {
      var res = value;
      if (res.statusCode == 200) {
        Map<String, dynamic> decodedResponse = json.decode(res.body);
        Provider.of<SimilarProducts>(context, listen: false)
            .fromJson(decodedResponse);
      }
    });
  }
}
