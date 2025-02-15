<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

Flutter Package to get the current(Today's) NAVs of Mutual Funds in India

The data is being fetched from Association of Mutual Funds India (AMFI)'s portal https://www.amfiindia.com/

## Usage

```dart
import 'package:../mutualfund_info/mutualfund_info.dart' as mfinfo;
```

### Get all Navs . This returns all the Mutual Funds' Navs in an array format

This will be an array of objects of all the Schemes in Indian MF

```dart
  final mfInfo = mfinfo.MutualFundsInfo();
    try {
      List<Map<String, String>> arr = await mfInfo.getAllNavs();
      if (arr.isNotEmpty) {
        print(arr[0]); // add your code here
      }
    } catch (e) {
      print("Error Occurred: $e");
    }
```

Sample Output of the NAV Object Array

```dart
[
  {
    'Scheme Code': '116174',
    'ISIN Div Payout/ ISIN Growth': 'INF109K01YE1',
    'ISIN Div Reinvestment': 'INF109K01YD3',
    'Scheme Name': 'ICICI Prudential Banking and PSU Debt Fund - Quarterly IDCW',
    'Net Asset Value': '10.8471',
    Date: '11-Feb-2025',
    'AMC Name': 'ICICI Prudential Mutual Fund',
    'Scheme Type': 'Open Ended Schemes(Debt Scheme - Banking and PSU Fund)'
  },
  ....
]
```

### Fetch Nav of a particular Mutual Fund By it's Scheme Name

You can fetch a MF's Nav by its name as below by using the _fetchNavBySchemeName_ method.

```dart
  final mfInfo = mfinfo.MutualFundsInfo();

  List<Map<String, String>> arr = await mfInfo.fetchNavBySchemeName(
      "Aditya Birla Sun Life Banking & PSU Debt Fund  - DIRECT - IDCW");
  if (arr.isNotEmpty) {
    print(arr[0]); // add your code here
  }

  // you can use with try catch block as well, as the example above


// The sample will be something similar to
[{
  'Scheme Code': '119551',
  'ISIN Div Payout/ ISIN Growth': 'INF209KA12Z1',
  'ISIN Div Reinvestment': 'INF209KA13Z9',
  'Scheme Name': 'Aditya Birla Sun Life Banking & PSU Debt Fund  - DIRECT - IDCW',
  'Net Asset Value': '154.6417',
  Date: '21-May-2021',
  'AMC Name': 'Aditya Birla Sun Life Mutual Fund',
  'Scheme Type': 'Open Ended Schemes(Debt Scheme - Banking and PSU Fund)'
}]

```

### Fetch Nav of a particular Mutual Fund By it's Scheme Code

You can fetch a MF's Navby its code as below by using the _fetchNavBySchemeCode_ method.

```dart
  final mfInfo = mfinfo.MutualFundsInfo();
  List<Map<String, String>> arr = await mfInfo.fetchNavBySchemeCode('119551');
   if (arr.isNotEmpty) {
      print(arr); // add your code here
    } else {
      print("No Mutual Fund found with the given Scheme Code.");
    }
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
