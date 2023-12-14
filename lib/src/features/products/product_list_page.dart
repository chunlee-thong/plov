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
        itemCount: 200,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              goRouter.push("/products/${index + 1}", extra: {"title": "Soap"});
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                SkadiUtils.picsumImage(1720 + index, 1720 + index),
              ),
            ),
            title: const Text("Soap"),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            trailing: const Text("\$ 23.5"),
          );
        },
      ),
    );
  }
}
