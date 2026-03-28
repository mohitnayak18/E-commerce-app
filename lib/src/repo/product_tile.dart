import 'package:flutter/material.dart';
import 'package:first_ecommerce_app/src/models/product.dart';
import 'package:first_ecommerce_app/src/product_view.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});

  final Products product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductView(product: product,)));
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Hero(
                tag: product.id,
                child: Image.network(
                  product.thumbnail,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(fontSize: 18),
                  ), 
                  SizedBox(height: 1.0,),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    '\u{20B9}${product.price}',
                    style: const TextStyle(fontSize: 19),
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