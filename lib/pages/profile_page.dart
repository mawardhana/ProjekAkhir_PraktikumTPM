import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../config/colors.dart';
import 'konversi_page.dart';
import 'navigation_page.dart';
import 'waktu_page.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.pushNamed(context, NavigationPage.routeName);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Text('Profile'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Taufik Sahid Fadhil & Maulana Arya',
                style: TextStyle(
                    fontSize: 30.0, fontWeight: FontWeight.bold, color: primary),
              ),
              SizedBox(height: 8.0),
              Text(
                'NIM: 123200028 & 123200138',
                style: TextStyle(fontSize: 16.0, color: primary),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primary),
                  onPressed: () {
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor: primary,
                    );
                    Navigator.pop(context);
                    Navigator.pushNamed(context, KonversiPage.routeName);
                  },
                  child: Text(
                    'Konversi Mata Uang',
                    style: TextStyle(color: text),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, WaktuPage.routeName);
                  },
                  child: const Text(
                    'Konversi Waktu',
                    style: TextStyle(color: text),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: primary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Kesan dan Pesan:\n\n'
                    'Kesan: Mata kuliah TPM sangat menyenangkan sehingga saya sangat senang belajar TPM \n'
                    'Pesan: Semoga tidak mengulang tahun depan dan sehat selalu untuk mas mas aslab',
                    style: TextStyle(fontSize: 14, color: primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
