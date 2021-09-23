import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:omanphones/api_repos/product_infor_screen_repo.dart';
import 'package:omanphones/models/banner_list.dart';
import 'package:omanphones/models/local_cart.dart';
import 'package:omanphones/models/product_info.dart';
import 'package:omanphones/models/similar_products.dart';
import 'package:omanphones/ui/screens/my_cart_screen.dart';
import 'package:omanphones/ui/widgets/image_loader.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../screen_config.dart';

class ProductInfoScreen extends StatefulWidget {
  const ProductInfoScreen({Key? key}) : super(key: key);

  @override
  _ProductInfoScreenState createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  bool isFav = false;
  double? gridHeight, gridWidth;
  @override
  Widget build(BuildContext context) {
    ScreenConfig().read(context);
    gridHeight = ScreenConfig.gridHeight;
    gridWidth = ScreenConfig.gridWidth;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: gridHeight! * 100,
          width: gridWidth! * 100,
          child: Column(children: [
            Container(
              color: ScreenConfig.appBar,
              height: gridHeight! * 8,
              width: gridWidth! * 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: gridHeight! * 4,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    width: gridWidth! * 50,
                    child: Center(
                      child: Text(
                        "Item Details",
                        style: ScreenConfig.label,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: gridHeight! * 4,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyCartScreen()));
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: gridHeight! * 4,
                      ))
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.grey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      child: Consumer<ProductInfo>(
                          builder: (context, productInfo, _) {
                        if (productInfo.id == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        List<String> imageList = [];
                        for (dynamic item in productInfo.image!) {
                          imageList.add(item);
                        }
                        return Column(
                          children: [
                            Container(
                              color: Colors.white,
                              width: gridWidth! * 100,
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: gridHeight!),
                                child: Stack(
                                  children: [
                                    CarouselSlider.builder(
                                        itemCount: imageList.length,
                                        options: CarouselOptions(),
                                        itemBuilder: (context, index,
                                                integer) =>
                                            Image.network(
                                              imageList[index],
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return const Text('😢');
                                              },
                                            )),
                                    Positioned(
                                        right: gridWidth! * 3,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.favorite,
                                            color: isFav
                                                ? ScreenConfig.appBar
                                                : Colors.grey,
                                            size: gridHeight! * 4,
                                          ),
                                          onPressed: () {
                                            addToFav();
                                          },
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: gridHeight!,
                                  horizontal: gridWidth! * 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      constraints: BoxConstraints(
                                        maxHeight: gridHeight! * 16,
                                      ),
                                      child: Text(
                                        productInfo.name!,
                                        style: ScreenConfig.greyH3,
                                      )),
                                  SizedBox(
                                    height: gridHeight! * .2,
                                  ),
                                  Container(
                                    width: gridWidth! * 10,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.yellow,
                                            width: gridWidth! * .1),
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(
                                            gridHeight! * 5)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: gridHeight! * 2,
                                        ),
                                        Text(
                                          productInfo.rating ?? "0.0",
                                          style: ScreenConfig.whiteH6,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: gridHeight! * .2,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: gridHeight! * .3,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          productInfo.specialPrice == null
                                              ? "OMR ${productInfo.price.toString()}"
                                              : "OMR ${productInfo.specialPrice.toString()}",
                                          style: ScreenConfig.redBold,
                                        ),
                                        SizedBox(
                                          width: gridWidth! * 3,
                                        ),
                                        productInfo.specialPrice == null
                                            ? const SizedBox(
                                                width: 0,
                                              )
                                            : Text(
                                                "OMR ${productInfo.price.toString()}",
                                                style: TextStyle(
                                                  fontSize: gridHeight! * 2,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: gridHeight! * 2,
                                  horizontal: gridWidth! * 5),
                              child: Column(
                                children: [
                                  Container(
                                    height: gridHeight! * 5,
                                    color: Colors.grey.withOpacity(.4),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: gridWidth! * 20,
                                          child: Center(
                                            child: Text(
                                              "color",
                                              style: ScreenConfig.blackH6Bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: gridWidth! * 8,
                                          child: NetworkImageLoader(
                                            boxFit: BoxFit.contain,
                                            path: productInfo.attrs!.color!,
                                            defaultImage:
                                                Provider.of<BannerList>(context,
                                                        listen: false)
                                                    .defaultImage,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: gridHeight!),
                                    color: Colors.grey.withOpacity(.1),
                                    child: GridView.builder(
                                      itemCount:
                                          productInfo.attrs!.specs!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: gridHeight! * 2,
                                        mainAxisExtent: gridHeight! * 8,
                                      ),
                                      itemBuilder: (context, gridIndex) =>
                                          Column(
                                        children: [
                                          SizedBox(
                                            height: gridHeight!,
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: NetworkImageLoader(
                                                boxFit: BoxFit.contain,
                                                path: productInfo.attrs!
                                                    .specs![gridIndex].icon!,
                                                defaultImage:
                                                    Provider.of<BannerList>(
                                                            context,
                                                            listen: false)
                                                        .defaultImage,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: Center(
                                              child: Text(
                                                productInfo.attrs!
                                                    .specs![gridIndex].value!,
                                                style: ScreenConfig.greyH3,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: gridHeight! * .5,
                            ),
                            Container(
                              height: gridHeight! * 11,
                              width: gridWidth! * 100,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: gridHeight! * 2,
                                  horizontal: gridWidth! * 5),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "About product",
                                        style: ScreenConfig.blackH2Bold,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                      child: Center(
                                    child: Text(
                                      "View details...",
                                      style: ScreenConfig.redBold,
                                    ),
                                  ))
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                    ),
                    Consumer<SimilarProducts>(
                        builder: (context, similarProducts, _) {
                      if (similarProducts.productItems == null) {
                        return Container();
                      }
                      return Container(
                        width: gridWidth! * 100,
                        height: gridHeight! * 65,
                        margin: EdgeInsets.symmetric(
                            vertical: gridHeight!, horizontal: gridWidth!),
                        color: Colors.blueGrey,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              height: gridHeight! * 5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: gridWidth! * 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Similar Products",
                                      style: ScreenConfig.blackH2Bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: gridHeight! * .5),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text("View All"),
                                      style: TextButton.styleFrom(
                                          backgroundColor: ScreenConfig.appBar,
                                          primary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      gridHeight!))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: gridWidth! * 5,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      similarProducts.productItems!.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: gridWidth! * .25,
                                    mainAxisSpacing: gridHeight! * .1,
                                    crossAxisCount: 2,
                                    mainAxisExtent: 30 * gridHeight!,
                                  ),
                                  itemBuilder: (context, gridIndex) {
                                    return InkWell(
                                      onTap: () {
                                        productInfo(
                                            context,
                                            similarProducts
                                                .productItems![gridIndex].id!);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: gridHeight! * .5),
                                        color: Colors.white,
                                        child: Column(
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
                                                        Provider.of<BannerList>(
                                                                context,
                                                                listen: false)
                                                            .defaultImage,
                                                    path: Constants.mediaPath +
                                                        similarProducts
                                                            .productItems![
                                                                gridIndex]
                                                            .image!,
                                                  ),
                                                ),
                                                Positioned(
                                                  right: gridWidth!,
                                                  bottom: gridHeight! * 2,
                                                  child: similarProducts
                                                              .productItems![
                                                                  gridIndex]
                                                              .storage ==
                                                          "false"
                                                      ? Container()
                                                      : Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      ScreenConfig
                                                                          .appBar,
                                                                  width:
                                                                      gridWidth! *
                                                                          .1),
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          gridHeight! *
                                                                              .5)),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      gridWidth!),
                                                          child: Text(
                                                            similarProducts
                                                                .productItems![
                                                                    gridIndex]
                                                                .storage!,
                                                            style: ScreenConfig
                                                                .errortxt,
                                                          ),
                                                        ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: gridWidth! * 2),
                                              height: gridHeight! * 4,
                                              child: Text(similarProducts
                                                  .productItems![gridIndex]
                                                  .name!),
                                            ),
                                            Expanded(
                                                child: Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: gridHeight! * .3,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    similarProducts
                                                                .productItems![
                                                                    gridIndex]
                                                                .specialPrice ==
                                                            null
                                                        ? "OMR ${similarProducts.productItems![gridIndex].price.toString()}"
                                                        : "OMR ${similarProducts.productItems![gridIndex].specialPrice.toString()}",
                                                    style:
                                                        ScreenConfig.errortxt,
                                                  ),
                                                  similarProducts
                                                              .productItems![
                                                                  gridIndex]
                                                              .specialPrice ==
                                                          null
                                                      ? const SizedBox(
                                                          width: 0,
                                                        )
                                                      : Text(
                                                          "OMR ${similarProducts.productItems![gridIndex].price.toString()}",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            )),
            Container(
              width: gridWidth! * 100,
              height: gridHeight! * 8,
              color: ScreenConfig.appBar,
              child: TextButton.icon(
                onPressed: () {
                  addToCart(context);
                },
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                  size: gridHeight! * 4,
                ),
                label: Text(
                  "ADD TO CART",
                  style: ScreenConfig.whiteH6,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  productInfo(BuildContext context, String productId) async {
    await ProductInfoScreenRepo()
        .fetchProductInfo(context, productId)
        .then((value) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProductInfoScreen()));
    });
  }

  addToFav() {
    setState(() {
      isFav = !isFav;
    });
  }

  addToCart(BuildContext context) {
    ProductInfo productInfo = Provider.of(context, listen: false);
    CartItem cartItem = CartItem(
      imagePath: productInfo.image![0],
      price: productInfo.price,
      productId: productInfo.id,
      productName: productInfo.name,
      quantity: 1,
      specialPrice: productInfo.specialPrice,
    );
    Provider.of<LocalCart>(context, listen: false).addProduct(cartItem);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyCartScreen()));
  }
}
