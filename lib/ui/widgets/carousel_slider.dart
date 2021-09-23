import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:omanphones/models/banner_list.dart';
import 'package:provider/provider.dart';

class CustomCarosel extends StatelessWidget {
  const CustomCarosel({
    Key? key,
  }) : super(key: key);
  //CarouselController carouselController=CarouselController();

  @override
  Widget build(BuildContext context) {
    return Consumer<BannerList>(builder: (context, bannerList, _) {
      if (bannerList.bannerSlider != null) {
        //  print(bannerList.bannerSlider[0].image);
        if (bannerList.bannerSlider.isNotEmpty) {
          return CarouselSlider.builder(
              //carouselController: caroselController,
              itemCount: bannerList.bannerSlider.length,
              options: CarouselOptions(),
              itemBuilder: (context, index, integer) => Image.network(
                    bannerList.bannerSlider[index].image!,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Text('😢');
                    },
                  ));
        }
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
