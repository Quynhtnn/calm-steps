import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchWeather() async {
  final response = await http
      .get(
        Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=10.82&longitude=106.63&current=temperature_2m,wind_speed_10m&timezone=auto',
        ),
      )
      .timeout(const Duration(seconds: 20));
  if (response.statusCode != 200) {
    throw Exception('API returned ${response.statusCode}');
  }
  final data = jsonDecode(response.body) as Map<String, dynamic>;
  final current = data['current'] as Map<String, dynamic>;
  if (current['temperature_2m'] == null || current['wind_speed_10m'] == null) {
    throw Exception('Weather data unavailable');
  }
  return [
    'Ho Chi Minh City — fixed demo location',
    'Temperature: ${current['temperature_2m']} °C',
    'Wind: ${current['wind_speed_10m']} km/h',
    'Updated: ${current['time']} (${data['timezone']})',
  ];
}
