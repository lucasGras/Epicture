import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:epicture/views/LoginView.dart';
import 'package:epicture/views/HomeView.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:epicture/components/NavigationBar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

Future testWidgetInitialization() async {
  testWidgets('WebView Initialization', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: LoginView(),
    ));

    expect(find.byType(WebviewScaffold), findsOneWidget);
  });

  testWidgets('Application Initialization', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: NavigationBarWidget(byPassLogin: true),
      ));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.byType(SpeedDial), findsOneWidget);
      expect(find.byType(HomeView), findsOneWidget);
  });
}
