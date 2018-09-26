import 'package:flutter/material.dart';
import 'package:flutter_samples/common/models/cart.dart';
import 'package:flutter_samples/common/models/catalog.dart';
import 'package:flutter_samples/common/models/product.dart';
import 'package:flutter_samples/common/widgets/cart_button.dart';
import 'package:flutter_samples/common/widgets/cart_page.dart';
import 'package:flutter_samples/common/widgets/product_square.dart';
import 'package:flutter_samples/common/widgets/theme.dart';
import 'package:meta/meta.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final cart = Cart();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vanilla',
      theme: appTheme,
      home: MyHomePage(cart: cart),
      routes: <String, WidgetBuilder>{
        CartPage.routeName: (context) => CartPage(cart),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Cart cart;

  MyHomePage({
    Key key,
    @required this.cart,
  }) : super(key: key);

  @override
  createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  _updateCart(Product product) {
    setState(() => widget.cart.add(product));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vanilla'),
        actions: <Widget>[
          // The shopping cart button in the app bar
          CartButton(
            itemCount: widget.cart.itemCount,
            onPressed: () {
              Navigator.of(context).pushNamed(CartPage.routeName);
            },
          )
        ],
      ),
      body: ProductGrid(
        cart: widget.cart,
        updateProduct: _updateCart,
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final Cart cart;
  final Function(Product) updateProduct;

  ProductGrid({
    Key key,
    @required this.cart,
    @required this.updateProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: catalog.products.map((product) {
        return ProductSquare(
          product: product,
          onTap: () => updateProduct(product),
        );
      }).toList(),
    );
  }
}
