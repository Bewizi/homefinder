import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homefinder/core/navigation/app_router.dart';
import 'package:homefinder/core/provider/bloc_provider.dart';
import 'package:homefinder/core/theme/app_theme.dart';
import 'package:homefinder/l10n/gen/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: appBlocProvider,
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: AppTheme.lightTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
