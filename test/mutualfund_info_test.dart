import 'package:flutter_test/flutter_test.dart';

import 'package:mutualfund_info/mutualfund_info.dart' as mfinfo;

void main() {
  final mfInfo = mfinfo.MutualFundsInfo();
  test('check about info of the package', () {
    expect(mfInfo.about(),
        "mutualfund-info - NPM Package to get the NAVs of Mutual Funds in India.");
  });

  test('test getAllNavs', () async {
    final navs = await mfInfo.getAllNavs();
    expect(navs.length, greaterThanOrEqualTo(1));
  });

  test('test get Nav by scheme name', () async {
    final navs = await mfInfo.fetchNavBySchemeName(
        "Aditya Birla Sun Life Banking & PSU Debt Fund  - DIRECT - IDCW");

    expect(navs[0]['Scheme Name'],
        "Aditya Birla Sun Life Banking & PSU Debt Fund  - DIRECT - IDCW");
    expect(navs[0]['Scheme Code'], '119551');
  });

  test('test get Nav by scheme code', () async {
    final navs = await mfInfo.fetchNavBySchemeCode("119551");

    expect(navs[0]['Scheme Name'],
        "Aditya Birla Sun Life Banking & PSU Debt Fund  - DIRECT - IDCW");
  });
}
