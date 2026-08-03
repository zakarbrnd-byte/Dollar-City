/// Shared app-wide constants for Dollar City.
class AppConstants {
  AppConstants._();

  static const String appName = 'Dollar City';
  static const String tagline = 'Everything is \$1. Pick it up nearby.';
  static const double fixedItemPrice = 1.00;

  /// Injected at build time via `--dart-define=APP_BUILD_VERSION=...`.
  static const String appBuildVersion = String.fromEnvironment(
    'APP_BUILD_VERSION',
    defaultValue: 'local',
  );
}
