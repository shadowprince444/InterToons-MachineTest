import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:omanphones/api_repos/home_screen_repo.dart';
import 'package:omanphones/models/product_list.dart';
import 'package:omanphones/ui/widgets/carousel_slider.dart';
import 'package:omanphones/ui/widgets/home_screen_scrollview.dart';
import 'package:provider/provider.dart';

import '../../screen_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SuggestionsBoxController suggestionsBoxController =
      SuggestionsBoxController();
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
                            debounceDuration: const Duration(microseconds: 50),
                            hideOnEmpty: true,
                            suggestionsBoxDecoration:
                                const SuggestionsBoxDecoration(
                              hasScrollbar: true,
                            ),
                            textFieldConfiguration: TextFieldConfiguration(
                              decoration: InputDecoration(
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
                            suggestionsBoxController: suggestionsBoxController,
                            hideSuggestionsOnKeyboardHide: false,
                            itemBuilder: (context, ProductItems productItems) {
                              return ListTile(
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
                child: Container(
                  color: Colors.grey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            constraints:
                                BoxConstraints(minHeight: gridHeight! * 25),
                            color: Colors.white,
                            width: gridWidth! * 100,
                            child: const CustomCarosel()),
                        const HomeScreenScrollView(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
