/// This is an example of how to use the mutualfund_info package.
///
library;

import 'package:flutter/material.dart';
import 'package:mutualfund_info/mutualfund_info.dart' as mfinfo;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mutualfund Info Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Mutualfund Info Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  getAllNavs() async {
    final mfInfo = mfinfo.MutualFundsInfo();
    try {
      List<Map<String, String>> arr = await mfInfo.getAllNavs();
      if (arr.isNotEmpty) {
        print(arr[0]);
      }
    } catch (e) {
      print("Error Occurred: $e");
    }
  }

  getNAVBySchemeName() async {
    final mfInfo = mfinfo.MutualFundsInfo();
    try {
      List<Map<String, String>> arr = await mfInfo.fetchNavBySchemeName(
          "Aditya Birla Sun Life Banking & PSU Debt Fund  - DIRECT - IDCW");
      if (arr.isNotEmpty) {
        print(arr[0]);
      }
    } catch (e) {
      print("Error Occurred: $e");
    }
  }

  getNAVBySchemeCode() async {
    final mfInfo = mfinfo.MutualFundsInfo();
    List<Map<String, String>> arr = await mfInfo.fetchNavBySchemeCode('119551');

    if (arr.isNotEmpty) {
      print(arr);
    } else {
      print("No Mutual Fund found with the given Scheme Code.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final mfInfo = mfinfo.MutualFundsInfo();
    print(mfInfo.about());
    getAllNavs();
    getNAVBySchemeCode();
    getNAVBySchemeName();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Mutual Fund Info Demo',
            ),
          ],
        ),
      ),
    );
  }
}
