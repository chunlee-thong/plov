import 'package:flutter/material.dart';
import 'package:plov/src/core/router/router.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product: ${widget.productId}"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Go Home"),
          onPressed: () => goRouter.go("/"),
        ),
      ),
    );
  }
}
