import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform/platform.dart';

import 'app.dart';
import 'preferences.dart';
import 'providers/preferences.dart';
import 'providers/window.dart';
import 'window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isFullscreen = false;
  Preferences? preferences;

  if (!kIsWeb) {
    const platform = LocalPlatform();
    if (platform.isMacOS ||
        platform.isWindows ||
        platform.isLinux ||
        platform.isFuchsia) {
      final window = Window();
      await window.ensureInitialized();

      isFullscreen = window.fullscreen;
      preferences = window.preferences;
    }
  }

  final overrides = [
    fullscreenProvider.overrideWith((ref) => isFullscreen),
    preferencesProvider.overrideWith((ref) => preferences),
  ];

  runApp(ProviderScope(
    overrides: overrides,
    child: const App(),
  ));
}
