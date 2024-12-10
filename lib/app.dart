import 'package:bluesky/providers/auth.dart';
import 'package:bluesky/views/feed.dart';
import 'package:bluesky/views/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'providers/preferences.dart';
import 'providers/window.dart';
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

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Skygazer'),
              actions: [
                if (!kIsWeb)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          windowManager.setFullScreen(!fullscreen);
                          ref.watch(fullscreenProvider.notifier).state =
                              !fullscreen;
                        },
                        icon: Icon(fullscreen
                            ? Icons.fullscreen_exit_rounded
                            : Icons.fullscreen_rounded)),
                  )
              ],
            ),
            body: auth == null ? const Login() : const Feed(),
          );
        },
      ),
    );
  }
}
