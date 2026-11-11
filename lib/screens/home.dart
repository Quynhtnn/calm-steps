import 'package:flutter/material.dart';
import '../services/storage.dart';
import 'detail.dart';
import 'settings.dart';

const meditations = <String, String>{
  'Morning Calm':
      'Sit comfortably. Relax your shoulders. Breathe in for four counts and out for six. Notice each breath and gently return your attention when your mind wanders.',
  'Mindful Walk':
      'Walk slowly in a safe space. Feel each foot touch the ground. Notice three sounds and three colors. Return your attention to the next step.',
  'Evening Reset':
      'Sit or lie comfortably. Release tension from your feet to your face. Notice your breathing. Finish by naming one small thing you appreciated today.',
};
void openScreen(BuildContext context, Widget screen) =>
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Row(
        children: [
          Icon(Icons.spa, color: Colors.teal),
          SizedBox(width: 8),
          Text('Calm Steps'),
        ],
      ),
      actions: [
        IconButton(
          tooltip: 'Settings menu',
          icon: const Icon(Icons.menu),
          onPressed: () => openScreen(context, const SettingsMenu()),
        ),
      ],
    ),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Welcome, ${store.name}!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Text('Take a little time for yourself today.'),
        const SizedBox(height: 24),
        Text(
          'Recommended meditations',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        for (final title in meditations.keys)
          Card(
            child: ListTile(
              leading: const Icon(Icons.self_improvement),
              title: Text(title),
              subtitle: const Text('Open practice instructions'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => openScreen(context, DetailScreen(title: title)),
            ),
          ),
        FilledButton.tonal(
          onPressed: () => openScreen(context, const FavoritesScreen()),
          child: const Text('Favorites / Profile'),
        ),
      ],
    ),
  );
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: store,
    builder: (context, child) => Scaffold(
      appBar: AppBar(title: const Text('Favorites / Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(store.name, style: Theme.of(context).textTheme.headlineMedium),
          if (store.favorites.isEmpty)
            const Text('Open a meditation and tap the heart to save it.'),
          for (final title in store.favorites)
            ListTile(
              title: Text(title),
              trailing: const Icon(Icons.favorite),
              onTap: () => openScreen(context, DetailScreen(title: title)),
            ),
          const Divider(),
          const Text('Local storage — reloaded from device'),
          FutureBuilder<Map<String, Object?>>(
            future: store.snapshot(),
            builder: (context, snapshot) => SelectableText(
              snapshot.data?.toString() ?? 'Loading saved values…',
            ),
          ),
        ],
      ),
    ),
  );
}
