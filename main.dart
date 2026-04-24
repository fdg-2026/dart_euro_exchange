import 'dart:convert';
import 'package:http/http.dart' as http;

// copied from https://gemini.google.com/share/2d40b1fbf140

void main() async {
  await fetchExchangeRate();
}

Future<void> fetchExchangeRate() async {
  // We use Frankfurter API: no key needed for basic EUR -> USD
  final url = Uri.parse(
    'https://api.frankfurter.dev/v1/latest?base=EUR&symbols=USD',
  );

  try {
    print('Fetching current exchange rate...');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // The API returns a Map: { "base": "EUR", "date": "...", "rates": { "USD": 1.08 } }
      double usdRate = data['rates']['USD'];
      String date = data['date'];

      print('-------------------------------');
      print('Base Currency: EUR');
      print('Target Currency: USD');
      print('Current Rate: \$${usdRate.toStringAsFixed(4)}');
      print('Last Updated: $date');
      print('-------------------------------');
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}
