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

  // This widget is the root of your application.
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
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
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
