import 'package:flutter/material.dart';
import 'package:omanphones/models/banner_list.dart';
import 'package:omanphones/models/product_list.dart';
import 'package:omanphones/ui/widgets/home_screen_banner.dart';
import 'package:omanphones/ui/widgets/product_tile.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../screen_config.dart';
import 'image_loader.dart';

class HomeScreenScrollView extends StatefulWidget {
  const HomeScreenScrollView({Key? key}) : super(key: key);

  @override
  _HomeScreenScrollViewState createState() => _HomeScreenScrollViewState();
}

class _HomeScreenScrollViewState extends State<HomeScreenScrollView> {
  double? gridHeight, gridWidth;
  @override
  Widget build(BuildContext context) {
    ScreenConfig().read(context);
    gridHeight = ScreenConfig.gridHeight;
    gridWidth = ScreenConfig.gridWidth;
    return Consumer<ProductList>(builder: (context, productList, _) {
      if (productList.listOfProduct == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (productList.listOfProduct!.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          itemCount: productList.listOfProduct!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (productList.listOfProduct![index].type != "banner") {
              List<ProductItems> _list = productList
                  .listOfProduct![index].homepageProductData!.productItems;

              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: gridWidth! * 10,
                                ),
                                Expanded(
                                  child: Text(
                                    productList.listOfProduct![index]
                                        .homepageProductData!.title!,
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
                                            borderRadius: BorderRadius.circular(
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
                                itemCount: _list.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: gridWidth! * .25,
                                  mainAxisSpacing: gridHeight! * .1,
                                  crossAxisCount: 2,
                                  mainAxisExtent: 30 * gridHeight!,
                                ),
                                itemBuilder: (context, gridIndex) {
                                  return ProductTile(
                                      productItem: _list[gridIndex]);
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: gridHeight! * .4,
                      width: gridWidth! * 100,
                      color: Colors.grey,
                    )
                  ],
                ),
              );
            } else {
              return HomeScreenBanner(
                  file: productList
                      .listOfProduct![index].secondaryBannerModel!.file!);
            }
          });
    });
  }
}
