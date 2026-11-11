import 'package:flutter/material.dart';
import '../services/api.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});
  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  late Future<List<String>> request = fetchWeather();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Mindful world')),
    body: FutureBuilder<List<String>>(
      future: request,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Unable to load weather. Check your connection.'),
                FilledButton(
                  onPressed: () => setState(() => request = fetchWeather()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            const ListTile(
              title: Text('Weather for your next mindful walk'),
              subtitle: Text('Live weather: Open-Meteo.com'),
            ),
            for (final country in snapshot.data!)
              ListTile(leading: const Icon(Icons.public), title: Text(country)),
          ],
        );
      },
    ),
  );
}
