import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager_ui/main.dart';

void main() {
  testWidgets('Task Manager app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TaskManagerApp());

    // Verify that the app title is displayed
    expect(find.text('Task Manager'), findsOneWidget);
    
    // Verify that task cards are displayed
    expect(find.byType(Card), findsWidgets);
  });
}

