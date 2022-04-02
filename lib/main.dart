import 'package:flutter/material.dart';
import 'package:flutter_playground/base/theme_view_model.dart';
import 'package:flutter_playground/page/home/view.dart';
import 'package:flutter_playground/widget/app_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const PlaygroundApp());
}

class PlaygroundApp extends StatelessWidget {
  const PlaygroundApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          final ThemeViewModel viewModel = ThemeViewModel();
          viewModel.changeThemeColor(Colors.pink, false);
          return viewModel;
        },
        child: Consumer<ThemeViewModel>(
          builder: (context, viewModel, child) {

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: viewModel.currentThemeColor(),
                primarySwatch: viewModel.currentThemeColor(),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: viewModel.currentThemeColor(),
                primarySwatch: viewModel.currentThemeColor(),
              ),
              themeMode: viewModel.currentMode(),
              home: Scaffold(
                appBar: createAppBar(context, "Playground", false),
                body: HomeView(viewModel),
              ),
            );
          },
        ),
    );
  }
}
