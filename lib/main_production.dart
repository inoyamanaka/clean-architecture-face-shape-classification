import 'dart:developer';

import 'package:face_shape/app/app.dart';
import 'package:face_shape/bootstrap.dart';
import 'package:face_shape/core/env/env_config.dart';
import 'package:face_shape/core/env/flavor.dart';
import 'package:flutter/foundation.dart';

void main() {
  FlavorSettings.production();

  bootstrap(() => const App());
  if (!kReleaseMode) {
    final settings = EnvConfig.getInstance();
    log('🚀 APP FLAVOR NAME      : ${settings.flavorName}', name: 'ENV');
    log('🚀 APP API_BASE_URL     : ${settings.apiBaseUrl}', name: 'ENV');
  }
}
