import 'package:device_preview/device_preview.dart';
import 'package:homefinder/app/app.dart';
import 'package:homefinder/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => DevicePreview(builder: (context) => const App()));
}
