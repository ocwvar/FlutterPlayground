import 'dart:io';

class PlatformControl {
  static final PlatformControl self = PlatformControl._init();
  PlatformControl._init();

  factory PlatformControl() {
    return self;
  }

  PlatformVersion _currentPlatform = PlatformVersion.auto;
  PlatformVersion get currentPlatform => _currentPlatform;

  bool isRunningAndroid() {
    switch(currentPlatform) {
      case PlatformVersion.aOS:
        return true;
      case PlatformVersion.iOS:
        return false;
      case PlatformVersion.auto:
        return Platform.isAndroid;
    }
  }

  void setPlatformVersion(PlatformVersion platformVersion) {
    _currentPlatform = platformVersion;
  }

}

enum PlatformVersion {
  aOS,
  iOS,
  auto
}