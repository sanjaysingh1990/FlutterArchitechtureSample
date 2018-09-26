import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_samples/common/models/cart.dart';
import 'package:flutter_samples/common/models/catalog.dart';
import 'package:flutter_samples/common/models/product.dart';
import 'package:flutter_samples/common/widgets/cart_button.dart';
import 'package:flutter_samples/common/widgets/cart_page.dart';
import 'package:flutter_samples/common/widgets/product_square.dart';
import 'package:flutter_samples/common/widgets/theme.dart';

void main() {
  final cartObservable = CartObservable(Cart());

  runApp(MyApp(
    cartObservable: cartObservable,
  ));
}

class CartObservable extends ValueNotifier<Cart> {
  CartObservable(Cart value) : super(value);

  void add(Product product) {
    value.add(product);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final CartObservable cartObservable;

  MyApp({
    Key key,
    @required this.cartObservable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ValueNotifer',
      theme: appTheme,
      home: MyHomePage(
        cartObservable: cartObservable,
      ),
      routes: <String, WidgetBuilder>{
        CartPage.routeName: (context) => CartPage(cartObservable.value)
      },
    );
  }
}

/// The sample app's main page
class MyHomePage extends StatefulWidget {
  final CartObservable cartObservable;

  MyHomePage({
    Key key,
    @required this.cartObservable,
  }) : super(key: key);

  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    widget.cartObservable.addListener(myListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ValueNotifer"),
          actions: <Widget>[
            CartButton(
              itemCount: widget.cartObservable.value.itemCount,
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            )
          ],
        ),
        body: ProductGrid(
          cartObservable: widget.cartObservable,
        ));
  }

  void myListener() {
    setState(() {
      // Nothing
    });
  }
}

/// Displays the contents of the cart
class CartContents extends StatelessWidget {
  final CartObservable cartObservable;

  CartContents({
    Key key,
    @required this.cartObservable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(24.0),
      child: Text("Cart: ${cartObservable.value.items}"));
}

/// Displays a tappable grid of products
class ProductGrid extends StatelessWidget {
  final CartObservable cartObservable;

  ProductGrid({
    Key key,
    @required this.cartObservable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GridView.count(
        crossAxisCount: 2,
        children: catalog.products.map((product) {
          return ProductSquare(
            product: product,
            onTap: () {
              cartObservable.add(product);
            },
          );
        }).toList(),
      );
}
