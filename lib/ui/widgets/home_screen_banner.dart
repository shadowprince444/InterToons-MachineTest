import 'package:flutter/material.dart';
import 'package:omanphones/models/banner_list.dart';
import 'package:provider/provider.dart';

import '../../screen_config.dart';
import 'image_loader.dart';

class HomeScreenBanner extends StatefulWidget {
  const HomeScreenBanner({Key? key, required this.file}) : super(key: key);
  final String file;
  @override
  _HomeScreenBannerState createState() => _HomeScreenBannerState();
}

class _HomeScreenBannerState extends State<HomeScreenBanner> {
  double? gridHeight, gridWidth;
  @override
  Widget build(BuildContext context) {
    ScreenConfig().read(context);
    gridHeight = ScreenConfig.gridHeight;
    gridWidth = ScreenConfig.gridWidth;
    return Container(
      // color: Colors.amber,
      width: gridWidth! * 100,
      padding: EdgeInsets.symmetric(
          vertical: gridHeight! * 2, horizontal: gridWidth! * 2),
      child: NetworkImageLoader(
        boxFit: BoxFit.fitWidth,
        defaultImage:
            Provider.of<BannerList>(context, listen: false).defaultImage,
        path: widget.file,
      ),
    );
  }
}
