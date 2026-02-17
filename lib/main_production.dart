import 'package:homefinder/app/app.dart';
import 'package:homefinder/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
