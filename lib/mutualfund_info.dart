import 'package:http/http.dart' as http;

// The MutualFundsInfo class provides methods to
// fetch and retrieve information about mutual funds in India,
// specifically their details and with Net Asset Values (NAVs)
class MutualFundsInfo {
  final String navURL =
      "https://www.amfiindia.com/spages/NAVAll.txt"; // URL to fetch NAV data

  // Method to get information about the package
  String about() {
    return "mutualfund-info - NPM Package to get the NAVs of Mutual Funds in India.";
  }

  // Method to fetch all NAVs
  Future<List<Map<String, String>>> getAllNavs() async {
    try {
      final result = await fetchNavs(navURL);
      return prepareNavsArray(result); // Process and resolve the fetched data
    } catch (e) {
      rethrow; // Rethrow the caught exception
    }
  }

  // Method to fetch NAV by scheme code
  Future<List<Map<String, String>>> fetchNavBySchemeCode(
      String schemeCode) async {
    final navs = await getAllNavs();
    var result = navs
        .where((nav) => nav["Scheme Code"]!
            .toLowerCase()
            .contains(schemeCode.toLowerCase()))
        .toList();

    return result;
  }

  // Method to fetch NAV by scheme name
  Future<List<Map<String, String>>> fetchNavBySchemeName(
      String schemeName) async {
    final navs = await getAllNavs();
    var result = navs
        .where((nav) => nav["Scheme Name"]!
            .toLowerCase()
            .contains(schemeName.toLowerCase()))
        .toList();
    return result;
  }
}

// Function to check if the fetched text contains an error
bool isError(String txt) {
  return txt.contains("Internal Server Error") ||
      !txt.split("\n")[0].toLowerCase().contains("scheme");
}

/// Method to fetch NAV data from the URL
/// Given a URL, this function fetches the data from the given URL.
/// It resolves with the fetched data if there is no error.
/// Otherwise, it rejects with an error message.
/// @param {String} url - URL to fetch data from
/// @returns {Future<String>}
Future<String> fetchNavs(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final result = response.body;
    if (isError(result)) {
      throw "Error in fetching NAVs."; // Check for errors
    } else {
      return result; // Resolve the fetched text
    }
  } else {
    throw "Error fetching data."; // Reject in case of an error
  }
}

/// Given a text fetched from the NAV URL, this function
/// returns an array of objects. Each object represents
/// a mutual fund and contains its details.
/// @param {String} txt - the text fetched from the NAV URL
/// @returns {List<Map<String, String>>> an array of objects, each representing a mutual fund
List<Map<String, String>> prepareNavsArray(String txt) {
  // Removes blank lines from the given text.
  String removeBlankLines(String txt) {
    return txt
        .replaceAll(RegExp(r'(\n{2,})'), '\n')
        .replaceAll(RegExp(r'(\r)'), '');
  }

  bool isDataRow(String row, List<String> headers) {
    return row.split(";").length == headers.length;
  }

  final rows =
      removeBlankLines(txt).split("\n").where((el) => el.length > 1).toList();
  final headers = rows.removeAt(0).split(";");

  final List<Map<String, String>> arr = [];
  String schemeType = "";
  String amcName = "";

  for (var i = 0; i < rows.length; ++i) {
    final row = rows[i];
    // check if the row is a data row
    if (isDataRow(row, headers)) {
      final attr = row.split(";");
      final data = <String, String>{};
      for (var j = 0; j < attr.length; ++j) {
        data[headers[j]] = attr[j];
      }
      data["AMC Name"] = amcName;
      data["Scheme Type"] = schemeType;
      arr.add(data);
    } else if (isDataRow(rows[i + 1], headers)) {
      // else this will be the AMC Name Row
      amcName = row; // Set AMC Name
    } else {
      // else this will be the Scheme Type Row
      schemeType = row; // Set Scheme Type
    }
  }
  return arr;
}
