import 'dart:developer';

import 'package:catcher/model/platform_type.dart';
import 'package:catcher/model/report.dart';
import 'package:catcher/model/report_mode.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

class CustomReportMode extends ReportMode {
  @override
  Future<void> requestAction(Report report, BuildContext? context) async {
    log(report.toJson().toString());
    FirebaseCrashlytics.instance.setCustomKey('Final', 'Error message');
    FirebaseCrashlytics.instance
        .recordError(report.error, report.stackTrace, printDetails: false);
  }

  @override
  List<PlatformType> getSupportedPlatforms() => [
        PlatformType.android,
        PlatformType.iOS,
        PlatformType.web,
        PlatformType.linux,
        PlatformType.macOS,
        PlatformType.windows,
      ];
}
