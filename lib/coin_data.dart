import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;




const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> getcoindata(String nationcurrency,String cryptocurrency)async {
    var url = Uri.parse('https://rest.coinapi.io/v1/exchangerate/$cryptocurrency/$nationcurrency?apikey=6618E513-9908-4F3F-B03E-A08CED6C45AA');

    var response = await http.get(url);//headers: {HttpHeaders.authorizationHeader: "6618E513-9908-4F3F-B03E-A08CED6C45AA"});
    if(response.statusCode==200){
      String data=response.body;
      var decodeddata=jsonDecode(data);
      return decodeddata;
    }
    else{
      print(response.statusCode);
    }
  }

}
