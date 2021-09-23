import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:omanphones/api_repos/home_screen_repo.dart';
import 'package:omanphones/models/banner_list.dart';
import 'package:omanphones/models/product_list.dart';
import 'package:omanphones/ui/widgets/carousel_slider.dart';
import 'package:omanphones/ui/widgets/home_screen_scrollview.dart';
import 'package:omanphones/ui/widgets/image_loader.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../screen_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SuggestionsBoxController suggestionsBoxController =
      SuggestionsBoxController();
  Timer? _timer;
  int navBarIndex = 0;
  @override
  void initState() {
    loadData(context);
    super.initState();
  }

  void loadData(BuildContext context) async {
    await HomeScreenRepo().fetchCaroselBanner(context);
    await HomeScreenRepo().fetchProducts(context);
  }

  @override
  void dispose() {
    _timer = null;
    super.dispose();
  }

  double? gridHeight, gridWidth;
  @override
  Widget build(BuildContext context) {
    ScreenConfig().read(context);
    gridHeight = ScreenConfig.gridHeight;
    gridWidth = ScreenConfig.gridWidth;
    ProductList productList = Provider.of<ProductList>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: navBarIndex,
            onTap: (int n) {
              setState(() {
                navBarIndex = n;
              });
            },
            iconSize: gridHeight! * 3,
            selectedItemColor: ScreenConfig.appBar,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(
                    Icons.home_sharp,
                  )),
              BottomNavigationBarItem(
                  label: "Search",
                  icon: Icon(
                    Icons.search,
                  )),
              BottomNavigationBarItem(
                  label: "Categories",
                  icon: Icon(
                    Icons.apps_outlined,
                  )),
              BottomNavigationBarItem(
                  label: "Cart",
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                  ))
            ]),
        //       appBar: AppBar(
        // // toolbarHeight: gridHeight! * 15,
        //         backgroundColor: ScreenConfig.appBar,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.menu,
        //     color: Colors.white,
        //     size: gridHeight! * 3,
        //   ),
        //   onPressed: () {},
        // ),
        // title: Container(
        //   width: gridWidth! * 40,
        //   color: Colors.white,
        // ),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.notifications,
        //         color: Colors.white,
        //         size: gridHeight! * 3,
        //       ))
        // ],
        //         bottom: PreferredSize(
        //           child: Container(
        //             //  padding: const EdgeInsets.all(8),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10),
        //               color: Colors.grey[300],
        //             ),
        //             child: Padding(
        //               padding: const EdgeInsets.all(5.0),
        //               child: Material(
        //                 color: Colors.grey[300],
        //                 child: Row(
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: <Widget>[
        //                     Icon(Icons.search, color: Colors.grey),
        //                     Expanded(
        //                       child: TextField(
        //                         // textAlign: TextAlign.center,
        //                         decoration: InputDecoration.collapsed(
        //                           hintText: ' Search by name or address',
        //                         ),
        //                         onChanged: (value) {},
        //                       ),
        //                     ),
        //                     InkWell(
        //                       child: Icon(
        //                         Icons.mic,
        //                         color: Colors.grey,
        //                       ),
        //                       onTap: () {},
        //                     )
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //           preferredSize: const Size.fromHeight(kToolbarHeight),
        //         ),
        //       ),
        body: Container(
          color: Colors.white,
          height: gridHeight! * 100,
          width: gridWidth! * 100,
          child: Column(
            children: [
              Container(
                color: ScreenConfig.appBar,
                height: gridHeight! * 15,
                width: gridWidth! * 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: gridHeight! * 6,
                      width: gridWidth! * 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: gridHeight! * 4,
                            ),
                            onPressed: () {},
                          ),
                          Container(
                            padding: EdgeInsets.only(top: gridHeight!),
                            width: gridWidth! * 50,
                            child: Image.asset(
                              "assets/logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: gridHeight! * 4,
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: gridHeight! * 1.5,
                            left: gridHeight! * 1.5,
                            right: gridHeight! * 1.5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: gridHeight! * .2,
                                spreadRadius: gridHeight! * .1,
                                // offset: Offset(
                                //     gridHeight!* .2, gridHeight!* .2)
                              )
                            ],
                            borderRadius:
                                BorderRadius.circular(gridHeight! * 1.5),
                            border: Border.all(
                                color: Colors.grey, width: gridHeight! * .1)),
                        child: SizedBox(
                          width: gridWidth! * 100,
                          height: gridHeight! * 7,
                          child: TypeAheadField<ProductItems>(
                            // transitionBuilder: (context, suggestionsBox,
                            //         animationController) =>
                            //     FadeTransition(
                            //   child: suggestionsBox,
                            //   opacity: CurvedAnimation(
                            //       parent: animationController,
                            //       curve: Curves.fastOutSlowIn),
                            // ),
                            debounceDuration: const Duration(microseconds: 50),
                            hideOnEmpty: true,
                            suggestionsBoxDecoration:
                                const SuggestionsBoxDecoration(
                              hasScrollbar: true,
                            ),
                            //hideSuggestionsOnKeyboardHide: true,
                            textFieldConfiguration: TextFieldConfiguration(
                              decoration: InputDecoration(
                                // contentPadding:
                                //     EdgeInsets.only(bottom: gridHeight!* .01),
                                hintStyle: ScreenConfig.greyH2,
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: gridHeight! * 3,
                                ),
                                border: InputBorder.none,
                                constraints: BoxConstraints(
                                    maxHeight: gridHeight! * 5,
                                    maxWidth: gridWidth! * 90),
                                hintText: 'Search Products',
                              ),
                            ),
                            suggestionsCallback: productList.getSuggestions,
                            //hideKeyboard: true,
                            suggestionsBoxController: suggestionsBoxController,
                            hideSuggestionsOnKeyboardHide: false,
                            itemBuilder: (context, ProductItems productItems) {
                              return ListTile(
                                // leading: Container(
                                //   width: gridWidth * 5,
                                //   height: gridHeight!* 5,
                                // ),
                                title: Text(
                                  productItems.name!,
                                  style: ScreenConfig.blackH3,
                                ),
                                subtitle: Text(
                                  productItems.price!.toString(),
                                ),
                                trailing: Container(
                                  child: Text(
                                    productItems.specialPrice.toString(),
                                    style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              );
                            },
                            noItemsFoundBuilder: (context) => Container(
                              height: 100,
                              child: const Center(
                                child: Text(
                                  'No Products',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            onSuggestionSelected:
                                (ProductItems productItems) {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: gridHeight!,
                    )
                  ],
                ),
              ),
              Expanded(
                child:
                    //   FutureBuilder<BannerModel>(
                    // future: SliderRepo().fetchBanner(),
                    // builder: (context, AsyncSnapshot<BannerModel> snapshot) {
                    //   if (snapshot.hasError) {
                    //     return const Center(child: Text("Please Re-load...."));
                    //   }
                    //   if (snapshot.connectionState == ConnectionState.waiting) {
                    //     return const Center(
                    //       child: CircularProgressIndicator(),
                    //     );
                    //   } else {
                    //     if (snapshot.hasData) {
                    //       return
                    Container(
                  color: Colors.grey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            constraints:
                                BoxConstraints(minHeight: gridHeight! * 25),
                            color: Colors.white,
                            // height: gridHeight! * 25,
                            width: gridWidth! * 100,
                            child: const CustomCarosel()),
                        const HomeScreenScrollView(),
                        // Consumer<ProductList>(
                        //     builder: (context, productList, _) {
                        //   if (productList.listOfProduct == null) {
                        //     return const Center(
                        //       child: CircularProgressIndicator(),
                        //     );
                        //   } else if (productList.listOfProduct!.isEmpty) {
                        //     return const Center(
                        //       child: CircularProgressIndicator(),
                        //     );
                        //   }
                        //   return ListView.builder(
                        //       itemCount: productList.listOfProduct!.length,
                        //       shrinkWrap: true,
                        //       physics: const NeverScrollableScrollPhysics(),
                        //       itemBuilder: (context, index) {
                        //         if (productList.listOfProduct![index].type !=
                        //             "banner") {
                        //           List<ProductItems> _list = productList
                        //               .listOfProduct![index]
                        //               .homepageProductData!
                        //               .productItems;

                        //           return Container(
                        //             child: Column(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: [
                        //                 Container(
                        //                   width: gridWidth! * 100,
                        //                   height: gridHeight! * 65,
                        //                   margin: EdgeInsets.symmetric(
                        //                       vertical: gridHeight!,
                        //                       horizontal: gridWidth!),
                        //                   color: Colors.blueGrey,
                        //                   child: Column(
                        //                     children: [
                        //                       Container(
                        //                         color: Colors.white,
                        //                         height: gridHeight! * 5,
                        //                         child: Row(
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment
                        //                                   .spaceEvenly,
                        //                           children: [
                        //                             SizedBox(
                        //                               width: gridWidth! * 10,
                        //                             ),
                        //                             Expanded(
                        //                               child: Text(
                        //                                 productList
                        //                                     .listOfProduct![
                        //                                         index]
                        //                                     .homepageProductData!
                        //                                     .title!,
                        //                                 style: ScreenConfig
                        //                                     .blackH2Bold,
                        //                               ),
                        //                             ),
                        //                             Padding(
                        //                               padding:
                        //                                   EdgeInsets.symmetric(
                        //                                       vertical:
                        //                                           gridHeight! *
                        //                                               .5),
                        //                               child: TextButton(
                        //                                 onPressed: () {},
                        //                                 child: const Text(
                        //                                     "View All"),
                        //                                 style: TextButton.styleFrom(
                        //                                     backgroundColor:
                        //                                         ScreenConfig
                        //                                             .appBar,
                        //                                     primary:
                        //                                         Colors.white,
                        //                                     shape: RoundedRectangleBorder(
                        //                                         borderRadius:
                        //                                             BorderRadius
                        //                                                 .circular(
                        //                                                     gridHeight!))),
                        //                               ),
                        //                             ),
                        //                             SizedBox(
                        //                               width: gridWidth! * 5,
                        //                             )
                        //                           ],
                        //                         ),
                        //                       ),
                        //                       Expanded(
                        //                         child: GridView.builder(
                        //                             physics:
                        //                                 const NeverScrollableScrollPhysics(),
                        //                             itemCount: _list.length,
                        //                             gridDelegate:
                        //                                 SliverGridDelegateWithFixedCrossAxisCount(
                        //                               crossAxisSpacing:
                        //                                   gridWidth! * .25,
                        //                               mainAxisSpacing:
                        //                                   gridHeight! * .1,
                        //                               crossAxisCount: 2,
                        //                               mainAxisExtent:
                        //                                   30 * gridHeight!,
                        //                             ),
                        //                             itemBuilder:
                        //                                 (context, gridIndex) {
                        //                               return Container(
                        //                                 padding: EdgeInsets.only(
                        //                                     top: gridHeight! *
                        //                                         .5),
                        //                                 color: Colors.white,
                        //                                 // margin: EdgeInsets.all(
                        //                                 //     gridHeight! * .03),
                        //                                 // color: Colors.red,
                        //                                 child: Column(
                        //                                   children: [
                        //                                     Stack(
                        //                                       alignment:
                        //                                           Alignment
                        //                                               .center,
                        //                                       children: [
                        //                                         SizedBox(
                        //                                           width:
                        //                                               gridWidth! *
                        //                                                   40,
                        //                                           height:
                        //                                               gridHeight! *
                        //                                                   21,
                        //                                         ),
                        //                                         SizedBox(
                        //                                           height:
                        //                                               gridHeight! *
                        //                                                   21,
                        //                                           child:
                        //                                               NetworkImageLoader(
                        //                                             boxFit: BoxFit
                        //                                                 .fitHeight,
                        //                                             defaultImage: Provider.of<BannerList>(
                        //                                                     context,
                        //                                                     listen:
                        //                                                         false)
                        //                                                 .defaultImage,
                        //                                             path: Constants
                        //                                                     .mediaPath +
                        //                                                 _list[gridIndex]
                        //                                                     .image!,
                        //                                           ),
                        //                                         ),
                        //                                         Positioned(
                        //                                           left:
                        //                                               gridWidth!,
                        //                                           bottom:
                        //                                               gridHeight! *
                        //                                                   2,
                        //                                           child: _list[gridIndex].rating ==
                        //                                                       null ||
                        //                                                   _list[gridIndex].rating ==
                        //                                                       ""
                        //                                               ? Container()
                        //                                               : Container(
                        //                                                   decoration: BoxDecoration(
                        //                                                       border: Border.all(color: Colors.yellow, width: gridWidth! * .1),
                        //                                                       color: Colors.amber,
                        //                                                       borderRadius: BorderRadius.circular(gridHeight! * .5)),
                        //                                                   padding:
                        //                                                       EdgeInsets.symmetric(horizontal: gridWidth!),
                        //                                                   child:
                        //                                                       Row(
                        //                                                     children: [
                        //                                                       Icon(
                        //                                                         Icons.star,
                        //                                                         color: Colors.white,
                        //                                                         size: gridHeight! * 2,
                        //                                                       ),
                        //                                                       Text(
                        //                                                         _list[gridIndex].rating!,
                        //                                                         style: ScreenConfig.whiteH6,
                        //                                                       ),
                        //                                                     ],
                        //                                                   ),
                        //                                                 ),
                        //                                         ),
                        //                                         Positioned(
                        //                                           right:
                        //                                               gridWidth!,
                        //                                           bottom:
                        //                                               gridHeight! *
                        //                                                   2,
                        //                                           child: _list[gridIndex]
                        //                                                       .storage ==
                        //                                                   "false"
                        //                                               ? Container()
                        //                                               : Container(
                        //                                                   decoration: BoxDecoration(
                        //                                                       border: Border.all(color: ScreenConfig.appBar, width: gridWidth! * .1),
                        //                                                       color: Colors.white,
                        //                                                       borderRadius: BorderRadius.circular(gridHeight! * .5)),
                        //                                                   padding:
                        //                                                       EdgeInsets.symmetric(horizontal: gridWidth!),
                        //                                                   child:
                        //                                                       Text(
                        //                                                     _list[gridIndex].storage!,
                        //                                                     style:
                        //                                                         ScreenConfig.errortxt,
                        //                                                   ),
                        //                                                 ),
                        //                                         )
                        //                                       ],
                        //                                     ),
                        //                                     Container(
                        //                                       padding: EdgeInsets
                        //                                           .symmetric(
                        //                                               horizontal:
                        //                                                   gridWidth! *
                        //                                                       2),
                        //                                       height:
                        //                                           gridHeight! *
                        //                                               4,
                        //                                       child: Text(_list[
                        //                                               gridIndex]
                        //                                           .name!),
                        //                                     ),
                        //                                     Expanded(
                        //                                         child:
                        //                                             Container(
                        //                                       padding: EdgeInsets
                        //                                           .symmetric(
                        //                                         vertical:
                        //                                             gridHeight! *
                        //                                                 .3,
                        //                                       ),
                        //                                       // color: Colors.amber,
                        //                                       child: Row(
                        //                                         mainAxisAlignment:
                        //                                             MainAxisAlignment
                        //                                                 .center,
                        //                                         children: [
                        //                                           Text(
                        //                                             _list[gridIndex].specialPrice ==
                        //                                                     null
                        //                                                 ? "OMR ${_list[gridIndex].price.toString()}"
                        //                                                 : "OMR ${_list[gridIndex].specialPrice.toString()}",
                        //                                             style: ScreenConfig
                        //                                                 .errortxt,
                        //                                           ),
                        //                                           _list[gridIndex]
                        //                                                       .specialPrice ==
                        //                                                   null
                        //                                               ? const SizedBox(
                        //                                                   width:
                        //                                                       0,
                        //                                                 )
                        //                                               : Text(
                        //                                                   "OMR ${_list[gridIndex].price.toString()}",
                        //                                                   style:
                        //                                                       const TextStyle(
                        //                                                     color:
                        //                                                         Colors.grey,
                        //                                                     decoration:
                        //                                                         TextDecoration.lineThrough,
                        //                                                   ),
                        //                                                 ),
                        //                                         ],
                        //                                       ),
                        //                                     ))
                        //                                   ],
                        //                                 ),
                        //                               );
                        //                             }),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 Container(
                        //                   height: gridHeight! * .4,
                        //                   width: gridWidth! * 100,
                        //                   color: Colors.grey,
                        //                 )
                        //               ],
                        //             ),
                        //           );
                        //         } else {
                        //           return Container(
                        //             // color: Colors.amber,
                        //             width: gridWidth! * 100,
                        //             padding: EdgeInsets.symmetric(
                        //                 vertical: gridHeight! * 2,
                        //                 horizontal: gridWidth! * 2),
                        //             child: NetworkImageLoader(
                        //               boxFit: BoxFit.fitWidth,
                        //               defaultImage: Provider.of<BannerList>(
                        //                       context,
                        //                       listen: false)
                        //                   .defaultImage,
                        //               path: productList.listOfProduct![index]
                        //                   .secondaryBannerModel!.file!,
                        //             ),
                        //           );
                        //         }
                        //       });
                        // }),
                      ],
                    ),
                  ),
                ),
                // } else {
                //   return const Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }
                //  }
                //  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
