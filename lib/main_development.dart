import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:homefinder/app/app.dart';
import 'package:homefinder/bootstrap.dart';
import 'package:homefinder/core/data/supabase_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: SupaBaseApi.url,
    anonKey: SupaBaseApi.anonKey,
  );
  await bootstrap(
    () => DevicePreview(
      enabled:
          !kReleaseMode &&
          (Platform.isWindows || Platform.isMacOS || Platform.isLinux),
      builder: (context) => const App(),
    ),
  );
}
