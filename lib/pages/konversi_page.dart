import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/colors.dart';
import 'navigation_page.dart';

class KonversiPage extends StatefulWidget {
  static const routeName = '/konversi';

  @override
  _KonversiPageState createState() => _KonversiPageState();
}

class _KonversiPageState extends State<KonversiPage> {
  final TextEditingController _rupiahController = TextEditingController();
  double _dollar = 0.0;
  double _euro = 0.0;

  Future<void> _convertCurrency() async {
    try {
      final response = await http.get(Uri.parse('https://v6.exchangerate-api.com/v6/e7094b25166d1a5bae26c303/latest/IDR'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rates = data['conversion_rates'];
        double rupiah = double.tryParse(_rupiahController.text) ?? 0.0;
        _dollar = rupiah * rates['USD'];
        _euro = rupiah * rates['EUR'];
        setState(() {});
      } else {
        print('Failed to fetch conversion rates. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch conversion rates. Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushNamed(context, NavigationPage.routeName);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Text('Konversi Mata Uang'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: text),
                  controller: _rupiahController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: primary,
                    filled: true,
                    labelText: 'Amount in IDR',
                    labelStyle: TextStyle(color: text),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  onPressed: _convertCurrency,
                  child: Text('Convert', style: TextStyle(color: text)),
                ),
                SizedBox(height: 16.0),
                Text('Amount in USD: \$${_dollar.toStringAsFixed(2)}', style: TextStyle(color: primary)),
                Text('Amount in EUR: €${_euro.toStringAsFixed(2)}', style: TextStyle(color: primary)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}