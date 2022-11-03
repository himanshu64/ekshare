import 'package:ekshare_example/main_page.dart';
import 'package:ekshare_example/second_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: "ekshare_example",
    initialRoute: '/',
    routes: {
      '/': (context) => const MyApp(),
      '/second-page': (context) => SecondPage(),
    },
  ));
}
