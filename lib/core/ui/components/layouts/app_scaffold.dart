import 'package:flutter/material.dart';
import 'package:homefinder/core/variables/app_inset.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.bottomNavigationBar,
    this.appbar,

    this.padding,
    super.key,
    this.backgroundColor,
  });

  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appbar;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: padding != null
            ? Padding(
                padding: AppInset.screenSymmetric,
                child: body,
              )
            : body,
      ),
    );
  }
}
