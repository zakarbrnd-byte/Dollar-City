/// Build metadata injected at compile time for deployment verification.
class BuildInfo {
  BuildInfo._();

  static const String version = String.fromEnvironment(
    'APP_BUILD_VERSION',
    defaultValue: 'local',
  );
}
