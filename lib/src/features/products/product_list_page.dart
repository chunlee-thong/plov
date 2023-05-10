import 'package:flutter/material.dart';
import 'package:plov/src/core/router/router.dart';
import 'package:skadi/skadi.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    infoLog("Init product list page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product")),
      body: ListView.builder(
        itemCount: 1,
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              goRouter.push("/products/${index + 1}", extra: {"title": "Soap"});
            },
            leading: const CircleAvatar(child: Icon(Icons.food_bank)),
            title: const Text("Soap"),
            trailing: const Text("\$ 23.5"),
          );
        },
      ),
    );
  }
}
