import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apikey = '141830DD-F75B-4F05-8AFF-7198557BB925';
const coinApiURL = 'https://rest.coinapi.io/v1/exchangerate/';
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
  String data;
  String choosedCurrency;
  String cryptoCurrency;

  CoinData();

  Future getData({@required String currency, @required String crypto}) async {
    http.Response response = await http.get('$coinApiURL$crypto/$currency?apikey=$apikey');
    if(response.statusCode == 200){
      data = response.body;
      var decodedData = jsonDecode(data)['rate'];
      return decodedData;
    }
    else{
      print(response.statusCode);
    }
  }
}
