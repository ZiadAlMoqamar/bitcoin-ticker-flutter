import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var coindata = CoinData();

  Text selectedCurrency = Text('USD');
  Text selectedCurrencyValueforBTC = Text('?');
  Text selectedCurrencyValueforETH = Text('?');
  Text selectedCurrencyValueforLTC = Text('?');

  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<String>> itemsList = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      itemsList.add(newItem);
    }
    return itemsList;
  }
  void updateUI({dynamic coindata, String selectedCurrency}) async{
    List<dynamic> cryptoCoinsData =[];
    for(String crypto in cryptoList){
    var apiData = await coindata.getData(currency: selectedCurrency, crypto: crypto);
    cryptoCoinsData.add(apiData);
    }
    
     setState(() {
          var calculatedCurrency = cryptoCoinsData[0].toString();
          selectedCurrencyValueforBTC = Text(calculatedCurrency);
          var calculatedCurrency1 = cryptoCoinsData[1].toString();
          selectedCurrencyValueforETH = Text(calculatedCurrency1);
          var calculatedCurrency2 = cryptoCoinsData[2].toString();
          selectedCurrencyValueforLTC = Text(calculatedCurrency2);
     });
    
  }
  
  DropdownButton<String> getDropDownButton() {
    return DropdownButton<String>(
      value: selectedCurrency.data,
      items: getDropdownItems(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = Text(value);
          updateUI(coindata: coindata,selectedCurrency: value);
        });
      },
    );
  }

  List<Text> getCupertinoPickerItems() {
    List<Text> itemsList = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      itemsList.add(newItem);
    }
    return itemsList;
  }

  CupertinoPicker getCupertinoPicker() {
    List<Widget> cupertinoItems = getCupertinoPickerItems();
    return CupertinoPicker(
              itemExtent: 32.0,
              backgroundColor: Colors.lightBlue,
              onSelectedItemChanged: (selectedIndex) {
                setState(() {
                  selectedCurrency = cupertinoItems[selectedIndex];
                });
              },
              children: cupertinoItems,
            );
  }

  Widget getPicker(){
    if (Platform.isIOS){
      return getCupertinoPicker();
    }
    else if(Platform.isAndroid) {
      return getDropDownButton();
    }
  }
  Padding getCryptoCoinPadding({String crypto, String currencyValue}){
    return Padding(
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
                  '1 $crypto = $currencyValue ${selectedCurrency.data}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: SafeArea(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            getCryptoCoinPadding(crypto: 'BTC',currencyValue: selectedCurrencyValueforBTC.data),
            getCryptoCoinPadding(crypto: 'ETH',currencyValue: selectedCurrencyValueforETH.data),
            getCryptoCoinPadding(crypto: 'LTC',currencyValue: selectedCurrencyValueforLTC.data),
            SizedBox(height: 180,),
            Container(
              height: 150,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPicker()
            ),
          ],
        ),
      ),
    );
  }
}
