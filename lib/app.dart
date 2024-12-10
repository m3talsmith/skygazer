import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skygazer/views/app_bar_header.dart';
import 'package:window_manager/window_manager.dart';

import 'providers/auth.dart';
import 'providers/preferences.dart';
import 'providers/window.dart';
import 'views/auth/login.dart';
import 'views/feed.dart';
import 'window.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  onWindowMove() async {
    super.onWindowMove();

    final fullscreen = ref.watch(fullscreenProvider);
    ref.watch(preferencesProvider.notifier).state?.fullscreen = fullscreen;

    final offset = await windowManager.getPosition();
    final preferences = ref.watch(preferencesProvider);
    final currentPosition = preferences?.windowPosition;
    final position = WindowPosition(top: offset.dx, left: offset.dy);

    if (currentPosition != null &&
        (currentPosition.top != offset.dx ||
            currentPosition.left != offset.dy)) {
      if (!fullscreen) {
        ref.watch(preferencesProvider.notifier).state?.windowPosition =
            position;
      }
    } else {
      ref.watch(preferencesProvider.notifier).state?.windowPosition = position;
    }
  }

  @override
  void onWindowResize() async {
    super.onWindowResize();

    final fullscreen = ref.watch(fullscreenProvider);
    ref.watch(preferencesProvider.notifier).state?.fullscreen = fullscreen;

    final size = await windowManager.getSize();

    if (!fullscreen) {
      ref.watch(preferencesProvider.notifier).state?.windowSize = size;
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skygazer',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
      ),
      home: Builder(
        builder: (context) {
          final fullscreen = ref.watch(fullscreenProvider);
          // final size = MediaQuery.of(context).size;

          return (auth == null)
              ? const Login()
              : Scaffold(
                  appBar: AppBarHeader(),
                  body: const Feed(),
                );
        },
      ),
    );
  }
}
