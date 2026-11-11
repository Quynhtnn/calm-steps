import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final store = LocalStore();

class LocalStore extends ChangeNotifier {
  late SharedPreferences prefs;
  bool signedIn = false;
  bool get dark => prefs.getBool('dark') ?? false;
  String get name => prefs.getString('name') ?? 'Friend';
  List<String> get favorites => prefs.getStringList('favorites') ?? [];
  Future<void> load() async {
    prefs = await SharedPreferences.getInstance();
    signedIn = prefs.getBool('signedIn') ?? false;
  }

  String digest(String password, String salt) =>
      sha256.convert(utf8.encode('$salt:$password')).toString();
  Future<void> register(String name, String email, String password) async {
    if (prefs.containsKey('email')) {
      throw Exception('An account already exists. Please log in.');
    }
    final random = Random.secure();
    final salt = base64Encode(List.generate(32, (_) => random.nextInt(256)));
    await prefs.setString('name', name.trim());
    await prefs.setString('email', email.trim().toLowerCase());
    await prefs.setString('salt', salt);
    await prefs.setString('passwordHash', digest(password, salt));
    await setSession(true);
  }

  Future<void> login(String email, String password) async {
    if (email.trim().toLowerCase() != prefs.getString('email') ||
        digest(password, prefs.getString('salt') ?? '') !=
            prefs.getString('passwordHash')) {
      throw Exception('Incorrect email or password.');
    }
    await setSession(true);
  }

  Future<void> setSession(bool value) async {
    await prefs.setBool('signedIn', value);
    signedIn = value;
    notifyListeners();
  }

  Future<void> toggleFavorite(String title) async {
    final values = favorites;
    values.contains(title) ? values.remove(title) : values.add(title);
    await prefs.setStringList('favorites', values);
    notifyListeners();
  }

  Future<void> setDark(bool value) async {
    await prefs.setBool('dark', value);
    notifyListeners();
  }

  Future<Map<String, Object?>> snapshot() async {
    await prefs.reload();
    return {
      'favorites': favorites,
      'dark': dark,
      'durationMinutes': prefs.getInt('durationMinutes') ?? 5,
      'reminder': prefs.getString('reminder'),
      'notifications': prefs.getBool('notifications') ?? false,
    };
  }
}
