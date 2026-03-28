import 'package:flutter/material.dart';
import 'package:first_ecommerce_app/src/models/product.dart';

class Product {
  List<String> images; // Assuming this is the structure of your product

  Product({required this.images});
}

class ProductView extends StatelessWidget {
  const ProductView({super.key, required this.product});

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Hero(
                tag: product.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(product.thumbnail),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(29.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, style: TextStyle(fontSize: 22)),
                  Row(
                    children: [
                      const Icon(Icons.star),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Text("Product Info", style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10.0),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 14),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  MaterialButton(
                    elevation: 0.0,
                    color: Colors.grey,
                    onPressed: () {},
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
