import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_playground/base/theme_view_model.dart';
import 'package:flutter_playground/generated/l10n.dart';
import 'package:flutter_playground/page/home/view.dart';
import 'package:flutter_playground/widget/platform/app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const PlaygroundApp());
}

class PlaygroundApp extends StatelessWidget {
  const PlaygroundApp({Key? key}) : super(key: key);
  final Color _defaultThemeColor = Colors.pink;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return ThemeViewModel(_defaultThemeColor);
        },
        child: Consumer<ThemeViewModel>(
          builder: (context, viewModel, child) {
            return PlatformApp(
                androidLightTheme: viewModel.getMaterialThemeData(false),
                androidDarkTheme: viewModel.getMaterialThemeData(true),
                iOSTheme: viewModel.getCupertinoThemeData(),
                dayNightType: viewModel.currentType,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                home: HomeView(viewModel)
            ).getPlatformObject(context);
          },
        ),
    );
  }
}
