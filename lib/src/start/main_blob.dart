import 'package:flutter/material.dart';
import 'package:flutter_samples/common/models/cart.dart';
import 'package:flutter_samples/common/models/catalog.dart';
import 'package:flutter_samples/common/widgets/cart_button.dart';
import 'package:flutter_samples/common/widgets/cart_page.dart';
import 'package:flutter_samples/common/widgets/product_square.dart';
import 'package:flutter_samples/common/widgets/theme.dart';

void main() => runApp(MyApp());

final Cart _cart = Cart();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Start',
      theme: appTheme,
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        CartPage.routeName: (context) => CartPage(_cart)
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Start"),
        actions: <Widget>[
          // The shopping cart button in the app bar
          CartButton(
            itemCount: _cart.itemCount,
            onPressed: () {
              Navigator.of(context).pushNamed(CartPage.routeName);
            },
          )
        ],
      ),
      body: Builder(
        builder: (context) => GridView.count(
              crossAxisCount: 2,
              children: catalog.products.map((product) {
                return ProductSquare(
                  product: product,
                  onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("${product.name} tapped"))),
                );
              }).toList(),
            ),
      ),
    );
  }
}
