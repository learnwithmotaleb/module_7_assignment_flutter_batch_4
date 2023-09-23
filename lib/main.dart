import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Product> products = [
    Product(name: "Product 1", price: 10),
    Product(name: "Product 2", price: 15),
    Product(name: "Product 3", price: 20),
    Product(name: "Product 4", price: 50),
    Product(name: "Product 5", price: 80),
    Product(name: "Product 6", price: 15),
    Product(name: "Product 7", price: 30),
    Product(name: "Product 8", price: 25),
    Product(name: "Product 9", price: 27),
    Product(name: "Product 10", price: 33),
    Product(name: "Product 11", price: 25),
    Product(name: "Product 12", price: 32),
    Product(name: "Product 13", price: 38),
    Product(name: "Product 14", price: 40),
    Product(name: "Product 15", price: 42),
    Product(name: "Product 16", price: 45),
    Product(name: "Product 17", price: 50),
    Product(name: "Product 18", price: 55),
    Product(name: "Product 19", price: 17),
    Product(name: "Product 20", price: 77),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
            trailing: ProductCounter(
              product: products[index],
              onUpdate: () {
                if (products[index].count == 5) {
                  _showCongratulationsDialog(products[index]);
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(products: products),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  void _showCongratulationsDialog(Product product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Congratulations!"),
          content: Text("You've bought 5 ${product.name}!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class Product {
  final String name;
  final double price;
  int count = 0;

  Product({required this.name, required this.price});
}

class ProductCounter extends StatefulWidget {
  final Product product;
  final Function onUpdate;

  ProductCounter({required this.product, required this.onUpdate});

  @override
  _ProductCounterState createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.product.count.toString()),
          SizedBox(height: 5,),
          ElevatedButton(
            child: Text('Buy Now'),
            onPressed: () {
              setState(() {
                widget.product.count++;
                widget.onUpdate();
              });
            },
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  @override
  Widget build(BuildContext context) {
    int totalItems = products.map((product) => product.count).reduce((a, b) => a + b);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Total Items in Cart: $totalItems"),
      ),
    );
  }
}
