import 'package:flutter/material.dart';

class MainBanner extends StatelessWidget {
  const MainBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color.fromARGB(255, 255, 192, 4),
        image: const DecorationImage(
          image: NetworkImage(
            'https://t3.ftcdn.net/jpg/03/79/47/50/240_F_379475085_ybrcCjKcdW4NL1z9jrVYdV4govjlrqsf.jpg',
          ),
        ),
      ),
    );
  }
}
