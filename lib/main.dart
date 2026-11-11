import 'package:flutter/material.dart';
import 'services/storage.dart';
import 'screens/auth.dart';
import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await store.load();
  runApp(const CalmApp());
}

class CalmApp extends StatelessWidget {
  const CalmApp({super.key});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: store,
    builder: (context, child) => MaterialApp(
      title: 'Calm Steps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.dark,
      ),
      themeMode: store.dark ? ThemeMode.dark : ThemeMode.light,
      home: store.signedIn ? const HomeScreen() : const AuthScreen(),
    ),
  );
}
