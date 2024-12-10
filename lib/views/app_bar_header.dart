import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import '../providers/window.dart';

class AppBarHeader extends AppBar {
  AppBarHeader({super.key});
  @override
  bool? get centerTitle => true;
  @override
  Widget? get title => Text('Skygazer');
  @override
  // TODO: implement actions
  List<Widget>? get actions => [
        if (!kIsWeb)
          Consumer(builder: (context, ref, child) {
            final fullscreen = ref.watch(fullscreenProvider);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    WindowManager windowManager = WindowManager.instance;
                    windowManager.setFullScreen(!fullscreen);
                    ref.watch(fullscreenProvider.notifier).state = !fullscreen;
                  },
                  icon: Icon(fullscreen
                      ? Icons.fullscreen_exit_rounded
                      : Icons.fullscreen_rounded)),
            );
          })
      ];
}
