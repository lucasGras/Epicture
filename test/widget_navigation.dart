import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:epicture/components/NavigationBar.dart';

import 'package:epicture/views/HomeView.dart';
import 'package:epicture/views/SearchView.dart';
import 'package:epicture/views/ProfileView.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

Future testWidgetNavigation() async {
  testWidgets('Application Navigation', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: NavigationBarWidget(byPassLogin: true),
      ));

      expect(find.byType(SearchView), findsNothing);
      expect(find.byType(ProfileView), findsNothing);
      expect(find.byType(HomeView), findsOneWidget);

      await tester.tap(find.text("Search"));
      await tester.pump();

      expect(find.byType(HomeView), findsNothing);
      expect(find.byType(ProfileView), findsNothing);
      expect(find.byType(SearchView), findsOneWidget);

      await tester.tap(find.text("Profile"));
      await tester.pump();

      expect(find.byType(SearchView), findsNothing);
      expect(find.byType(HomeView), findsNothing);
      expect(find.byType(ProfileView), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
  });

  testWidgets('Application Floating Buttons Navigation', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: NavigationBarWidget(byPassLogin: true),
      ));

      expect(find.byType(SpeedDial), findsOneWidget);

      await tester.tap(find.byType(SpeedDial));
      await tester.pump();
  });
}
