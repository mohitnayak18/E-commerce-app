import 'dart:async';
import 'dart:convert';
import 'dart:developer';
//import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:first_ecommerce_app/src/models/product.dart';
import 'package:first_ecommerce_app/src/repo/product_repo.dart';

class ProductController {
  final productRepo = ProductRepo();

  Future<List<Products>> getProducts() async {
    final response = await productRepo.getProducts();
    
    final data = jsonDecode(response.body);
    List<Products> products = [];
    final productsJson = data['products'];
    

    for (dynamic myProducts in productsJson) {
      
   products.add(Products.fromJson(myProducts));
     
    }
        log(products.toString() );
    return products;
    
  }
}
