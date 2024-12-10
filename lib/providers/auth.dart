import 'package:riverpod/riverpod.dart';

import '../models/auth.dart';

final authProvider = StateProvider<Auth?>(
  (ref) => null,
);
