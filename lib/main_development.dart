import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:homefinder/app/app.dart';
import 'package:homefinder/bootstrap.dart';

Future<void> main() async {
  await bootstrap(
    () => DevicePreview(
      enabled:
          !kReleaseMode &&
          (Platform.isWindows || Platform.isMacOS || Platform.isLinux),
      builder: (context) => const App(),
    ),
  );
}
