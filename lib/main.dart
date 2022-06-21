import 'package:flutter/material.dart';
import 'package:Genshinimpact/src/Apex.dart';
import 'package:Genshinimpact/src/Genshin.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genshin Impact',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Titillium Web',
        primarySwatch: Colors.blue
      ),
      home: const Scaffold(
        body: Genshin(),
      ),
    );
  }
}
