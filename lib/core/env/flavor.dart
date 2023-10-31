import 'package:face_shape/core/env/env_config.dart';

/// * This file is configuration to make separate between environment
/// see details about [flutter flavor]

class FlavorSettings {
  static const url = "https://lambang0902-test-space.hf.space";

  FlavorSettings.development() {
    EnvConfig.getInstance(
      flavorName: 'development',
      apiBaseUrl: url,
    );
  }

  FlavorSettings.staging() {
    EnvConfig.getInstance(
      flavorName: 'staging',
      apiBaseUrl: url,
    );
  }

  FlavorSettings.production() {
    EnvConfig.getInstance(
      flavorName: 'production',
      apiBaseUrl: url,
    );
  }
}
