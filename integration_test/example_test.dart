import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:patrolaws/src/app.dart';
import 'package:patrolaws/src/settings/settings_controller.dart';
import 'package:patrolaws/src/settings/settings_service.dart';

void main() {
  patrolTest(
    'list view to detail view and back',
    ($) async {
      final WidgetTester tester = $.tester;

      final settingsController = SettingsController(SettingsService());
      await settingsController.loadSettings();

      await $.pumpWidgetAndSettle(MyApp(settingsController: settingsController));

      expect($('Sample Items'), findsOneWidget);
      expect($('SampleItem 1'), findsOneWidget);
      expect($('SampleItem 2'), findsOneWidget);
      expect($(ListView).$(ListTile).$('SampleItem 3'), findsOneWidget);

      await $(ListView).$(ListTile).$('SampleItem 2').tap();
      expect($('Item Details'), findsOneWidget);
      expect($('More Information Here'), findsOneWidget);

      await $(find.byTooltip('Back')).tap();
      expect($('Sample Items'), findsOneWidget);
    },
  );
}
