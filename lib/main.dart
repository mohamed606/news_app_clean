import 'package:flutter/material.dart';
import 'package:news_app_clean/features/show_news/presentation/pages/articles_page.dart';
import 'package:news_app_clean/injection_container.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ArticlesPage(),
    );
  }
}

