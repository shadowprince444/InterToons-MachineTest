import 'package:flutter/material.dart';
import 'package:omanphones/models/banner_list.dart';
import 'package:omanphones/models/local_cart.dart';
import 'package:omanphones/models/product_info.dart';
import 'package:omanphones/models/product_list.dart';
import 'package:omanphones/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'models/similar_products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductList>(create: (_) => ProductList()),
        ChangeNotifierProvider<BannerList>(create: (_) => BannerList()),
        ChangeNotifierProvider<ProductInfo>(create: (_) => ProductInfo()),
        ChangeNotifierProvider<SimilarProducts>(
            create: (_) => SimilarProducts()),
        ChangeNotifierProvider<LocalCart>(create: (_) => LocalCart())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
