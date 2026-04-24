import 'dart:convert';
import 'package:http/http.dart' as http;

// copied from https://chatgpt.com/share/69e27dcd-47d0-832d-9dd2-42aa39622727

Future<void> main() async {
  const url = 'https://api.exchangerate.host/latest?base=EUR&symbols=USD';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rate = data['rates']['USD'];

      print('Current EUR → USD rate: $rate');
      print('1 EUR = $rate USD');
    } else {
      print('Failed to fetch exchange rate: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
