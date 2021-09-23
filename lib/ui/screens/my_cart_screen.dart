import 'package:flutter/material.dart';
import 'package:omanphones/models/banner_list.dart';
import 'package:omanphones/models/local_cart.dart';
import 'package:omanphones/ui/widgets/image_loader.dart';
import 'package:provider/provider.dart';
import '../../screen_config.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  void initState() {
    Provider.of<LocalCart>(context, listen: false).retrieve();
    // TODO: implement initState
    super.initState();
  }

  double? gridHeight, gridWidth, totalRate = 0.0;
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
                      child:
                          Consumer<LocalCart>(builder: (context, localCart, _) {
                        if (localCart.cartItemList.isEmpty) {
                          return Text(
                            "My Cart",
                            style: ScreenConfig.label,
                          );
                        } else {
                          return Text(
                            "My Cart (${localCart.cartItemList.length})",
                            style: ScreenConfig.label,
                          );
                        }
                      }),
                    ),
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    width: gridWidth! * 10,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey.withOpacity(.2),
                child: Consumer<LocalCart>(builder: (context, localCart, _) {
                  if (localCart.cartItemList.isNotEmpty) {
                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: localCart.cartItemList.length,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      totalRate = 0.0;
                                    }

                                    CartItem cartItem =
                                        localCart.cartItemList[index];
                                    print(cartItem.specialPrice);
                                    if (cartItem.specialPrice != null) {
                                      totalRate = totalRate! +
                                          (cartItem.specialPrice! *
                                              cartItem.quantity!);
                                    } else {
                                      totalRate = totalRate! +
                                          (cartItem.price! *
                                              cartItem.quantity!);
                                    }
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    Colors.grey.withOpacity(.5),
                                                spreadRadius: gridHeight! * .3,
                                                blurRadius: gridHeight! * .2)
                                          ]),
                                      height: gridHeight! * 25,
                                      width: gridWidth! * 100,
                                      padding: EdgeInsets.only(
                                          top: gridHeight! * 2,
                                          bottom: gridHeight!,
                                          right: gridWidth! * 3,
                                          left: gridWidth! * 3),
                                      margin: EdgeInsets.symmetric(
                                          vertical: gridHeight! * 1,
                                          horizontal: gridWidth! * 2),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                cartItem.productName!,
                                                style: ScreenConfig.greyH3,
                                              )),
                                              SizedBox(
                                                height: gridHeight! * 5,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: gridWidth!),
                                                      child: Text(
                                                        cartItem.specialPrice ==
                                                                null
                                                            ? "OMR " +
                                                                cartItem.price
                                                                    .toString()
                                                            : "OMR " +
                                                                cartItem
                                                                    .specialPrice
                                                                    .toString(),
                                                        style: ScreenConfig
                                                            .redBold,
                                                      ),
                                                    )),
                                                    IconButton(
                                                        onPressed: () {
                                                          removeCartItem(
                                                              context,
                                                              cartItem);
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          size: gridHeight! * 4,
                                                          color: Colors.grey,
                                                        )),
                                                    SizedBox(
                                                      width: gridWidth! * 3,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                          SizedBox(
                                            width: gridWidth! * 30,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: NetworkImageLoader(
                                                      boxFit: BoxFit.contain,
                                                      path: cartItem.imagePath!,
                                                      defaultImage: Provider.of<
                                                                  BannerList>(
                                                              context,
                                                              listen: false)
                                                          .defaultImage),
                                                ),
                                                SizedBox(
                                                  height: gridHeight! * 2,
                                                ),
                                                SizedBox(
                                                  height: gridHeight! * 5,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            totalRate = totalRate! -
                                                                (cartItem
                                                                        .specialPrice ??
                                                                    cartItem
                                                                        .price!);
                                                          });
                                                          addQuantity(
                                                              context,
                                                              index,
                                                              cartItem.quantity! -
                                                                  1);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      .2),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Colors.black,
                                                            size:
                                                                gridHeight! * 3,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: gridWidth! * 10,
                                                        child: Center(
                                                          child: Text(cartItem
                                                              .quantity
                                                              .toString()),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          addQuantity(
                                                              context,
                                                              index,
                                                              cartItem.quantity! +
                                                                  1);
                                                          setState(() {
                                                            totalRate = totalRate! +
                                                                (cartItem
                                                                        .specialPrice ??
                                                                    cartItem
                                                                        .price!);
                                                          });
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      .2),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.black,
                                                            size:
                                                                gridHeight! * 3,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: gridHeight! * 9,
                          width: gridWidth! * 100,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: gridWidth! * 50,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: gridWidth! * 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "TOTAL",
                                        style: ScreenConfig.blackH3,
                                      ),
                                      Text(
                                        "OMR " + totalRate.toString(),
                                        style: ScreenConfig.redBold,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.only(left: gridWidth! * 3),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "CHECKOUT",
                                    style: ScreenConfig.label,
                                  ),
                                  style: TextButton.styleFrom(
                                      backgroundColor: ScreenConfig.appBar),
                                ),
                              ))
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(
                        child: Text(
                      "No Cart Items",
                      style: ScreenConfig.blackH2Bold,
                    ));
                  }
                }),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  removeCartItem(BuildContext context, CartItem cartItem) async {
    await Provider.of<LocalCart>(context, listen: false)
        .removeProduct(cartItem);
  }

  addQuantity(BuildContext context, int index, int quantity) {
    Provider.of<LocalCart>(context, listen: false)
        .updateQuantity(index, quantity);
  }
}
