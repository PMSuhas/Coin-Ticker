//import 'dart:html';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  PriceScreen(this.coininfo);
  final coininfo;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initstate(){
    // TODO: implement initState
    super.initState();
    UpdateUI(widget.coininfo);

  }

  String selectedRightIndex = 'USD';
  String selectedLeftIndex='BTC';
  String currency;
  String crypto;
  String rate;
  CoinData coinData = CoinData();
  String msg;

 /* String displaymsg(rate){

    if(rate==''){
      msg= 'Click on the options below';
    }
    else
      msg='1 BTC = $rate $selectedIndex';
    return msg;
  }*/

  void UpdateUI(dynamic coindata) {
    setState(
      () {
        if (coindata == null) {
          rate = 'Error';
        }
        rate = coindata['rate'].toString();
        msg='1 BTC = $rate $selectedRightIndex';
      },
    );
  }

  CupertinoPicker IOSpickerNation() {
    List<Text> pickeritems = [];
    for (String currency in currenciesList) {
      pickeritems.add(Text(currency));
    }
    return CupertinoPicker(
        backgroundColor: Colors.blue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) async{
          var coininfo= await coinData.getcoindata(selectedRightIndex.toString(),selectedLeftIndex);
          UpdateUI(coininfo);
        },
        children: pickeritems);
  }

  DropdownButton<String> androidDropdownNation() {
    List<DropdownMenuItem<String>> dropdownitems = [];
    for (String currency in currenciesList) {
      dropdownitems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedRightIndex,
      items: dropdownitems,
      onChanged: (value) {
        setState(() async{
          selectedRightIndex = value;
          var coininfo= await coinData.getcoindata(selectedRightIndex,selectedLeftIndex);
          UpdateUI(coininfo);

        });
      },
    );
  }

  CupertinoPicker IOSpickerCrypto() {
    List<Text> pickeritems = [];
    for (String coin in cryptoList) {
      pickeritems.add(Text(crypto));
    }
    return CupertinoPicker(
        backgroundColor: Colors.blue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedLeftIndex) async{
          var coininfo= await coinData.getcoindata(selectedLeftIndex.toString(),selectedRightIndex);
          UpdateUI(coininfo);
        },
        children: pickeritems);
  }

  DropdownButton<String> androidDropdownnCrypto() {
    List<DropdownMenuItem<String>> dropdownitems = [];
    for (String crypto in cryptoList) {
      dropdownitems.add(
        DropdownMenuItem(
          child: Text(crypto),
          value: crypto,
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedLeftIndex,
      items: dropdownitems,
      onChanged: (value) {
        setState(() async{
          selectedLeftIndex = value;
          var coininfo= await coinData.getcoindata(selectedLeftIndex,selectedRightIndex);
          UpdateUI(coininfo);

        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $selectedLeftIndex = $rate $selectedRightIndex',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Platform.isAndroid ? androidDropdownnCrypto() : IOSpickerCrypto(),
                Platform.isAndroid ? androidDropdownNation() : IOSpickerNation(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
