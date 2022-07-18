import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'coin_data.dart';
import 'price_screen.dart';
import 'dart:convert';

class Loading_screen extends StatefulWidget {
  @override
  _Loading_screenState createState() => _Loading_screenState();
}

class _Loading_screenState extends State<Loading_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcoindata();
  }

  void getcoindata() async {
    CoinData coinData = CoinData();
    var coininfo = await coinData.getcoindata('USD','BTC');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PriceScreen(coininfo);
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: LoadingFlipping.circle(
            borderColor: Colors.cyan,
            borderSize: 3.0,
            size: 100.0,
            backgroundColor: Colors.cyanAccent,
            duration: Duration(milliseconds: 500),
          ),
        ),
    );
  }
}
