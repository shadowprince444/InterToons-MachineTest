import 'dart:io';

import 'package:flutter/material.dart';
import 'package:omanphones/api_repos/product_infor_screen_repo.dart';
import 'package:omanphones/models/banner_list.dart';
import 'package:omanphones/models/product_info.dart';
import 'package:omanphones/models/product_list.dart';
import 'package:omanphones/ui/screens/product_info_screen.dart';
import 'package:omanphones/ui/widgets/image_loader.dart';
import 'package:omanphones/ui/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../screen_config.dart';

class ProductTile extends StatefulWidget {
  const ProductTile({Key? key, required this.productItem}) : super(key: key);
  final ProductItems productItem;
  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isLoading = false;
  double? gridHeight, gridWidth;
  @override
  Widget build(BuildContext context) {
    ScreenConfig().read(context);
    gridHeight = ScreenConfig.gridHeight;
    gridWidth = ScreenConfig.gridWidth;
    return InkWell(
      onTap: () {
        productInfo(context, widget.productItem.id!);
      },
      child: Container(
        padding: EdgeInsets.only(top: gridHeight! * .5),
        color: Colors.white,
        child: isLoading
            ? const Center(
                child: LoadingWidget(),
              )
            : Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: gridWidth! * 40,
                        height: gridHeight! * 21,
                      ),
                      SizedBox(
                        height: gridHeight! * 21,
                        child: NetworkImageLoader(
                          boxFit: BoxFit.fitHeight,
                          defaultImage:
                              Provider.of<BannerList>(context, listen: false)
                                  .defaultImage,
                          path: Constants.mediaPath + widget.productItem.image!,
                        ),
                      ),
                      Positioned(
                        left: gridWidth!,
                        bottom: gridHeight! * 2,
                        child: widget.productItem.rating == null ||
                                widget.productItem.rating == ""
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.yellow,
                                        width: gridWidth! * .1),
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(
                                        gridHeight! * .5)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: gridWidth!),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: gridHeight! * 2,
                                    ),
                                    Text(
                                      widget.productItem.rating!,
                                      style: ScreenConfig.whiteH6,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      Positioned(
                        right: gridWidth!,
                        bottom: gridHeight! * 2,
                        child: widget.productItem.storage == "false"
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ScreenConfig.appBar,
                                        width: gridWidth! * .1),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        gridHeight! * .5)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: gridWidth!),
                                child: Text(
                                  widget.productItem.storage!,
                                  style: ScreenConfig.errortxt,
                                ),
                              ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: gridWidth! * 2),
                    height: gridHeight! * 4,
                    child: Text(widget.productItem.name!),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: gridHeight! * .3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.productItem.specialPrice == null
                              ? "OMR ${widget.productItem.price.toString()}"
                              : "OMR ${widget.productItem.specialPrice.toString()}",
                          style: ScreenConfig.errortxt,
                        ),
                        widget.productItem.specialPrice == null
                            ? const SizedBox(
                                width: 0,
                              )
                            : Text(
                                "OMR ${widget.productItem.price.toString()}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                      ],
                    ),
                  ))
                ],
              ),
      ),
    );
  }

  productInfo(BuildContext context, String productId) async {
    setState(() {
      isLoading = true;
    });
    try {
      await ProductInfoScreenRepo()
          .fetchProductInfo(context, productId)
          .then((value) {
        setState(() {
          isLoading = false;
        });
        print(Provider.of<ProductInfo>(context, listen: false).name);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProductInfoScreen()));
      });
    } on SocketException catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
