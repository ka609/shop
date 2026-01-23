import 'package:flutter/material.dart';
import 'screens/article_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce Articles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ArticleListScreen(),
    );
  }
}
