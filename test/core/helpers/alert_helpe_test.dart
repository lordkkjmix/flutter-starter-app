import 'package:flutter/material.dart';
import 'package:flutter_starter_app/core/helpers/alert_helper.dart';
import 'package:flutter_starter_app/core/providers/injection_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    // Initialize GetIt for dependency injection
    sl.registerLazySingleton<GlobalKey<ScaffoldMessengerState>>(
      () => GlobalKey<ScaffoldMessengerState>(),
    );
  });

  testWidgets('AlertHelper displays SnackBar with message',
      (WidgetTester tester) async {
    // Arrange
    const String message = 'This is a test message';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () {
              AlertHelper.displaySnackBar(message: message);
            },
            child: const Text('Show SnackBar'),
          );
        }),
      ),
    ));

    // Act: Tap the button to show the SnackBar
    await tester.tap(find.text('Show SnackBar'));
    await tester.pumpAndSettle();

    // Assert: Verify that the SnackBar is displayed with the expected message
    expect(find.text(message), findsOneWidget);

    // Ensure the widget is displayed
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
