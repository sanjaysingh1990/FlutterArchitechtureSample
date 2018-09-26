import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_samples/common/models/catalog.dart';

import 'package:flutter_samples/common/widgets/cart_button.dart';
import 'package:flutter_samples/common/widgets/product_square.dart';
import 'package:flutter_samples/common/widgets/theme.dart';

import 'package:flutter_samples/src/scoped/scoped_cart_page.dart';
import 'package:flutter_samples/src/scoped/model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scoped Model',
      theme: appTheme,
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        CartPage.routeName: (context) => CartPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        actions: <Widget>[
          CartButton(
            itemCount: 0,
            onPressed: () {
              Navigator.of(context).pushNamed(CartPage.routeName);
            },
          )
        ],
      ),
      body: ProductGrid(),
    );
  }
}

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GridView.count(
        crossAxisCount: 2,
        children: catalog.products.map((product) {
          return ProductSquare(
            product: product,
            onTap: () => Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} tapped'))),
          );
        }).toList(),
      );
}
