import 'dart:async';
import 'package:flutter/material.dart';
import '../services/storage.dart';
import 'home.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.title});
  final String title;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Timer? timer;
  int remaining = 0;
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void start() {
    timer?.cancel();
    setState(
      () => remaining = (store.prefs.getInt('durationMinutes') ?? 5) * 60,
    );
    timer = Timer.periodic(const Duration(seconds: 1), (tick) {
      setState(() => remaining--);
      if (remaining == 0) {
        tick.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: store,
    builder: (context, child) => Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(Icons.self_improvement, size: 100, color: Colors.teal),
          Text(widget.title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          Text(meditations[widget.title]!),
          IconButton(
            tooltip: 'Toggle favorite',
            onPressed: () => store.toggleFavorite(widget.title),
            icon: Icon(
              store.favorites.contains(widget.title)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
          ),
          Text(
            remaining > 0
                ? '${remaining ~/ 60}:${(remaining % 60).toString().padLeft(2, '0')}'
                : 'Ready for a calm moment?',
            textAlign: TextAlign.center,
          ),
          FilledButton(
            onPressed: start,
            child: const Text('Start / restart meditation timer'),
          ),
        ],
      ),
    ),
  );
}
