import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home_page.dart';
import 'pages/konversi_page.dart';
import 'pages/login_page.dart';
import 'pages/navigation_page.dart';
import 'pages/profile_page.dart';
import 'pages/register_page.dart';
import 'pages/splashscreen_page.dart';
import 'pages/waktu_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project TPM',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: (settings) {
        if (settings.name == SplashScreen.routeName) {
          return MaterialPageRoute(builder: (context) => SplashScreen());
        } else if (settings.name == LoginPage.routeName) {
          return MaterialPageRoute(builder: (context) => LoginPage());
        } else if (settings.name == RegisterPage.routeName) {
          return MaterialPageRoute(builder: (context) => RegisterPage());
        } else if (settings.name == HomePage.routeName) {
          return MaterialPageRoute(builder: (context) => HomePage());
        } else if (settings.name == NavigationPage.routeName) {
          return MaterialPageRoute(builder: (context) => NavigationPage());
        } else if (settings.name == ProfilePage.routeName) {
          return MaterialPageRoute(builder: (context) => ProfilePage());
        } else if (settings.name == KonversiPage.routeName) {
          return MaterialPageRoute(builder: (context) => KonversiPage());
        } else if (settings.name == WaktuPage.routeName) {
          return MaterialPageRoute(builder: (context) => WaktuPage());
        }
        return null;
      },
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final isLoggedIn = snapshot.data!;
            if (isLoggedIn) {
              return HomePage();
            } else {
              return LoginPage();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}
