import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

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

  List<Widget> getCupertinoPickerItems() {
    List<Widget> itemsList = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      itemsList.add(newItem);
    }
    return itemsList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cupertinoItems = getCupertinoPickerItems();
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
                  '1 BTC = ? USD',
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
              child: CupertinoPicker(
                itemExtent: 32.0,
                backgroundColor: Colors.lightBlue,
                onSelectedItemChanged: (selectedIndex) {
                  setState(() {
                    selectedCurrency = cupertinoItems[selectedIndex].toString();
                  });
                },
                children: cupertinoItems,
              )),
        ],
      ),
    );
  }
}

// DropdownButton<String>(
//               value: selectedCurrency,
//               items: getDropdownItems(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedCurrency = value;
//                 });
//               },
//             ),
