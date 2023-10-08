import 'package:flutter/material.dart';
import 'package:flutter_starter_app/core/common/alert_error_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AlertErrorWidget displays error message',
      (WidgetTester tester) async {
    // Arrange
    const String errorMessage = 'An error occurred';

    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: AlertErrorWidget(errorMessage: errorMessage),
      ),
    ));

    // Expect to find the error message in the widget
    expect(find.text(errorMessage), findsOneWidget);

    // Expect to find the error icon
    expect(find.byIcon(Icons.error_outline), findsOneWidget);

    // Expect to find the error text style
    final textWidget = tester.widget<Text>(find.text(errorMessage));
    expect(textWidget.style?.fontSize, 16.0);

    // Ensure the widget is displayed
    expect(find.byType(AlertErrorWidget), findsOneWidget);
  });
}
