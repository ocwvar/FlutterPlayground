import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/base/theme_view_model.dart';
import 'package:flutter_playground/widget/platform/scaffold.dart';

import '../../base/platform_control.dart';
import '../../widget/platform/app_bar.dart';
import '../../widget/platform/base.dart';
import '../../widget/platform/button.dart';
import '../../widget/platform/platform_extension.dart';
import '../feature/view.dart';

class SettingView extends StatelessWidget {
  final ThemeViewModel themeViewModel;

  const SettingView({Key? key, required this.themeViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        isiOSLargeStyle: true,
        platformAppBar: PlatformAppBar(
            context: context,
            title: "Setting",
            hasBackAction: false
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // day-night panel
                Padding(
                    padding: const EdgeInsets.only(left: 8, top: 20),
                    child: Text("DayNight control", style: getNullablePlatformObject<TextStyle>(
                        forAndroid: Theme.of(context).textTheme.titleMedium,
                        forIOS: CupertinoTheme.of(context).textTheme.textStyle
                    ))
                ),
                createDayNightButtonPanel(context),

                // platform version panel
                Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: Text("Platform style", style: getNullablePlatformObject<TextStyle>(
                        forAndroid: Theme.of(context).textTheme.titleMedium,
                        forIOS: CupertinoTheme.of(context).textTheme.textStyle
                    ))
                ),
                createPlatformButtonPanel(context),

                // theme color panel
                Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: Text("Theme color control", style: getNullablePlatformObject<TextStyle>(
                        forAndroid: Theme.of(context).textTheme.titleMedium,
                        forIOS: CupertinoTheme.of(context).textTheme.textStyle
                    ))
                ),
                createThemeColorPanel(context),

                // entry point features list page
                const Divider(height: 5,thickness: 1,),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: PlatformButton(
                      onPressed: () => enterFeaturePage(context),
                      child: const Text("DONE"),
                    ),
                  ),
                )
              ]
          ),
        ),
    );
  }

  void enterFeaturePage(BuildContext context) {
    PlatformNavigator.pushByPlatform(context, const FeatureView());
  }

  /// on user clicked day-night control buttons
  /// @param [DayNightType]
  void onClickDayNightButton(DayNightType type) {
    themeViewModel.changeType(type);
  }

  /// on user clicked platform version control buttons
  /// @param [PlatformVersion]
  void onClickPlatformVersionButton(PlatformVersion platformVersion) {
    themeViewModel.setPlatformVersion(platformVersion);
  }

  /// Theme color control buttons panel
  /// @return [Widget]
  Widget createThemeColorPanel(BuildContext context) {
    Widget wrapCard(Color targetColor) {
      return PlatformButton(
          onPressed: () => themeViewModel.changeThemeColor(targetColor, true),
          androidButtonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(targetColor),
              fixedSize: MaterialStateProperty.all(const Size(50.0, 50.0))
          ),
          iosButtonColor: targetColor,
          iosButtonPadding: EdgeInsets.zero,
          child: const SizedBox(width: 50, height: 50)
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          wrapCard(Colors.pink),
          const Spacer(),
          wrapCard(Colors.deepOrange),
          const Spacer(),
          wrapCard(Colors.green),
          const Spacer(),
          wrapCard(Colors.blueAccent),
          const Spacer(),
          wrapCard(Colors.purple),
          const Spacer(),
        ],
      ),
    );
  }

  /// Platform version control buttons panel
  /// @return [Widget]
  Widget createPlatformButtonPanel(BuildContext context) {

    /// get function that will be toggle when button click
    /// @param [DayNightType]
    /// @return [Function?] null if given [DayNightType] is currently using
    Function() getClickFunction(PlatformVersion platformVersion) {
      return () { onClickPlatformVersionButton(platformVersion); };
    }

    final PlatformVersion currentVersion = PlatformControl.self.currentPlatform;

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        children: [
          const Spacer(),
          PlatformButton(
              isDisable: currentVersion == PlatformVersion.aOS,
              onPressed: getClickFunction(PlatformVersion.aOS) ,
              child: const Text("Android")),
          const Spacer(),
          PlatformButton(
              isDisable: currentVersion == PlatformVersion.iOS,
              onPressed: getClickFunction(PlatformVersion.iOS) ,
              child: const Text("iOS")),
          const Spacer(),
          PlatformButton(
              isDisable: currentVersion == PlatformVersion.auto,
              onPressed: getClickFunction(PlatformVersion.auto) ,
              child: const Text("Auto")),
          const Spacer(),
        ],
      ),
    );
  }

  /// Day-Night control buttons panel
  /// @return [Widget]
  Widget createDayNightButtonPanel(BuildContext context) {

    /// get function that will be toggle when button click
    /// @param [DayNightType]
    /// @return [Function?] null if given [DayNightType] is currently using
    Function() getClickFunction(DayNightType targetType) {
      return () { onClickDayNightButton(targetType); };
    }

    final DayNightType currentType = themeViewModel.currentType;

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        children: [
          const Spacer(),
          PlatformButton(
              isDisable: currentType == DayNightType.light,
              onPressed: getClickFunction(DayNightType.light) ,
              child: const Text("Light")),
          const Spacer(),
          PlatformButton(
              isDisable: currentType == DayNightType.night,
              onPressed: getClickFunction(DayNightType.night) ,
              child: const Text("Night")),
          const Spacer(),
          PlatformButton(
              isDisable: currentType == DayNightType.followSystem,
              onPressed: getClickFunction(DayNightType.followSystem) ,
              child: const Text("Auto")),
          const Spacer(),
        ],
      ),
    );
  }
}