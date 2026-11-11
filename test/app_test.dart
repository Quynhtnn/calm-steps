import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calm_steps/main.dart';
import 'package:calm_steps/services/storage.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await store.load();
  });
  test('Account login, favorites and preferences survive reloading', () async {
    await store.register('Fiona', 'fiona@example.com', 'Calm1234');
    await store.toggleFavorite('Morning Calm');
    await store.setDark(true);
    await store.setSession(false);
    final reloaded = LocalStore();
    await reloaded.load();
    expect(reloaded.favorites, ['Morning Calm']);
    expect(reloaded.dark, isTrue);
    expect(reloaded.signedIn, isFalse);
    await expectLater(
      reloaded.login('fiona@example.com', 'wrong123'),
      throwsException,
    );
    await reloaded.login('FIONA@example.com', 'Calm1234');
    expect(reloaded.signedIn, isTrue);
    expect(reloaded.prefs.getString('passwordHash'), isNot('Calm1234'));
  });
  testWidgets('Invalid signup is blocked; valid signup opens home and detail', (
    tester,
  ) async {
    await tester.pumpWidget(const CalmApp());
    await tester.tap(find.widgetWithText(OutlinedButton, 'Sign up'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Sign up'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid email'), findsOneWidget);
    expect(find.text('Use at least 8 characters'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(0), 'Fiona');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'fiona@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(2), 'Calm1234');
    await tester.tap(find.widgetWithText(FilledButton, 'Sign up'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome, Fiona!'), findsOneWidget);
    await tester.tap(find.text('Morning Calm'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Toggle favorite'), findsOneWidget);
    await tester.tap(find.byTooltip('Toggle favorite'));
    await tester.pumpAndSettle();
    expect(store.favorites, ['Morning Calm']);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Welcome, Fiona!'), findsOneWidget);
  });
}
