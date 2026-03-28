import 'package:flutter/material.dart';
import 'package:first_ecommerce_app/src/banner.dart';
//import 'package:flutter_notes_app/src/custom_app_bar.dart';
import 'package:first_ecommerce_app/src/controller/product_controller.dart';
import 'package:first_ecommerce_app/src/profile_screen.dart';
import 'package:first_ecommerce_app/src/repo/product_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping App"),
        backgroundColor: Colors.amberAccent,
        actions: <Widget>[
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            color: Colors.black,

            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),

      drawer: Drawer(
        shadowColor: Colors.amber,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.amberAccent),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: GestureDetector(
                      onTap: () {
                        // Define the action to perform when the image is tapped
                        //print("Image tapped!");
                      },
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&s',
                        height: 100,
                        width: 90,
                      ),
                    ),
                  ),
                  Text('Mohit'),
                ],
              ),
            ),
            InkWell(
              child: Column(
                children: [
                  ListTile(
                    title: Text('profile'),
                    leading: Icon(Icons.person_2_outlined),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileScreen(name: 'Mohit nayak'),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('About us'),
                    leading: Icon(Icons.info_outline),

                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Help'),
                    leading: Icon(Icons.help_outline),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Settings'),
                    leading: Icon(Icons.settings_outlined),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('logout'),
                    leading: Icon(Icons.logout_outlined),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: FutureBuilder(
        future: ProductController().getProducts(),
        builder: (context, snapshot) {
          // Check if snapshot is still loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Check for errors
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Check if there are no products available
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          final products = snapshot.data!;

          return Column(
            children: [
              // const CustomAppBar(),
              Expanded(
                child: ListView(
                  children: [
                    const MainBanner(),
                    ...products
                        .map((product) => ProductTile(product: product))
                        ,
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
