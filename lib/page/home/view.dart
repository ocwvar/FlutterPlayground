import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/base/platform_control.dart';
import 'package:flutter_playground/base/theme_view_model.dart';
import 'package:flutter_playground/page/accessibility/view.dart';
import 'package:flutter_playground/page/demo_account/account_list/view.dart';
import 'package:flutter_playground/page/dynamic_list/view.dart';
import 'package:flutter_playground/page/language/view.dart';
import 'package:flutter_playground/page/platform/view.dart';
import 'package:flutter_playground/page/remote_image/view.dart';
import 'package:flutter_playground/page/system_info/view.dart';
import 'package:flutter_playground/widget/platform/app_bar.dart';
import 'package:flutter_playground/widget/platform/button.dart';
import 'package:flutter_playground/widget/platform/list_item.dart';
import 'package:flutter_playground/widget/platform/scaffold.dart';

import '../../widget/platform/base.dart';
import '../blur/view.dart';
import '../keep_state/view.dart';
import '../text_styles/view.dart';
import 'model.dart';

class HomeView extends StatefulWidget {

  final ThemeViewModel _viewModel;

  const HomeView(this._viewModel, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    final HomeModel model = HomeModel();

    return PlatformScaffold(
      isiOSLargeStyle: true,
      platformAppBar: PlatformAppBar(
          context: context,
          title: "Home",
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

              // functions list
              Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8),
                  child: Text("Functions list", style: getNullablePlatformObject<TextStyle>(
                      forAndroid: Theme.of(context).textTheme.titleMedium,
                      forIOS: CupertinoTheme.of(context).textTheme.textStyle
                  ))
              ),
              ListView.builder(
                  padding: const EdgeInsets.all(12),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) => createPageListView(context, model, index),
                  itemCount: model.pages.length
              )
            ]
        ),
      ),
    );
  }

  /// on user clicked day-night control buttons
  /// @param [DayNightType]
  void onClickDayNightButton(DayNightType type) {
    widget._viewModel.changeType(type);
  }

  /// on user clicked platform version control buttons
  /// @param [PlatformVersion]
  void onClickPlatformVersionButton(PlatformVersion platformVersion) {
    widget._viewModel.setPlatformVersion(platformVersion);
  }

  /// Theme color control buttons panel
  /// @return [Widget]
  Widget createThemeColorPanel(BuildContext context) {
    Widget wrapCard(Color targetColor) {
      return PlatformButton(
          onPressed: () => widget._viewModel.changeThemeColor(targetColor, true),
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

    final DayNightType currentType = widget._viewModel.currentType;

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

  /// get list item widget to display
  /// @return [Widget] of list item
  Widget createPageListView(BuildContext context, HomeModel model, int index) {

    /// find a [Widget] page is match given [PageType]
    /// @return [Widget] maybe NULL if not matching
    Widget? findPageByType(PageType type) {
      switch (type) {
        case PageType.textStyles:
          return const TextStylesView();

        case PageType.systemInfo:
          return const SystemInfoView();

        case PageType.dynamicList:
          return const DynamicListView();

        case PageType.remoteImage:
          return const RemoteImageView();

        case PageType.multiLanguage:
          return LanguageView();

        case PageType.platformSpecific:
          return const PlatformCodeView();

        case PageType.accessibility:
          return const AccessibilityView();

        case PageType.keepState:
          return const KeepStateView();

        case PageType.blur:
          return const BlurDemoView();

        case PageType.accountList:
          return const AccountListView();

        default:
          return null;
      }
    }

    final PageModel pageModel = model.pages[index];
    final Widget? page = findPageByType(pageModel.pageType);

    // if cant find matching page, will not pass click event to list item
    final Function() onClick = page == null ? (){} : () =>
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page))
    };

    return PlatformListItem(title: pageModel.title, onPressed: onClick);
  }
}
