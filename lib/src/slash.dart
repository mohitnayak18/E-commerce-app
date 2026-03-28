import 'dart:async';

import 'package:flutter/material.dart';
import 'package:first_ecommerce_app/src/login.dart';

class Slash extends StatefulWidget {
  const Slash({super.key});

  @override
  State<Slash> createState() => _SlashState();
}

class _SlashState extends State<Slash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
      );
    });
  }

  //const Slash({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 218, 199, 151),
        child: Center(
          child: Text(
            'ₛₕₒₚₛYFₗY',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(137, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
  }
}
